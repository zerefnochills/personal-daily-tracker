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

@DriftDatabase(tables: [Goals, Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'lifeos.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
