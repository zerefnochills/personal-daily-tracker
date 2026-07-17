import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Goal hierarchy: day / week / month / year.
// parentGoalId lets a day-goal point up to the week-goal it ladders into, etc.
class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get type => text()(); // 'day' | 'week' | 'month' | 'year'
  IntColumn get parentGoalId => integer().nullable().references(Goals, #id)();
  DateTimeColumn get targetDate => dateTime().nullable()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get priority =>
      text().withDefault(const Constant('medium'))(); // low | medium | high
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  IntColumn get goalId => integer().nullable().references(Goals, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// ---- Phase 2: Discipline Engine ----

// A commitment is a recurring measurable objective, e.g. "Study" with a
// daily target of 60 minutes. Progress is tracked via timed sessions,
// not manual checkboxes.
class Commitments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get type =>
      text()(); // study | workout | read | code | custom
  IntColumn get targetMinutes => integer()(); // daily target
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Timestamp-based session tracking: start/stop times are the source of
// truth, so elapsed time survives the app being killed mid-session —
// no live ticking timer to keep alive in the background. On reopen, an
// "open" session (endTime == null) is resumed by just computing
// now - startTime.
class CommitmentSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get commitmentId =>
      integer().references(Commitments, #id)();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
}

// Global pool: 4 passes/month shared across all commitments (not 4 per
// commitment). Using a pass on a given commitment+date protects that
// commitment's streak for that day without requiring the daily target
// to have been met.
class LifePassUsage extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get commitmentId =>
      integer().references(Commitments, #id)();
  DateTimeColumn get dateUsed => dateTime()();
}

// Rewards unlock when a commitment's current streak reaches
// streakTargetDays. Unlocking is computed dynamically (not stored);
// isClaimed/claimedAt record the user manually cashing it in.
class Rewards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get commitmentId =>
      integer().nullable().references(Commitments, #id)();
  IntColumn get streakTargetDays => integer()();
  BoolColumn get isClaimed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get claimedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
    tables: [Goals, Tasks, Commitments, CommitmentSessions, LifePassUsage, Rewards])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(commitments);
            await m.createTable(commitmentSessions);
            await m.createTable(lifePassUsage);
            await m.createTable(rewards);
          }
        },
      );

  // ---- Goals ----
  Future<int> addGoal(GoalsCompanion goal) => into(goals).insert(goal);
  Future<bool> updateGoal(Goal goal) => update(goals).replace(goal);
  Future<int> deleteGoal(int id) =>
      (delete(goals)..where((g) => g.id.equals(id))).go();
  Stream<List<Goal>> watchGoalsByType(String type) =>
      (select(goals)..where((g) => g.type.equals(type))).watch();
  Stream<List<Goal>> watchAllGoals() => select(goals).watch();

  // ---- Tasks ----
  Future<int> addTask(TasksCompanion task) => into(tasks).insert(task);
  Future<bool> updateTask(Task task) => update(tasks).replace(task);
  Future<int> deleteTask(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();

  Stream<List<Task>> watchTodayTasks() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return (select(tasks)
          ..where((t) =>
              t.dueDate.isBiggerOrEqualValue(startOfDay) &
              t.dueDate.isSmallerThanValue(endOfDay)))
        .watch();
  }

  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  // ---- Commitments ----
  Future<int> addCommitment(CommitmentsCompanion c) =>
      into(commitments).insert(c);
  Future<int> deactivateCommitment(int id) => (update(commitments)
        ..where((c) => c.id.equals(id)))
      .write(const CommitmentsCompanion(isActive: Value(false)));
  Stream<List<Commitment>> watchActiveCommitments() =>
      (select(commitments)..where((c) => c.isActive.equals(true))).watch();

  // ---- Sessions ----
  // Guard against overlapping sessions for the same commitment: check
  // for an open session before starting a new one at the call site.
  Future<int> startSession(int commitmentId) => into(commitmentSessions)
      .insert(CommitmentSessionsCompanion(
    commitmentId: Value(commitmentId),
    startTime: Value(DateTime.now()),
  ));

  Future<int> stopSession(int sessionId) =>
      (update(commitmentSessions)..where((s) => s.id.equals(sessionId)))
          .write(CommitmentSessionsCompanion(endTime: Value(DateTime.now())));

  // Returns the currently-running session for a commitment, if any.
  // Used to restore timer state after the app is reopened.
  Stream<CommitmentSession?> watchOpenSession(int commitmentId) {
    final q = select(commitmentSessions)
      ..where((s) =>
          s.commitmentId.equals(commitmentId) & s.endTime.isNull());
    return q.watchSingleOrNull();
  }

  Future<List<CommitmentSession>> sessionsOnDate(
      int commitmentId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(commitmentSessions)
          ..where((s) =>
              s.commitmentId.equals(commitmentId) &
              s.startTime.isBiggerOrEqualValue(start) &
              s.startTime.isSmallerThanValue(end)))
        .get();
  }

  // ---- Life Passes ----
  Future<int> monthlyLifePassesUsed(int year, int month) async {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);
    final rows = await (select(lifePassUsage)
          ..where((l) =>
              l.dateUsed.isBiggerOrEqualValue(start) &
              l.dateUsed.isSmallerThanValue(end)))
        .get();
    return rows.length;
  }

  Future<int> useLifePass(int commitmentId, DateTime date) =>
      into(lifePassUsage).insert(LifePassUsageCompanion(
        commitmentId: Value(commitmentId),
        dateUsed: Value(date),
      ));

  Future<bool> passUsedOnDate(int commitmentId, DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final rows = await (select(lifePassUsage)
          ..where((l) =>
              l.commitmentId.equals(commitmentId) &
              l.dateUsed.isBiggerOrEqualValue(start) &
              l.dateUsed.isSmallerThanValue(end)))
        .get();
    return rows.isNotEmpty;
  }

  // ---- Rewards ----
  Future<int> addReward(RewardsCompanion r) => into(rewards).insert(r);
  Stream<List<Reward>> watchAllRewards() => select(rewards).watch();
  Future<int> claimReward(int id) => (update(rewards)
        ..where((r) => r.id.equals(id)))
      .write(RewardsCompanion(
    isClaimed: const Value(true),
    claimedAt: Value(DateTime.now()),
  ));
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'lifeos.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
