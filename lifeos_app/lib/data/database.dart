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

// ---- Phase 3: Fitness + Finance ----

class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get muscleGroup => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class WorkoutEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get sets => integer()();
  IntColumn get reps => integer()();
  RealColumn get weightKg => real()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Static weekly plan, not tied to a specific calendar date — it repeats
// every week. dayOfWeek: 0=Monday .. 6=Sunday.
class DietPlanEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dayOfWeek => integer()();
  TextColumn get mealType => text()(); // breakfast | lunch | dinner | snack
  TextColumn get description => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// One row per (year, month) — enforced in the DAO via upsert logic rather
// than a DB-level unique constraint, to keep the schema simple.
class MonthlyIncome extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get year => integer()();
  IntColumn get month => integer()();
  RealColumn get amount => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get amount => real()();
  TextColumn get category => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// ---- Phase 4: Vaults ----

// Founder Vault and Knowledge Vault share the same shape — freeform
// entries with tags, differentiated only by vaultType. Search is plain
// SQL LIKE across title/content/tags rather than SQLite FTS5, to avoid
// the extra virtual-table migration complexity for what's currently a
// personal, low-volume dataset.
class VaultEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get vaultType => text()(); // 'founder' | 'knowledge'
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get tags => text().withDefault(const Constant(''))(); // comma-separated
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [
  Goals,
  Tasks,
  Commitments,
  CommitmentSessions,
  LifePassUsage,
  Rewards,
  Exercises,
  WorkoutEntries,
  DietPlanEntries,
  MonthlyIncome,
  Expenses,
  VaultEntries,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

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
          if (from < 3) {
            await m.createTable(exercises);
            await m.createTable(workoutEntries);
            await m.createTable(dietPlanEntries);
            await m.createTable(monthlyIncome);
            await m.createTable(expenses);
          }
          if (from < 4) {
            await m.createTable(vaultEntries);
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

  // ---- Fitness: Exercises ----
  Future<int> addExercise(ExercisesCompanion e) => into(exercises).insert(e);
  Stream<List<Exercise>> watchAllExercises() => select(exercises).watch();
  Future<int> deleteExercise(int id) =>
      (delete(exercises)..where((e) => e.id.equals(id))).go();

  // ---- Fitness: Workout Entries ----
  Future<int> addWorkoutEntry(WorkoutEntriesCompanion e) =>
      into(workoutEntries).insert(e);
  Stream<List<WorkoutEntry>> watchEntriesForExercise(int exerciseId) =>
      (select(workoutEntries)
            ..where((w) => w.exerciseId.equals(exerciseId))
            ..orderBy([(w) => OrderingTerm.desc(w.date)]))
          .watch();
  Future<int> deleteWorkoutEntry(int id) =>
      (delete(workoutEntries)..where((w) => w.id.equals(id))).go();

  /// Personal record (heaviest weight logged) for an exercise, or null if
  /// no entries yet.
  Future<double?> personalRecord(int exerciseId) async {
    final rows = await (select(workoutEntries)
          ..where((w) => w.exerciseId.equals(exerciseId)))
        .get();
    if (rows.isEmpty) return null;
    return rows.map((r) => r.weightKg).reduce((a, b) => a > b ? a : b);
  }

  // ---- Fitness: Diet Plan ----
  Future<int> addDietEntry(DietPlanEntriesCompanion e) =>
      into(dietPlanEntries).insert(e);
  Stream<List<DietPlanEntry>> watchDietForDay(int dayOfWeek) =>
      (select(dietPlanEntries)..where((d) => d.dayOfWeek.equals(dayOfWeek)))
          .watch();
  Future<int> deleteDietEntry(int id) =>
      (delete(dietPlanEntries)..where((d) => d.id.equals(id))).go();

  // ---- Finance: Monthly Income ----
  // Upsert by (year, month) since there's no DB-level unique constraint.
  Future<void> setMonthlyIncome(int year, int month, double amount) async {
    final existing = await (select(monthlyIncome)
          ..where((m) => m.year.equals(year) & m.month.equals(month)))
        .getSingleOrNull();
    if (existing == null) {
      await into(monthlyIncome).insert(MonthlyIncomeCompanion(
        year: Value(year),
        month: Value(month),
        amount: Value(amount),
      ));
    } else {
      await (update(monthlyIncome)..where((m) => m.id.equals(existing.id)))
          .write(MonthlyIncomeCompanion(amount: Value(amount)));
    }
  }

  Future<double> incomeForMonth(int year, int month) async {
    final row = await (select(monthlyIncome)
          ..where((m) => m.year.equals(year) & m.month.equals(month)))
        .getSingleOrNull();
    return row?.amount ?? 0;
  }

  // ---- Finance: Expenses ----
  Future<int> addExpense(ExpensesCompanion e) => into(expenses).insert(e);
  Future<int> deleteExpense(int id) =>
      (delete(expenses)..where((e) => e.id.equals(id))).go();

  Stream<List<Expense>> watchExpensesForMonth(int year, int month) {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);
    return (select(expenses)
          ..where((e) =>
              e.date.isBiggerOrEqualValue(start) &
              e.date.isSmallerThanValue(end))
          ..orderBy([(e) => OrderingTerm.desc(e.date)]))
        .watch();
  }

  // ---- Vaults ----
  Future<int> addVaultEntry(VaultEntriesCompanion e) =>
      into(vaultEntries).insert(e);

  Future<bool> updateVaultEntry(VaultEntry entry) =>
      update(vaultEntries).replace(entry);

  Future<int> deleteVaultEntry(int id) =>
      (delete(vaultEntries)..where((v) => v.id.equals(id))).go();

  Stream<List<VaultEntry>> watchVaultEntries(String vaultType) =>
      (select(vaultEntries)
            ..where((v) => v.vaultType.equals(vaultType))
            ..orderBy([(v) => OrderingTerm.desc(v.updatedAt)]))
          .watch();

  /// Plain LIKE search across title/content/tags — fine for a personal,
  /// low-volume vault. Revisit with FTS5 only if entry count grows large
  /// enough that this becomes noticeably slow.
  Stream<List<VaultEntry>> searchVaultEntries(String vaultType, String query) {
    final likeQuery = '%$query%';
    return (select(vaultEntries)
          ..where((v) =>
              v.vaultType.equals(vaultType) &
              (v.title.like(likeQuery) |
                  v.content.like(likeQuery) |
                  v.tags.like(likeQuery)))
          ..orderBy([(v) => OrderingTerm.desc(v.updatedAt)]))
        .watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'lifeos.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
