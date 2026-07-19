// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentGoalIdMeta =
      const VerificationMeta('parentGoalId');
  @override
  late final GeneratedColumn<int> parentGoalId = GeneratedColumn<int>(
      'parent_goal_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES goals (id)'));
  static const VerificationMeta _targetDateMeta =
      const VerificationMeta('targetDate');
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
      'target_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
      'is_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_done" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, type, parentGoalId, targetDate, isDone, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(Insertable<Goal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('parent_goal_id')) {
      context.handle(
          _parentGoalIdMeta,
          parentGoalId.isAcceptableOrUnknown(
              data['parent_goal_id']!, _parentGoalIdMeta));
    }
    if (data.containsKey('target_date')) {
      context.handle(
          _targetDateMeta,
          targetDate.isAcceptableOrUnknown(
              data['target_date']!, _targetDateMeta));
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      parentGoalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_goal_id']),
      targetDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}target_date']),
      isDone: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_done'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  final int id;
  final String title;
  final String type;
  final int? parentGoalId;
  final DateTime? targetDate;
  final bool isDone;
  final DateTime createdAt;
  const Goal(
      {required this.id,
      required this.title,
      required this.type,
      this.parentGoalId,
      this.targetDate,
      required this.isDone,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || parentGoalId != null) {
      map['parent_goal_id'] = Variable<int>(parentGoalId);
    }
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    map['is_done'] = Variable<bool>(isDone);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      title: Value(title),
      type: Value(type),
      parentGoalId: parentGoalId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentGoalId),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      isDone: Value(isDone),
      createdAt: Value(createdAt),
    );
  }

  factory Goal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      parentGoalId: serializer.fromJson<int?>(json['parentGoalId']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'parentGoalId': serializer.toJson<int?>(parentGoalId),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'isDone': serializer.toJson<bool>(isDone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Goal copyWith(
          {int? id,
          String? title,
          String? type,
          Value<int?> parentGoalId = const Value.absent(),
          Value<DateTime?> targetDate = const Value.absent(),
          bool? isDone,
          DateTime? createdAt}) =>
      Goal(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        parentGoalId:
            parentGoalId.present ? parentGoalId.value : this.parentGoalId,
        targetDate: targetDate.present ? targetDate.value : this.targetDate,
        isDone: isDone ?? this.isDone,
        createdAt: createdAt ?? this.createdAt,
      );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      parentGoalId: data.parentGoalId.present
          ? data.parentGoalId.value
          : this.parentGoalId,
      targetDate:
          data.targetDate.present ? data.targetDate.value : this.targetDate,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('parentGoalId: $parentGoalId, ')
          ..write('targetDate: $targetDate, ')
          ..write('isDone: $isDone, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, type, parentGoalId, targetDate, isDone, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.title == this.title &&
          other.type == this.type &&
          other.parentGoalId == this.parentGoalId &&
          other.targetDate == this.targetDate &&
          other.isDone == this.isDone &&
          other.createdAt == this.createdAt);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> type;
  final Value<int?> parentGoalId;
  final Value<DateTime?> targetDate;
  final Value<bool> isDone;
  final Value<DateTime> createdAt;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.parentGoalId = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.isDone = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String type,
    this.parentGoalId = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.isDone = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : title = Value(title),
        type = Value(type);
  static Insertable<Goal> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? type,
    Expression<int>? parentGoalId,
    Expression<DateTime>? targetDate,
    Expression<bool>? isDone,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (parentGoalId != null) 'parent_goal_id': parentGoalId,
      if (targetDate != null) 'target_date': targetDate,
      if (isDone != null) 'is_done': isDone,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  GoalsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? type,
      Value<int?>? parentGoalId,
      Value<DateTime?>? targetDate,
      Value<bool>? isDone,
      Value<DateTime>? createdAt}) {
    return GoalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      parentGoalId: parentGoalId ?? this.parentGoalId,
      targetDate: targetDate ?? this.targetDate,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (parentGoalId.present) {
      map['parent_goal_id'] = Variable<int>(parentGoalId.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('parentGoalId: $parentGoalId, ')
          ..write('targetDate: $targetDate, ')
          ..write('isDone: $isDone, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('medium'));
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
      'is_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_done" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
      'goal_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES goals (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, dueDate, priority, isDone, goalId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      isDone: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_done'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final String priority;
  final bool isDone;
  final int? goalId;
  final DateTime createdAt;
  const Task(
      {required this.id,
      required this.title,
      this.description,
      this.dueDate,
      required this.priority,
      required this.isDone,
      this.goalId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['priority'] = Variable<String>(priority);
    map['is_done'] = Variable<bool>(isDone);
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<int>(goalId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      priority: Value(priority),
      isDone: Value(isDone),
      goalId:
          goalId == null && nullToAbsent ? const Value.absent() : Value(goalId),
      createdAt: Value(createdAt),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      priority: serializer.fromJson<String>(json['priority']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      goalId: serializer.fromJson<int?>(json['goalId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'priority': serializer.toJson<String>(priority),
      'isDone': serializer.toJson<bool>(isDone),
      'goalId': serializer.toJson<int?>(goalId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Task copyWith(
          {int? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<DateTime?> dueDate = const Value.absent(),
          String? priority,
          bool? isDone,
          Value<int?> goalId = const Value.absent(),
          DateTime? createdAt}) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        priority: priority ?? this.priority,
        isDone: isDone ?? this.isDone,
        goalId: goalId.present ? goalId.value : this.goalId,
        createdAt: createdAt ?? this.createdAt,
      );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      priority: data.priority.present ? data.priority.value : this.priority,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('isDone: $isDone, ')
          ..write('goalId: $goalId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, description, dueDate, priority, isDone, goalId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.dueDate == this.dueDate &&
          other.priority == this.priority &&
          other.isDone == this.isDone &&
          other.goalId == this.goalId &&
          other.createdAt == this.createdAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime?> dueDate;
  final Value<String> priority;
  final Value<bool> isDone;
  final Value<int?> goalId;
  final Value<DateTime> createdAt;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.isDone = const Value.absent(),
    this.goalId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.priority = const Value.absent(),
    this.isDone = const Value.absent(),
    this.goalId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? dueDate,
    Expression<String>? priority,
    Expression<bool>? isDone,
    Expression<int>? goalId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (dueDate != null) 'due_date': dueDate,
      if (priority != null) 'priority': priority,
      if (isDone != null) 'is_done': isDone,
      if (goalId != null) 'goal_id': goalId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<DateTime?>? dueDate,
      Value<String>? priority,
      Value<bool>? isDone,
      Value<int?>? goalId,
      Value<DateTime>? createdAt}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
      goalId: goalId ?? this.goalId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dueDate: $dueDate, ')
          ..write('priority: $priority, ')
          ..write('isDone: $isDone, ')
          ..write('goalId: $goalId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CommitmentsTable extends Commitments
    with TableInfo<$CommitmentsTable, Commitment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommitmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetMinutesMeta =
      const VerificationMeta('targetMinutes');
  @override
  late final GeneratedColumn<int> targetMinutes = GeneratedColumn<int>(
      'target_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, type, targetMinutes, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'commitments';
  @override
  VerificationContext validateIntegrity(Insertable<Commitment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('target_minutes')) {
      context.handle(
          _targetMinutesMeta,
          targetMinutes.isAcceptableOrUnknown(
              data['target_minutes']!, _targetMinutesMeta));
    } else if (isInserting) {
      context.missing(_targetMinutesMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Commitment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Commitment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      targetMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_minutes'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CommitmentsTable createAlias(String alias) {
    return $CommitmentsTable(attachedDatabase, alias);
  }
}

class Commitment extends DataClass implements Insertable<Commitment> {
  final int id;
  final String title;
  final String type;
  final int targetMinutes;
  final bool isActive;
  final DateTime createdAt;
  const Commitment(
      {required this.id,
      required this.title,
      required this.type,
      required this.targetMinutes,
      required this.isActive,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['type'] = Variable<String>(type);
    map['target_minutes'] = Variable<int>(targetMinutes);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CommitmentsCompanion toCompanion(bool nullToAbsent) {
    return CommitmentsCompanion(
      id: Value(id),
      title: Value(title),
      type: Value(type),
      targetMinutes: Value(targetMinutes),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Commitment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Commitment(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<String>(json['type']),
      targetMinutes: serializer.fromJson<int>(json['targetMinutes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<String>(type),
      'targetMinutes': serializer.toJson<int>(targetMinutes),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Commitment copyWith(
          {int? id,
          String? title,
          String? type,
          int? targetMinutes,
          bool? isActive,
          DateTime? createdAt}) =>
      Commitment(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        targetMinutes: targetMinutes ?? this.targetMinutes,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );
  Commitment copyWithCompanion(CommitmentsCompanion data) {
    return Commitment(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      type: data.type.present ? data.type.value : this.type,
      targetMinutes: data.targetMinutes.present
          ? data.targetMinutes.value
          : this.targetMinutes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Commitment(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('targetMinutes: $targetMinutes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, type, targetMinutes, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Commitment &&
          other.id == this.id &&
          other.title == this.title &&
          other.type == this.type &&
          other.targetMinutes == this.targetMinutes &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class CommitmentsCompanion extends UpdateCompanion<Commitment> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> type;
  final Value<int> targetMinutes;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const CommitmentsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.targetMinutes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CommitmentsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String type,
    required int targetMinutes,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : title = Value(title),
        type = Value(type),
        targetMinutes = Value(targetMinutes);
  static Insertable<Commitment> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? type,
    Expression<int>? targetMinutes,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (targetMinutes != null) 'target_minutes': targetMinutes,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CommitmentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? type,
      Value<int>? targetMinutes,
      Value<bool>? isActive,
      Value<DateTime>? createdAt}) {
    return CommitmentsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      targetMinutes: targetMinutes ?? this.targetMinutes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (targetMinutes.present) {
      map['target_minutes'] = Variable<int>(targetMinutes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommitmentsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('targetMinutes: $targetMinutes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CommitmentSessionsTable extends CommitmentSessions
    with TableInfo<$CommitmentSessionsTable, CommitmentSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommitmentSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _commitmentIdMeta =
      const VerificationMeta('commitmentId');
  @override
  late final GeneratedColumn<int> commitmentId = GeneratedColumn<int>(
      'commitment_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES commitments (id)'));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, commitmentId, startTime, endTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'commitment_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<CommitmentSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('commitment_id')) {
      context.handle(
          _commitmentIdMeta,
          commitmentId.isAcceptableOrUnknown(
              data['commitment_id']!, _commitmentIdMeta));
    } else if (isInserting) {
      context.missing(_commitmentIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommitmentSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommitmentSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      commitmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}commitment_id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
    );
  }

  @override
  $CommitmentSessionsTable createAlias(String alias) {
    return $CommitmentSessionsTable(attachedDatabase, alias);
  }
}

class CommitmentSession extends DataClass
    implements Insertable<CommitmentSession> {
  final int id;
  final int commitmentId;
  final DateTime startTime;
  final DateTime? endTime;
  const CommitmentSession(
      {required this.id,
      required this.commitmentId,
      required this.startTime,
      this.endTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['commitment_id'] = Variable<int>(commitmentId);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    return map;
  }

  CommitmentSessionsCompanion toCompanion(bool nullToAbsent) {
    return CommitmentSessionsCompanion(
      id: Value(id),
      commitmentId: Value(commitmentId),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
    );
  }

  factory CommitmentSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommitmentSession(
      id: serializer.fromJson<int>(json['id']),
      commitmentId: serializer.fromJson<int>(json['commitmentId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'commitmentId': serializer.toJson<int>(commitmentId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
    };
  }

  CommitmentSession copyWith(
          {int? id,
          int? commitmentId,
          DateTime? startTime,
          Value<DateTime?> endTime = const Value.absent()}) =>
      CommitmentSession(
        id: id ?? this.id,
        commitmentId: commitmentId ?? this.commitmentId,
        startTime: startTime ?? this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
      );
  CommitmentSession copyWithCompanion(CommitmentSessionsCompanion data) {
    return CommitmentSession(
      id: data.id.present ? data.id.value : this.id,
      commitmentId: data.commitmentId.present
          ? data.commitmentId.value
          : this.commitmentId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommitmentSession(')
          ..write('id: $id, ')
          ..write('commitmentId: $commitmentId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, commitmentId, startTime, endTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommitmentSession &&
          other.id == this.id &&
          other.commitmentId == this.commitmentId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime);
}

class CommitmentSessionsCompanion extends UpdateCompanion<CommitmentSession> {
  final Value<int> id;
  final Value<int> commitmentId;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  const CommitmentSessionsCompanion({
    this.id = const Value.absent(),
    this.commitmentId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  });
  CommitmentSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int commitmentId,
    required DateTime startTime,
    this.endTime = const Value.absent(),
  })  : commitmentId = Value(commitmentId),
        startTime = Value(startTime);
  static Insertable<CommitmentSession> custom({
    Expression<int>? id,
    Expression<int>? commitmentId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (commitmentId != null) 'commitment_id': commitmentId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
    });
  }

  CommitmentSessionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? commitmentId,
      Value<DateTime>? startTime,
      Value<DateTime?>? endTime}) {
    return CommitmentSessionsCompanion(
      id: id ?? this.id,
      commitmentId: commitmentId ?? this.commitmentId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (commitmentId.present) {
      map['commitment_id'] = Variable<int>(commitmentId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommitmentSessionsCompanion(')
          ..write('id: $id, ')
          ..write('commitmentId: $commitmentId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }
}

class $LifePassUsageTable extends LifePassUsage
    with TableInfo<$LifePassUsageTable, LifePassUsageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LifePassUsageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _commitmentIdMeta =
      const VerificationMeta('commitmentId');
  @override
  late final GeneratedColumn<int> commitmentId = GeneratedColumn<int>(
      'commitment_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES commitments (id)'));
  static const VerificationMeta _dateUsedMeta =
      const VerificationMeta('dateUsed');
  @override
  late final GeneratedColumn<DateTime> dateUsed = GeneratedColumn<DateTime>(
      'date_used', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, commitmentId, dateUsed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'life_pass_usage';
  @override
  VerificationContext validateIntegrity(Insertable<LifePassUsageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('commitment_id')) {
      context.handle(
          _commitmentIdMeta,
          commitmentId.isAcceptableOrUnknown(
              data['commitment_id']!, _commitmentIdMeta));
    } else if (isInserting) {
      context.missing(_commitmentIdMeta);
    }
    if (data.containsKey('date_used')) {
      context.handle(_dateUsedMeta,
          dateUsed.isAcceptableOrUnknown(data['date_used']!, _dateUsedMeta));
    } else if (isInserting) {
      context.missing(_dateUsedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LifePassUsageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LifePassUsageData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      commitmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}commitment_id'])!,
      dateUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_used'])!,
    );
  }

  @override
  $LifePassUsageTable createAlias(String alias) {
    return $LifePassUsageTable(attachedDatabase, alias);
  }
}

class LifePassUsageData extends DataClass
    implements Insertable<LifePassUsageData> {
  final int id;
  final int commitmentId;
  final DateTime dateUsed;
  const LifePassUsageData(
      {required this.id, required this.commitmentId, required this.dateUsed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['commitment_id'] = Variable<int>(commitmentId);
    map['date_used'] = Variable<DateTime>(dateUsed);
    return map;
  }

  LifePassUsageCompanion toCompanion(bool nullToAbsent) {
    return LifePassUsageCompanion(
      id: Value(id),
      commitmentId: Value(commitmentId),
      dateUsed: Value(dateUsed),
    );
  }

  factory LifePassUsageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LifePassUsageData(
      id: serializer.fromJson<int>(json['id']),
      commitmentId: serializer.fromJson<int>(json['commitmentId']),
      dateUsed: serializer.fromJson<DateTime>(json['dateUsed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'commitmentId': serializer.toJson<int>(commitmentId),
      'dateUsed': serializer.toJson<DateTime>(dateUsed),
    };
  }

  LifePassUsageData copyWith(
          {int? id, int? commitmentId, DateTime? dateUsed}) =>
      LifePassUsageData(
        id: id ?? this.id,
        commitmentId: commitmentId ?? this.commitmentId,
        dateUsed: dateUsed ?? this.dateUsed,
      );
  LifePassUsageData copyWithCompanion(LifePassUsageCompanion data) {
    return LifePassUsageData(
      id: data.id.present ? data.id.value : this.id,
      commitmentId: data.commitmentId.present
          ? data.commitmentId.value
          : this.commitmentId,
      dateUsed: data.dateUsed.present ? data.dateUsed.value : this.dateUsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LifePassUsageData(')
          ..write('id: $id, ')
          ..write('commitmentId: $commitmentId, ')
          ..write('dateUsed: $dateUsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, commitmentId, dateUsed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LifePassUsageData &&
          other.id == this.id &&
          other.commitmentId == this.commitmentId &&
          other.dateUsed == this.dateUsed);
}

class LifePassUsageCompanion extends UpdateCompanion<LifePassUsageData> {
  final Value<int> id;
  final Value<int> commitmentId;
  final Value<DateTime> dateUsed;
  const LifePassUsageCompanion({
    this.id = const Value.absent(),
    this.commitmentId = const Value.absent(),
    this.dateUsed = const Value.absent(),
  });
  LifePassUsageCompanion.insert({
    this.id = const Value.absent(),
    required int commitmentId,
    required DateTime dateUsed,
  })  : commitmentId = Value(commitmentId),
        dateUsed = Value(dateUsed);
  static Insertable<LifePassUsageData> custom({
    Expression<int>? id,
    Expression<int>? commitmentId,
    Expression<DateTime>? dateUsed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (commitmentId != null) 'commitment_id': commitmentId,
      if (dateUsed != null) 'date_used': dateUsed,
    });
  }

  LifePassUsageCompanion copyWith(
      {Value<int>? id, Value<int>? commitmentId, Value<DateTime>? dateUsed}) {
    return LifePassUsageCompanion(
      id: id ?? this.id,
      commitmentId: commitmentId ?? this.commitmentId,
      dateUsed: dateUsed ?? this.dateUsed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (commitmentId.present) {
      map['commitment_id'] = Variable<int>(commitmentId.value);
    }
    if (dateUsed.present) {
      map['date_used'] = Variable<DateTime>(dateUsed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LifePassUsageCompanion(')
          ..write('id: $id, ')
          ..write('commitmentId: $commitmentId, ')
          ..write('dateUsed: $dateUsed')
          ..write(')'))
        .toString();
  }
}

class $RewardsTable extends Rewards with TableInfo<$RewardsTable, Reward> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RewardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _commitmentIdMeta =
      const VerificationMeta('commitmentId');
  @override
  late final GeneratedColumn<int> commitmentId = GeneratedColumn<int>(
      'commitment_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES commitments (id)'));
  static const VerificationMeta _streakTargetDaysMeta =
      const VerificationMeta('streakTargetDays');
  @override
  late final GeneratedColumn<int> streakTargetDays = GeneratedColumn<int>(
      'streak_target_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isClaimedMeta =
      const VerificationMeta('isClaimed');
  @override
  late final GeneratedColumn<bool> isClaimed = GeneratedColumn<bool>(
      'is_claimed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_claimed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _claimedAtMeta =
      const VerificationMeta('claimedAt');
  @override
  late final GeneratedColumn<DateTime> claimedAt = GeneratedColumn<DateTime>(
      'claimed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        commitmentId,
        streakTargetDays,
        isClaimed,
        claimedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rewards';
  @override
  VerificationContext validateIntegrity(Insertable<Reward> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('commitment_id')) {
      context.handle(
          _commitmentIdMeta,
          commitmentId.isAcceptableOrUnknown(
              data['commitment_id']!, _commitmentIdMeta));
    }
    if (data.containsKey('streak_target_days')) {
      context.handle(
          _streakTargetDaysMeta,
          streakTargetDays.isAcceptableOrUnknown(
              data['streak_target_days']!, _streakTargetDaysMeta));
    } else if (isInserting) {
      context.missing(_streakTargetDaysMeta);
    }
    if (data.containsKey('is_claimed')) {
      context.handle(_isClaimedMeta,
          isClaimed.isAcceptableOrUnknown(data['is_claimed']!, _isClaimedMeta));
    }
    if (data.containsKey('claimed_at')) {
      context.handle(_claimedAtMeta,
          claimedAt.isAcceptableOrUnknown(data['claimed_at']!, _claimedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reward map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reward(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      commitmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}commitment_id']),
      streakTargetDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}streak_target_days'])!,
      isClaimed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_claimed'])!,
      claimedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}claimed_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RewardsTable createAlias(String alias) {
    return $RewardsTable(attachedDatabase, alias);
  }
}

class Reward extends DataClass implements Insertable<Reward> {
  final int id;
  final String title;
  final int? commitmentId;
  final int streakTargetDays;
  final bool isClaimed;
  final DateTime? claimedAt;
  final DateTime createdAt;
  const Reward(
      {required this.id,
      required this.title,
      this.commitmentId,
      required this.streakTargetDays,
      required this.isClaimed,
      this.claimedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || commitmentId != null) {
      map['commitment_id'] = Variable<int>(commitmentId);
    }
    map['streak_target_days'] = Variable<int>(streakTargetDays);
    map['is_claimed'] = Variable<bool>(isClaimed);
    if (!nullToAbsent || claimedAt != null) {
      map['claimed_at'] = Variable<DateTime>(claimedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RewardsCompanion toCompanion(bool nullToAbsent) {
    return RewardsCompanion(
      id: Value(id),
      title: Value(title),
      commitmentId: commitmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(commitmentId),
      streakTargetDays: Value(streakTargetDays),
      isClaimed: Value(isClaimed),
      claimedAt: claimedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(claimedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Reward.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reward(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      commitmentId: serializer.fromJson<int?>(json['commitmentId']),
      streakTargetDays: serializer.fromJson<int>(json['streakTargetDays']),
      isClaimed: serializer.fromJson<bool>(json['isClaimed']),
      claimedAt: serializer.fromJson<DateTime?>(json['claimedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'commitmentId': serializer.toJson<int?>(commitmentId),
      'streakTargetDays': serializer.toJson<int>(streakTargetDays),
      'isClaimed': serializer.toJson<bool>(isClaimed),
      'claimedAt': serializer.toJson<DateTime?>(claimedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Reward copyWith(
          {int? id,
          String? title,
          Value<int?> commitmentId = const Value.absent(),
          int? streakTargetDays,
          bool? isClaimed,
          Value<DateTime?> claimedAt = const Value.absent(),
          DateTime? createdAt}) =>
      Reward(
        id: id ?? this.id,
        title: title ?? this.title,
        commitmentId:
            commitmentId.present ? commitmentId.value : this.commitmentId,
        streakTargetDays: streakTargetDays ?? this.streakTargetDays,
        isClaimed: isClaimed ?? this.isClaimed,
        claimedAt: claimedAt.present ? claimedAt.value : this.claimedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  Reward copyWithCompanion(RewardsCompanion data) {
    return Reward(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      commitmentId: data.commitmentId.present
          ? data.commitmentId.value
          : this.commitmentId,
      streakTargetDays: data.streakTargetDays.present
          ? data.streakTargetDays.value
          : this.streakTargetDays,
      isClaimed: data.isClaimed.present ? data.isClaimed.value : this.isClaimed,
      claimedAt: data.claimedAt.present ? data.claimedAt.value : this.claimedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reward(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('commitmentId: $commitmentId, ')
          ..write('streakTargetDays: $streakTargetDays, ')
          ..write('isClaimed: $isClaimed, ')
          ..write('claimedAt: $claimedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, commitmentId, streakTargetDays,
      isClaimed, claimedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reward &&
          other.id == this.id &&
          other.title == this.title &&
          other.commitmentId == this.commitmentId &&
          other.streakTargetDays == this.streakTargetDays &&
          other.isClaimed == this.isClaimed &&
          other.claimedAt == this.claimedAt &&
          other.createdAt == this.createdAt);
}

class RewardsCompanion extends UpdateCompanion<Reward> {
  final Value<int> id;
  final Value<String> title;
  final Value<int?> commitmentId;
  final Value<int> streakTargetDays;
  final Value<bool> isClaimed;
  final Value<DateTime?> claimedAt;
  final Value<DateTime> createdAt;
  const RewardsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.commitmentId = const Value.absent(),
    this.streakTargetDays = const Value.absent(),
    this.isClaimed = const Value.absent(),
    this.claimedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RewardsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.commitmentId = const Value.absent(),
    required int streakTargetDays,
    this.isClaimed = const Value.absent(),
    this.claimedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : title = Value(title),
        streakTargetDays = Value(streakTargetDays);
  static Insertable<Reward> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? commitmentId,
    Expression<int>? streakTargetDays,
    Expression<bool>? isClaimed,
    Expression<DateTime>? claimedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (commitmentId != null) 'commitment_id': commitmentId,
      if (streakTargetDays != null) 'streak_target_days': streakTargetDays,
      if (isClaimed != null) 'is_claimed': isClaimed,
      if (claimedAt != null) 'claimed_at': claimedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RewardsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int?>? commitmentId,
      Value<int>? streakTargetDays,
      Value<bool>? isClaimed,
      Value<DateTime?>? claimedAt,
      Value<DateTime>? createdAt}) {
    return RewardsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      commitmentId: commitmentId ?? this.commitmentId,
      streakTargetDays: streakTargetDays ?? this.streakTargetDays,
      isClaimed: isClaimed ?? this.isClaimed,
      claimedAt: claimedAt ?? this.claimedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (commitmentId.present) {
      map['commitment_id'] = Variable<int>(commitmentId.value);
    }
    if (streakTargetDays.present) {
      map['streak_target_days'] = Variable<int>(streakTargetDays.value);
    }
    if (isClaimed.present) {
      map['is_claimed'] = Variable<bool>(isClaimed.value);
    }
    if (claimedAt.present) {
      map['claimed_at'] = Variable<DateTime>(claimedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RewardsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('commitmentId: $commitmentId, ')
          ..write('streakTargetDays: $streakTargetDays, ')
          ..write('isClaimed: $isClaimed, ')
          ..write('claimedAt: $claimedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _muscleGroupMeta =
      const VerificationMeta('muscleGroup');
  @override
  late final GeneratedColumn<String> muscleGroup = GeneratedColumn<String>(
      'muscle_group', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, name, muscleGroup, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(Insertable<Exercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('muscle_group')) {
      context.handle(
          _muscleGroupMeta,
          muscleGroup.isAcceptableOrUnknown(
              data['muscle_group']!, _muscleGroupMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      muscleGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}muscle_group']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final int id;
  final String name;
  final String? muscleGroup;
  final DateTime createdAt;
  const Exercise(
      {required this.id,
      required this.name,
      this.muscleGroup,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || muscleGroup != null) {
      map['muscle_group'] = Variable<String>(muscleGroup);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      muscleGroup: muscleGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(muscleGroup),
      createdAt: Value(createdAt),
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      muscleGroup: serializer.fromJson<String?>(json['muscleGroup']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'muscleGroup': serializer.toJson<String?>(muscleGroup),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Exercise copyWith(
          {int? id,
          String? name,
          Value<String?> muscleGroup = const Value.absent(),
          DateTime? createdAt}) =>
      Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        muscleGroup: muscleGroup.present ? muscleGroup.value : this.muscleGroup,
        createdAt: createdAt ?? this.createdAt,
      );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      muscleGroup:
          data.muscleGroup.present ? data.muscleGroup.value : this.muscleGroup,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, muscleGroup, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.muscleGroup == this.muscleGroup &&
          other.createdAt == this.createdAt);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> muscleGroup;
  final Value<DateTime> createdAt;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.muscleGroup = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Exercise> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? muscleGroup,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExercisesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? muscleGroup,
      Value<DateTime>? createdAt}) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(muscleGroup.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WorkoutEntriesTable extends WorkoutEntries
    with TableInfo<$WorkoutEntriesTable, WorkoutEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exercises (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
      'sets', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, exerciseId, date, sets, reps, weightKg, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_entries';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('sets')) {
      context.handle(
          _setsMeta, sets.isAcceptableOrUnknown(data['sets']!, _setsMeta));
    } else if (isInserting) {
      context.missing(_setsMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      sets: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sets'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $WorkoutEntriesTable createAlias(String alias) {
    return $WorkoutEntriesTable(attachedDatabase, alias);
  }
}

class WorkoutEntry extends DataClass implements Insertable<WorkoutEntry> {
  final int id;
  final int exerciseId;
  final DateTime date;
  final int sets;
  final int reps;
  final double weightKg;
  final String? notes;
  final DateTime createdAt;
  const WorkoutEntry(
      {required this.id,
      required this.exerciseId,
      required this.date,
      required this.sets,
      required this.reps,
      required this.weightKg,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['date'] = Variable<DateTime>(date);
    map['sets'] = Variable<int>(sets);
    map['reps'] = Variable<int>(reps);
    map['weight_kg'] = Variable<double>(weightKg);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WorkoutEntriesCompanion toCompanion(bool nullToAbsent) {
    return WorkoutEntriesCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      date: Value(date),
      sets: Value(sets),
      reps: Value(reps),
      weightKg: Value(weightKg),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory WorkoutEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutEntry(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      date: serializer.fromJson<DateTime>(json['date']),
      sets: serializer.fromJson<int>(json['sets']),
      reps: serializer.fromJson<int>(json['reps']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'date': serializer.toJson<DateTime>(date),
      'sets': serializer.toJson<int>(sets),
      'reps': serializer.toJson<int>(reps),
      'weightKg': serializer.toJson<double>(weightKg),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WorkoutEntry copyWith(
          {int? id,
          int? exerciseId,
          DateTime? date,
          int? sets,
          int? reps,
          double? weightKg,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      WorkoutEntry(
        id: id ?? this.id,
        exerciseId: exerciseId ?? this.exerciseId,
        date: date ?? this.date,
        sets: sets ?? this.sets,
        reps: reps ?? this.reps,
        weightKg: weightKg ?? this.weightKg,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  WorkoutEntry copyWithCompanion(WorkoutEntriesCompanion data) {
    return WorkoutEntry(
      id: data.id.present ? data.id.value : this.id,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      date: data.date.present ? data.date.value : this.date,
      sets: data.sets.present ? data.sets.value : this.sets,
      reps: data.reps.present ? data.reps.value : this.reps,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutEntry(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('date: $date, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, exerciseId, date, sets, reps, weightKg, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutEntry &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.date == this.date &&
          other.sets == this.sets &&
          other.reps == this.reps &&
          other.weightKg == this.weightKg &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class WorkoutEntriesCompanion extends UpdateCompanion<WorkoutEntry> {
  final Value<int> id;
  final Value<int> exerciseId;
  final Value<DateTime> date;
  final Value<int> sets;
  final Value<int> reps;
  final Value<double> weightKg;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const WorkoutEntriesCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.date = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WorkoutEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseId,
    required DateTime date,
    required int sets,
    required int reps,
    required double weightKg,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : exerciseId = Value(exerciseId),
        date = Value(date),
        sets = Value(sets),
        reps = Value(reps),
        weightKg = Value(weightKg);
  static Insertable<WorkoutEntry> custom({
    Expression<int>? id,
    Expression<int>? exerciseId,
    Expression<DateTime>? date,
    Expression<int>? sets,
    Expression<int>? reps,
    Expression<double>? weightKg,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (date != null) 'date': date,
      if (sets != null) 'sets': sets,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weight_kg': weightKg,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WorkoutEntriesCompanion copyWith(
      {Value<int>? id,
      Value<int>? exerciseId,
      Value<DateTime>? date,
      Value<int>? sets,
      Value<int>? reps,
      Value<double>? weightKg,
      Value<String?>? notes,
      Value<DateTime>? createdAt}) {
    return WorkoutEntriesCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      date: date ?? this.date,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutEntriesCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('date: $date, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DietPlanEntriesTable extends DietPlanEntries
    with TableInfo<$DietPlanEntriesTable, DietPlanEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DietPlanEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dayOfWeekMeta =
      const VerificationMeta('dayOfWeek');
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
      'day_of_week', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _mealTypeMeta =
      const VerificationMeta('mealType');
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
      'meal_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, dayOfWeek, mealType, description, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diet_plan_entries';
  @override
  VerificationContext validateIntegrity(Insertable<DietPlanEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
          _dayOfWeekMeta,
          dayOfWeek.isAcceptableOrUnknown(
              data['day_of_week']!, _dayOfWeekMeta));
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(_mealTypeMeta,
          mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta));
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DietPlanEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DietPlanEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dayOfWeek: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_of_week'])!,
      mealType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meal_type'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DietPlanEntriesTable createAlias(String alias) {
    return $DietPlanEntriesTable(attachedDatabase, alias);
  }
}

class DietPlanEntry extends DataClass implements Insertable<DietPlanEntry> {
  final int id;
  final int dayOfWeek;
  final String mealType;
  final String description;
  final DateTime createdAt;
  const DietPlanEntry(
      {required this.id,
      required this.dayOfWeek,
      required this.mealType,
      required this.description,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['day_of_week'] = Variable<int>(dayOfWeek);
    map['meal_type'] = Variable<String>(mealType);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DietPlanEntriesCompanion toCompanion(bool nullToAbsent) {
    return DietPlanEntriesCompanion(
      id: Value(id),
      dayOfWeek: Value(dayOfWeek),
      mealType: Value(mealType),
      description: Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory DietPlanEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DietPlanEntry(
      id: serializer.fromJson<int>(json['id']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
      mealType: serializer.fromJson<String>(json['mealType']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
      'mealType': serializer.toJson<String>(mealType),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DietPlanEntry copyWith(
          {int? id,
          int? dayOfWeek,
          String? mealType,
          String? description,
          DateTime? createdAt}) =>
      DietPlanEntry(
        id: id ?? this.id,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        mealType: mealType ?? this.mealType,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
      );
  DietPlanEntry copyWithCompanion(DietPlanEntriesCompanion data) {
    return DietPlanEntry(
      id: data.id.present ? data.id.value : this.id,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DietPlanEntry(')
          ..write('id: $id, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('mealType: $mealType, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, dayOfWeek, mealType, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DietPlanEntry &&
          other.id == this.id &&
          other.dayOfWeek == this.dayOfWeek &&
          other.mealType == this.mealType &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class DietPlanEntriesCompanion extends UpdateCompanion<DietPlanEntry> {
  final Value<int> id;
  final Value<int> dayOfWeek;
  final Value<String> mealType;
  final Value<String> description;
  final Value<DateTime> createdAt;
  const DietPlanEntriesCompanion({
    this.id = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.mealType = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DietPlanEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int dayOfWeek,
    required String mealType,
    required String description,
    this.createdAt = const Value.absent(),
  })  : dayOfWeek = Value(dayOfWeek),
        mealType = Value(mealType),
        description = Value(description);
  static Insertable<DietPlanEntry> custom({
    Expression<int>? id,
    Expression<int>? dayOfWeek,
    Expression<String>? mealType,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (mealType != null) 'meal_type': mealType,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DietPlanEntriesCompanion copyWith(
      {Value<int>? id,
      Value<int>? dayOfWeek,
      Value<String>? mealType,
      Value<String>? description,
      Value<DateTime>? createdAt}) {
    return DietPlanEntriesCompanion(
      id: id ?? this.id,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      mealType: mealType ?? this.mealType,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DietPlanEntriesCompanion(')
          ..write('id: $id, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('mealType: $mealType, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MonthlyIncomeTable extends MonthlyIncome
    with TableInfo<$MonthlyIncomeTable, MonthlyIncomeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyIncomeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, year, month, amount, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_income';
  @override
  VerificationContext validateIntegrity(Insertable<MonthlyIncomeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonthlyIncomeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyIncomeData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MonthlyIncomeTable createAlias(String alias) {
    return $MonthlyIncomeTable(attachedDatabase, alias);
  }
}

class MonthlyIncomeData extends DataClass
    implements Insertable<MonthlyIncomeData> {
  final int id;
  final int year;
  final int month;
  final double amount;
  final DateTime createdAt;
  const MonthlyIncomeData(
      {required this.id,
      required this.year,
      required this.month,
      required this.amount,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    map['amount'] = Variable<double>(amount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MonthlyIncomeCompanion toCompanion(bool nullToAbsent) {
    return MonthlyIncomeCompanion(
      id: Value(id),
      year: Value(year),
      month: Value(month),
      amount: Value(amount),
      createdAt: Value(createdAt),
    );
  }

  factory MonthlyIncomeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyIncomeData(
      id: serializer.fromJson<int>(json['id']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      amount: serializer.fromJson<double>(json['amount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'amount': serializer.toJson<double>(amount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MonthlyIncomeData copyWith(
          {int? id,
          int? year,
          int? month,
          double? amount,
          DateTime? createdAt}) =>
      MonthlyIncomeData(
        id: id ?? this.id,
        year: year ?? this.year,
        month: month ?? this.month,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
      );
  MonthlyIncomeData copyWithCompanion(MonthlyIncomeCompanion data) {
    return MonthlyIncomeData(
      id: data.id.present ? data.id.value : this.id,
      year: data.year.present ? data.year.value : this.year,
      month: data.month.present ? data.month.value : this.month,
      amount: data.amount.present ? data.amount.value : this.amount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyIncomeData(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, year, month, amount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyIncomeData &&
          other.id == this.id &&
          other.year == this.year &&
          other.month == this.month &&
          other.amount == this.amount &&
          other.createdAt == this.createdAt);
}

class MonthlyIncomeCompanion extends UpdateCompanion<MonthlyIncomeData> {
  final Value<int> id;
  final Value<int> year;
  final Value<int> month;
  final Value<double> amount;
  final Value<DateTime> createdAt;
  const MonthlyIncomeCompanion({
    this.id = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MonthlyIncomeCompanion.insert({
    this.id = const Value.absent(),
    required int year,
    required int month,
    required double amount,
    this.createdAt = const Value.absent(),
  })  : year = Value(year),
        month = Value(month),
        amount = Value(amount);
  static Insertable<MonthlyIncomeData> custom({
    Expression<int>? id,
    Expression<int>? year,
    Expression<int>? month,
    Expression<double>? amount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (amount != null) 'amount': amount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MonthlyIncomeCompanion copyWith(
      {Value<int>? id,
      Value<int>? year,
      Value<int>? month,
      Value<double>? amount,
      Value<DateTime>? createdAt}) {
    return MonthlyIncomeCompanion(
      id: id ?? this.id,
      year: year ?? this.year,
      month: month ?? this.month,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyIncomeCompanion(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, amount, category, description, date, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final double amount;
  final String category;
  final String? description;
  final DateTime date;
  final DateTime createdAt;
  const Expense(
      {required this.id,
      required this.amount,
      required this.category,
      this.description,
      required this.date,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<double>(amount);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      amount: Value(amount),
      category: Value(category),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      date: Value(date),
      createdAt: Value(createdAt),
    );
  }

  factory Expense.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String?>(json['description']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String?>(description),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Expense copyWith(
          {int? id,
          double? amount,
          String? category,
          Value<String?> description = const Value.absent(),
          DateTime? date,
          DateTime? createdAt}) =>
      Expense(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        description: description.present ? description.value : this.description,
        date: date ?? this.date,
        createdAt: createdAt ?? this.createdAt,
      );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      category: data.category.present ? data.category.value : this.category,
      description:
          data.description.present ? data.description.value : this.description,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, amount, category, description, date, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.category == this.category &&
          other.description == this.description &&
          other.date == this.date &&
          other.createdAt == this.createdAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<double> amount;
  final Value<String> category;
  final Value<String?> description;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required double amount,
    required String category,
    this.description = const Value.absent(),
    required DateTime date,
    this.createdAt = const Value.absent(),
  })  : amount = Value(amount),
        category = Value(category),
        date = Value(date);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<double>? amount,
    Expression<String>? category,
    Expression<String>? description,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExpensesCompanion copyWith(
      {Value<int>? id,
      Value<double>? amount,
      Value<String>? category,
      Value<String?>? description,
      Value<DateTime>? date,
      Value<DateTime>? createdAt}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $VaultEntriesTable extends VaultEntries
    with TableInfo<$VaultEntriesTable, VaultEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaultEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _vaultTypeMeta =
      const VerificationMeta('vaultType');
  @override
  late final GeneratedColumn<String> vaultType = GeneratedColumn<String>(
      'vault_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, vaultType, title, content, tags, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vault_entries';
  @override
  VerificationContext validateIntegrity(Insertable<VaultEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vault_type')) {
      context.handle(_vaultTypeMeta,
          vaultType.isAcceptableOrUnknown(data['vault_type']!, _vaultTypeMeta));
    } else if (isInserting) {
      context.missing(_vaultTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VaultEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VaultEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      vaultType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vault_type'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $VaultEntriesTable createAlias(String alias) {
    return $VaultEntriesTable(attachedDatabase, alias);
  }
}

class VaultEntry extends DataClass implements Insertable<VaultEntry> {
  final int id;
  final String vaultType;
  final String title;
  final String content;
  final String tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  const VaultEntry(
      {required this.id,
      required this.vaultType,
      required this.title,
      required this.content,
      required this.tags,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vault_type'] = Variable<String>(vaultType);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['tags'] = Variable<String>(tags);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VaultEntriesCompanion toCompanion(bool nullToAbsent) {
    return VaultEntriesCompanion(
      id: Value(id),
      vaultType: Value(vaultType),
      title: Value(title),
      content: Value(content),
      tags: Value(tags),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory VaultEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VaultEntry(
      id: serializer.fromJson<int>(json['id']),
      vaultType: serializer.fromJson<String>(json['vaultType']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      tags: serializer.fromJson<String>(json['tags']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vaultType': serializer.toJson<String>(vaultType),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'tags': serializer.toJson<String>(tags),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  VaultEntry copyWith(
          {int? id,
          String? vaultType,
          String? title,
          String? content,
          String? tags,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      VaultEntry(
        id: id ?? this.id,
        vaultType: vaultType ?? this.vaultType,
        title: title ?? this.title,
        content: content ?? this.content,
        tags: tags ?? this.tags,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  VaultEntry copyWithCompanion(VaultEntriesCompanion data) {
    return VaultEntry(
      id: data.id.present ? data.id.value : this.id,
      vaultType: data.vaultType.present ? data.vaultType.value : this.vaultType,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      tags: data.tags.present ? data.tags.value : this.tags,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VaultEntry(')
          ..write('id: $id, ')
          ..write('vaultType: $vaultType, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, vaultType, title, content, tags, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VaultEntry &&
          other.id == this.id &&
          other.vaultType == this.vaultType &&
          other.title == this.title &&
          other.content == this.content &&
          other.tags == this.tags &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VaultEntriesCompanion extends UpdateCompanion<VaultEntry> {
  final Value<int> id;
  final Value<String> vaultType;
  final Value<String> title;
  final Value<String> content;
  final Value<String> tags;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const VaultEntriesCompanion({
    this.id = const Value.absent(),
    this.vaultType = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  VaultEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String vaultType,
    required String title,
    required String content,
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : vaultType = Value(vaultType),
        title = Value(title),
        content = Value(content);
  static Insertable<VaultEntry> custom({
    Expression<int>? id,
    Expression<String>? vaultType,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? tags,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vaultType != null) 'vault_type': vaultType,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (tags != null) 'tags': tags,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  VaultEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? vaultType,
      Value<String>? title,
      Value<String>? content,
      Value<String>? tags,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return VaultEntriesCompanion(
      id: id ?? this.id,
      vaultType: vaultType ?? this.vaultType,
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vaultType.present) {
      map['vault_type'] = Variable<String>(vaultType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaultEntriesCompanion(')
          ..write('id: $id, ')
          ..write('vaultType: $vaultType, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserProfileTable extends UserProfile
    with TableInfo<$UserProfileTable, UserProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfileTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nicknameMeta =
      const VerificationMeta('nickname');
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
      'nickname', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _avatarPathMeta =
      const VerificationMeta('avatarPath');
  @override
  late final GeneratedColumn<String> avatarPath = GeneratedColumn<String>(
      'avatar_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _memberSinceMeta =
      const VerificationMeta('memberSince');
  @override
  late final GeneratedColumn<DateTime> memberSince = GeneratedColumn<DateTime>(
      'member_since', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _reduceMotionMeta =
      const VerificationMeta('reduceMotion');
  @override
  late final GeneratedColumn<bool> reduceMotion = GeneratedColumn<bool>(
      'reduce_motion', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reduce_motion" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, nickname, avatarPath, memberSince, reduceMotion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfileData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    }
    if (data.containsKey('avatar_path')) {
      context.handle(
          _avatarPathMeta,
          avatarPath.isAcceptableOrUnknown(
              data['avatar_path']!, _avatarPathMeta));
    }
    if (data.containsKey('member_since')) {
      context.handle(
          _memberSinceMeta,
          memberSince.isAcceptableOrUnknown(
              data['member_since']!, _memberSinceMeta));
    }
    if (data.containsKey('reduce_motion')) {
      context.handle(
          _reduceMotionMeta,
          reduceMotion.isAcceptableOrUnknown(
              data['reduce_motion']!, _reduceMotionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nickname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nickname'])!,
      avatarPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_path']),
      memberSince: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}member_since'])!,
      reduceMotion: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}reduce_motion'])!,
    );
  }

  @override
  $UserProfileTable createAlias(String alias) {
    return $UserProfileTable(attachedDatabase, alias);
  }
}

class UserProfileData extends DataClass implements Insertable<UserProfileData> {
  final int id;
  final String nickname;
  final String? avatarPath;
  final DateTime memberSince;
  final bool reduceMotion;
  const UserProfileData(
      {required this.id,
      required this.nickname,
      this.avatarPath,
      required this.memberSince,
      required this.reduceMotion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nickname'] = Variable<String>(nickname);
    if (!nullToAbsent || avatarPath != null) {
      map['avatar_path'] = Variable<String>(avatarPath);
    }
    map['member_since'] = Variable<DateTime>(memberSince);
    map['reduce_motion'] = Variable<bool>(reduceMotion);
    return map;
  }

  UserProfileCompanion toCompanion(bool nullToAbsent) {
    return UserProfileCompanion(
      id: Value(id),
      nickname: Value(nickname),
      avatarPath: avatarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarPath),
      memberSince: Value(memberSince),
      reduceMotion: Value(reduceMotion),
    );
  }

  factory UserProfileData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileData(
      id: serializer.fromJson<int>(json['id']),
      nickname: serializer.fromJson<String>(json['nickname']),
      avatarPath: serializer.fromJson<String?>(json['avatarPath']),
      memberSince: serializer.fromJson<DateTime>(json['memberSince']),
      reduceMotion: serializer.fromJson<bool>(json['reduceMotion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nickname': serializer.toJson<String>(nickname),
      'avatarPath': serializer.toJson<String?>(avatarPath),
      'memberSince': serializer.toJson<DateTime>(memberSince),
      'reduceMotion': serializer.toJson<bool>(reduceMotion),
    };
  }

  UserProfileData copyWith(
          {int? id,
          String? nickname,
          Value<String?> avatarPath = const Value.absent(),
          DateTime? memberSince,
          bool? reduceMotion}) =>
      UserProfileData(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        avatarPath: avatarPath.present ? avatarPath.value : this.avatarPath,
        memberSince: memberSince ?? this.memberSince,
        reduceMotion: reduceMotion ?? this.reduceMotion,
      );
  UserProfileData copyWithCompanion(UserProfileCompanion data) {
    return UserProfileData(
      id: data.id.present ? data.id.value : this.id,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      avatarPath:
          data.avatarPath.present ? data.avatarPath.value : this.avatarPath,
      memberSince:
          data.memberSince.present ? data.memberSince.value : this.memberSince,
      reduceMotion: data.reduceMotion.present
          ? data.reduceMotion.value
          : this.reduceMotion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileData(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('memberSince: $memberSince, ')
          ..write('reduceMotion: $reduceMotion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nickname, avatarPath, memberSince, reduceMotion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileData &&
          other.id == this.id &&
          other.nickname == this.nickname &&
          other.avatarPath == this.avatarPath &&
          other.memberSince == this.memberSince &&
          other.reduceMotion == this.reduceMotion);
}

class UserProfileCompanion extends UpdateCompanion<UserProfileData> {
  final Value<int> id;
  final Value<String> nickname;
  final Value<String?> avatarPath;
  final Value<DateTime> memberSince;
  final Value<bool> reduceMotion;
  const UserProfileCompanion({
    this.id = const Value.absent(),
    this.nickname = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.memberSince = const Value.absent(),
    this.reduceMotion = const Value.absent(),
  });
  UserProfileCompanion.insert({
    this.id = const Value.absent(),
    this.nickname = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.memberSince = const Value.absent(),
    this.reduceMotion = const Value.absent(),
  });
  static Insertable<UserProfileData> custom({
    Expression<int>? id,
    Expression<String>? nickname,
    Expression<String>? avatarPath,
    Expression<DateTime>? memberSince,
    Expression<bool>? reduceMotion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nickname != null) 'nickname': nickname,
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (memberSince != null) 'member_since': memberSince,
      if (reduceMotion != null) 'reduce_motion': reduceMotion,
    });
  }

  UserProfileCompanion copyWith(
      {Value<int>? id,
      Value<String>? nickname,
      Value<String?>? avatarPath,
      Value<DateTime>? memberSince,
      Value<bool>? reduceMotion}) {
    return UserProfileCompanion(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      avatarPath: avatarPath ?? this.avatarPath,
      memberSince: memberSince ?? this.memberSince,
      reduceMotion: reduceMotion ?? this.reduceMotion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String>(avatarPath.value);
    }
    if (memberSince.present) {
      map['member_since'] = Variable<DateTime>(memberSince.value);
    }
    if (reduceMotion.present) {
      map['reduce_motion'] = Variable<bool>(reduceMotion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileCompanion(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('memberSince: $memberSince, ')
          ..write('reduceMotion: $reduceMotion')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $CommitmentsTable commitments = $CommitmentsTable(this);
  late final $CommitmentSessionsTable commitmentSessions =
      $CommitmentSessionsTable(this);
  late final $LifePassUsageTable lifePassUsage = $LifePassUsageTable(this);
  late final $RewardsTable rewards = $RewardsTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $WorkoutEntriesTable workoutEntries = $WorkoutEntriesTable(this);
  late final $DietPlanEntriesTable dietPlanEntries =
      $DietPlanEntriesTable(this);
  late final $MonthlyIncomeTable monthlyIncome = $MonthlyIncomeTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $VaultEntriesTable vaultEntries = $VaultEntriesTable(this);
  late final $UserProfileTable userProfile = $UserProfileTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        goals,
        tasks,
        commitments,
        commitmentSessions,
        lifePassUsage,
        rewards,
        exercises,
        workoutEntries,
        dietPlanEntries,
        monthlyIncome,
        expenses,
        vaultEntries,
        userProfile
      ];
}

typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  required String title,
  required String type,
  Value<int?> parentGoalId,
  Value<DateTime?> targetDate,
  Value<bool> isDone,
  Value<DateTime> createdAt,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> type,
  Value<int?> parentGoalId,
  Value<DateTime?> targetDate,
  Value<bool> isDone,
  Value<DateTime> createdAt,
});

final class $$GoalsTableReferences
    extends BaseReferences<_$AppDatabase, $GoalsTable, Goal> {
  $$GoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _parentGoalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('goals__parent_goal_id__goals__id');

  $$GoalsTableProcessedTableManager? get parentGoalId {
    final $_column = $_itemColumn<int>('parent_goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager($_db, $_db.goals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentGoalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.tasks,
          aliasName: 'goals__id__tasks__goal_id');

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager($_db, $_db.tasks)
        .filter((f) => f.goalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$GoalsTableFilterComposer get parentGoalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentGoalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableFilterComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> tasksRefs(
      Expression<bool> Function($$TasksTableFilterComposer f) f) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.goalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableFilterComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$GoalsTableOrderingComposer get parentGoalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentGoalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableOrderingComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GoalsTableAnnotationComposer get parentGoalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentGoalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> tasksRefs<T extends Object>(
      Expression<T> Function($$TasksTableAnnotationComposer a) f) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.goalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableAnnotationComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal, $$GoalsTableReferences),
    Goal,
    PrefetchHooks Function({bool parentGoalId, bool tasksRefs})> {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int?> parentGoalId = const Value.absent(),
            Value<DateTime?> targetDate = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              GoalsCompanion(
            id: id,
            title: title,
            type: type,
            parentGoalId: parentGoalId,
            targetDate: targetDate,
            isDone: isDone,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String type,
            Value<int?> parentGoalId = const Value.absent(),
            Value<DateTime?> targetDate = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              GoalsCompanion.insert(
            id: id,
            title: title,
            type: type,
            parentGoalId: parentGoalId,
            targetDate: targetDate,
            isDone: isDone,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$GoalsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({parentGoalId = false, tasksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tasksRefs) db.tasks],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (parentGoalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parentGoalId,
                    referencedTable:
                        $$GoalsTableReferences._parentGoalIdTable(db),
                    referencedColumn:
                        $$GoalsTableReferences._parentGoalIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tasksRefs)
                    await $_getPrefetchedData<Goal, $GoalsTable, Task>(
                        currentTable: table,
                        referencedTable:
                            $$GoalsTableReferences._tasksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GoalsTableReferences(db, table, p0).tasksRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.goalId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GoalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal, $$GoalsTableReferences),
    Goal,
    PrefetchHooks Function({bool parentGoalId, bool tasksRefs})>;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  required String title,
  Value<String?> description,
  Value<DateTime?> dueDate,
  Value<String> priority,
  Value<bool> isDone,
  Value<int?> goalId,
  Value<DateTime> createdAt,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String?> description,
  Value<DateTime?> dueDate,
  Value<String> priority,
  Value<bool> isDone,
  Value<int?> goalId,
  Value<DateTime> createdAt,
});

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('tasks__goal_id__goals__id');

  $$GoalsTableProcessedTableManager? get goalId {
    final $_column = $_itemColumn<int>('goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager($_db, $_db.goals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableFilterComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableOrderingComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.goalId,
        referencedTable: $db.goals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.goals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function({bool goalId})> {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            Value<int?> goalId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TasksCompanion(
            id: id,
            title: title,
            description: description,
            dueDate: dueDate,
            priority: priority,
            isDone: isDone,
            goalId: goalId,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            Value<int?> goalId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              TasksCompanion.insert(
            id: id,
            title: title,
            description: description,
            dueDate: dueDate,
            priority: priority,
            isDone: isDone,
            goalId: goalId,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TasksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (goalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.goalId,
                    referencedTable: $$TasksTableReferences._goalIdTable(db),
                    referencedColumn:
                        $$TasksTableReferences._goalIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function({bool goalId})>;
typedef $$CommitmentsTableCreateCompanionBuilder = CommitmentsCompanion
    Function({
  Value<int> id,
  required String title,
  required String type,
  required int targetMinutes,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});
typedef $$CommitmentsTableUpdateCompanionBuilder = CommitmentsCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> type,
  Value<int> targetMinutes,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});

final class $$CommitmentsTableReferences
    extends BaseReferences<_$AppDatabase, $CommitmentsTable, Commitment> {
  $$CommitmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CommitmentSessionsTable, List<CommitmentSession>>
      _commitmentSessionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.commitmentSessions,
              aliasName: 'commitments__id__commitment_sessions__commitment_id');

  $$CommitmentSessionsTableProcessedTableManager get commitmentSessionsRefs {
    final manager = $$CommitmentSessionsTableTableManager(
            $_db, $_db.commitmentSessions)
        .filter((f) => f.commitmentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_commitmentSessionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LifePassUsageTable, List<LifePassUsageData>>
      _lifePassUsageRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.lifePassUsage,
              aliasName: 'commitments__id__life_pass_usage__commitment_id');

  $$LifePassUsageTableProcessedTableManager get lifePassUsageRefs {
    final manager = $$LifePassUsageTableTableManager($_db, $_db.lifePassUsage)
        .filter((f) => f.commitmentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_lifePassUsageRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RewardsTable, List<Reward>> _rewardsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.rewards,
          aliasName: 'commitments__id__rewards__commitment_id');

  $$RewardsTableProcessedTableManager get rewardsRefs {
    final manager = $$RewardsTableTableManager($_db, $_db.rewards)
        .filter((f) => f.commitmentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_rewardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CommitmentsTableFilterComposer
    extends Composer<_$AppDatabase, $CommitmentsTable> {
  $$CommitmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetMinutes => $composableBuilder(
      column: $table.targetMinutes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> commitmentSessionsRefs(
      Expression<bool> Function($$CommitmentSessionsTableFilterComposer f) f) {
    final $$CommitmentSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.commitmentSessions,
        getReferencedColumn: (t) => t.commitmentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitmentSessionsTableFilterComposer(
              $db: $db,
              $table: $db.commitmentSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> lifePassUsageRefs(
      Expression<bool> Function($$LifePassUsageTableFilterComposer f) f) {
    final $$LifePassUsageTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lifePassUsage,
        getReferencedColumn: (t) => t.commitmentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LifePassUsageTableFilterComposer(
              $db: $db,
              $table: $db.lifePassUsage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> rewardsRefs(
      Expression<bool> Function($$RewardsTableFilterComposer f) f) {
    final $$RewardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rewards,
        getReferencedColumn: (t) => t.commitmentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RewardsTableFilterComposer(
              $db: $db,
              $table: $db.rewards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CommitmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $CommitmentsTable> {
  $$CommitmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetMinutes => $composableBuilder(
      column: $table.targetMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$CommitmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommitmentsTable> {
  $$CommitmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get targetMinutes => $composableBuilder(
      column: $table.targetMinutes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> commitmentSessionsRefs<T extends Object>(
      Expression<T> Function($$CommitmentSessionsTableAnnotationComposer a) f) {
    final $$CommitmentSessionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.commitmentSessions,
            getReferencedColumn: (t) => t.commitmentId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CommitmentSessionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.commitmentSessions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> lifePassUsageRefs<T extends Object>(
      Expression<T> Function($$LifePassUsageTableAnnotationComposer a) f) {
    final $$LifePassUsageTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lifePassUsage,
        getReferencedColumn: (t) => t.commitmentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LifePassUsageTableAnnotationComposer(
              $db: $db,
              $table: $db.lifePassUsage,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> rewardsRefs<T extends Object>(
      Expression<T> Function($$RewardsTableAnnotationComposer a) f) {
    final $$RewardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.rewards,
        getReferencedColumn: (t) => t.commitmentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RewardsTableAnnotationComposer(
              $db: $db,
              $table: $db.rewards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CommitmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CommitmentsTable,
    Commitment,
    $$CommitmentsTableFilterComposer,
    $$CommitmentsTableOrderingComposer,
    $$CommitmentsTableAnnotationComposer,
    $$CommitmentsTableCreateCompanionBuilder,
    $$CommitmentsTableUpdateCompanionBuilder,
    (Commitment, $$CommitmentsTableReferences),
    Commitment,
    PrefetchHooks Function(
        {bool commitmentSessionsRefs,
        bool lifePassUsageRefs,
        bool rewardsRefs})> {
  $$CommitmentsTableTableManager(_$AppDatabase db, $CommitmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommitmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommitmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommitmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> targetMinutes = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CommitmentsCompanion(
            id: id,
            title: title,
            type: type,
            targetMinutes: targetMinutes,
            isActive: isActive,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String type,
            required int targetMinutes,
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CommitmentsCompanion.insert(
            id: id,
            title: title,
            type: type,
            targetMinutes: targetMinutes,
            isActive: isActive,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CommitmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {commitmentSessionsRefs = false,
              lifePassUsageRefs = false,
              rewardsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (commitmentSessionsRefs) db.commitmentSessions,
                if (lifePassUsageRefs) db.lifePassUsage,
                if (rewardsRefs) db.rewards
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (commitmentSessionsRefs)
                    await $_getPrefetchedData<Commitment, $CommitmentsTable,
                            CommitmentSession>(
                        currentTable: table,
                        referencedTable: $$CommitmentsTableReferences
                            ._commitmentSessionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CommitmentsTableReferences(db, table, p0)
                                .commitmentSessionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.commitmentId == item.id),
                        typedResults: items),
                  if (lifePassUsageRefs)
                    await $_getPrefetchedData<Commitment, $CommitmentsTable,
                            LifePassUsageData>(
                        currentTable: table,
                        referencedTable: $$CommitmentsTableReferences
                            ._lifePassUsageRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CommitmentsTableReferences(db, table, p0)
                                .lifePassUsageRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.commitmentId == item.id),
                        typedResults: items),
                  if (rewardsRefs)
                    await $_getPrefetchedData<Commitment, $CommitmentsTable,
                            Reward>(
                        currentTable: table,
                        referencedTable:
                            $$CommitmentsTableReferences._rewardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CommitmentsTableReferences(db, table, p0)
                                .rewardsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.commitmentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CommitmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CommitmentsTable,
    Commitment,
    $$CommitmentsTableFilterComposer,
    $$CommitmentsTableOrderingComposer,
    $$CommitmentsTableAnnotationComposer,
    $$CommitmentsTableCreateCompanionBuilder,
    $$CommitmentsTableUpdateCompanionBuilder,
    (Commitment, $$CommitmentsTableReferences),
    Commitment,
    PrefetchHooks Function(
        {bool commitmentSessionsRefs,
        bool lifePassUsageRefs,
        bool rewardsRefs})>;
typedef $$CommitmentSessionsTableCreateCompanionBuilder
    = CommitmentSessionsCompanion Function({
  Value<int> id,
  required int commitmentId,
  required DateTime startTime,
  Value<DateTime?> endTime,
});
typedef $$CommitmentSessionsTableUpdateCompanionBuilder
    = CommitmentSessionsCompanion Function({
  Value<int> id,
  Value<int> commitmentId,
  Value<DateTime> startTime,
  Value<DateTime?> endTime,
});

final class $$CommitmentSessionsTableReferences extends BaseReferences<
    _$AppDatabase, $CommitmentSessionsTable, CommitmentSession> {
  $$CommitmentSessionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CommitmentsTable _commitmentIdTable(_$AppDatabase db) =>
      db.commitments
          .createAlias('commitment_sessions__commitment_id__commitments__id');

  $$CommitmentsTableProcessedTableManager get commitmentId {
    final $_column = $_itemColumn<int>('commitment_id')!;

    final manager = $$CommitmentsTableTableManager($_db, $_db.commitments)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_commitmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CommitmentSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $CommitmentSessionsTable> {
  $$CommitmentSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  $$CommitmentsTableFilterComposer get commitmentId {
    final $$CommitmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.commitmentId,
        referencedTable: $db.commitments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitmentsTableFilterComposer(
              $db: $db,
              $table: $db.commitments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CommitmentSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CommitmentSessionsTable> {
  $$CommitmentSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  $$CommitmentsTableOrderingComposer get commitmentId {
    final $$CommitmentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.commitmentId,
        referencedTable: $db.commitments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitmentsTableOrderingComposer(
              $db: $db,
              $table: $db.commitments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CommitmentSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommitmentSessionsTable> {
  $$CommitmentSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  $$CommitmentsTableAnnotationComposer get commitmentId {
    final $$CommitmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.commitmentId,
        referencedTable: $db.commitments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.commitments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CommitmentSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CommitmentSessionsTable,
    CommitmentSession,
    $$CommitmentSessionsTableFilterComposer,
    $$CommitmentSessionsTableOrderingComposer,
    $$CommitmentSessionsTableAnnotationComposer,
    $$CommitmentSessionsTableCreateCompanionBuilder,
    $$CommitmentSessionsTableUpdateCompanionBuilder,
    (CommitmentSession, $$CommitmentSessionsTableReferences),
    CommitmentSession,
    PrefetchHooks Function({bool commitmentId})> {
  $$CommitmentSessionsTableTableManager(
      _$AppDatabase db, $CommitmentSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommitmentSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommitmentSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommitmentSessionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> commitmentId = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
          }) =>
              CommitmentSessionsCompanion(
            id: id,
            commitmentId: commitmentId,
            startTime: startTime,
            endTime: endTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int commitmentId,
            required DateTime startTime,
            Value<DateTime?> endTime = const Value.absent(),
          }) =>
              CommitmentSessionsCompanion.insert(
            id: id,
            commitmentId: commitmentId,
            startTime: startTime,
            endTime: endTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CommitmentSessionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({commitmentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (commitmentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.commitmentId,
                    referencedTable: $$CommitmentSessionsTableReferences
                        ._commitmentIdTable(db),
                    referencedColumn: $$CommitmentSessionsTableReferences
                        ._commitmentIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CommitmentSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CommitmentSessionsTable,
    CommitmentSession,
    $$CommitmentSessionsTableFilterComposer,
    $$CommitmentSessionsTableOrderingComposer,
    $$CommitmentSessionsTableAnnotationComposer,
    $$CommitmentSessionsTableCreateCompanionBuilder,
    $$CommitmentSessionsTableUpdateCompanionBuilder,
    (CommitmentSession, $$CommitmentSessionsTableReferences),
    CommitmentSession,
    PrefetchHooks Function({bool commitmentId})>;
typedef $$LifePassUsageTableCreateCompanionBuilder = LifePassUsageCompanion
    Function({
  Value<int> id,
  required int commitmentId,
  required DateTime dateUsed,
});
typedef $$LifePassUsageTableUpdateCompanionBuilder = LifePassUsageCompanion
    Function({
  Value<int> id,
  Value<int> commitmentId,
  Value<DateTime> dateUsed,
});

final class $$LifePassUsageTableReferences extends BaseReferences<_$AppDatabase,
    $LifePassUsageTable, LifePassUsageData> {
  $$LifePassUsageTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CommitmentsTable _commitmentIdTable(_$AppDatabase db) =>
      db.commitments
          .createAlias('life_pass_usage__commitment_id__commitments__id');

  $$CommitmentsTableProcessedTableManager get commitmentId {
    final $_column = $_itemColumn<int>('commitment_id')!;

    final manager = $$CommitmentsTableTableManager($_db, $_db.commitments)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_commitmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LifePassUsageTableFilterComposer
    extends Composer<_$AppDatabase, $LifePassUsageTable> {
  $$LifePassUsageTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateUsed => $composableBuilder(
      column: $table.dateUsed, builder: (column) => ColumnFilters(column));

  $$CommitmentsTableFilterComposer get commitmentId {
    final $$CommitmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.commitmentId,
        referencedTable: $db.commitments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitmentsTableFilterComposer(
              $db: $db,
              $table: $db.commitments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LifePassUsageTableOrderingComposer
    extends Composer<_$AppDatabase, $LifePassUsageTable> {
  $$LifePassUsageTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateUsed => $composableBuilder(
      column: $table.dateUsed, builder: (column) => ColumnOrderings(column));

  $$CommitmentsTableOrderingComposer get commitmentId {
    final $$CommitmentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.commitmentId,
        referencedTable: $db.commitments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitmentsTableOrderingComposer(
              $db: $db,
              $table: $db.commitments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LifePassUsageTableAnnotationComposer
    extends Composer<_$AppDatabase, $LifePassUsageTable> {
  $$LifePassUsageTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dateUsed =>
      $composableBuilder(column: $table.dateUsed, builder: (column) => column);

  $$CommitmentsTableAnnotationComposer get commitmentId {
    final $$CommitmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.commitmentId,
        referencedTable: $db.commitments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.commitments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LifePassUsageTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LifePassUsageTable,
    LifePassUsageData,
    $$LifePassUsageTableFilterComposer,
    $$LifePassUsageTableOrderingComposer,
    $$LifePassUsageTableAnnotationComposer,
    $$LifePassUsageTableCreateCompanionBuilder,
    $$LifePassUsageTableUpdateCompanionBuilder,
    (LifePassUsageData, $$LifePassUsageTableReferences),
    LifePassUsageData,
    PrefetchHooks Function({bool commitmentId})> {
  $$LifePassUsageTableTableManager(_$AppDatabase db, $LifePassUsageTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LifePassUsageTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LifePassUsageTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LifePassUsageTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> commitmentId = const Value.absent(),
            Value<DateTime> dateUsed = const Value.absent(),
          }) =>
              LifePassUsageCompanion(
            id: id,
            commitmentId: commitmentId,
            dateUsed: dateUsed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int commitmentId,
            required DateTime dateUsed,
          }) =>
              LifePassUsageCompanion.insert(
            id: id,
            commitmentId: commitmentId,
            dateUsed: dateUsed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LifePassUsageTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({commitmentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (commitmentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.commitmentId,
                    referencedTable:
                        $$LifePassUsageTableReferences._commitmentIdTable(db),
                    referencedColumn: $$LifePassUsageTableReferences
                        ._commitmentIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LifePassUsageTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LifePassUsageTable,
    LifePassUsageData,
    $$LifePassUsageTableFilterComposer,
    $$LifePassUsageTableOrderingComposer,
    $$LifePassUsageTableAnnotationComposer,
    $$LifePassUsageTableCreateCompanionBuilder,
    $$LifePassUsageTableUpdateCompanionBuilder,
    (LifePassUsageData, $$LifePassUsageTableReferences),
    LifePassUsageData,
    PrefetchHooks Function({bool commitmentId})>;
typedef $$RewardsTableCreateCompanionBuilder = RewardsCompanion Function({
  Value<int> id,
  required String title,
  Value<int?> commitmentId,
  required int streakTargetDays,
  Value<bool> isClaimed,
  Value<DateTime?> claimedAt,
  Value<DateTime> createdAt,
});
typedef $$RewardsTableUpdateCompanionBuilder = RewardsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<int?> commitmentId,
  Value<int> streakTargetDays,
  Value<bool> isClaimed,
  Value<DateTime?> claimedAt,
  Value<DateTime> createdAt,
});

final class $$RewardsTableReferences
    extends BaseReferences<_$AppDatabase, $RewardsTable, Reward> {
  $$RewardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CommitmentsTable _commitmentIdTable(_$AppDatabase db) =>
      db.commitments.createAlias('rewards__commitment_id__commitments__id');

  $$CommitmentsTableProcessedTableManager? get commitmentId {
    final $_column = $_itemColumn<int>('commitment_id');
    if ($_column == null) return null;
    final manager = $$CommitmentsTableTableManager($_db, $_db.commitments)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_commitmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RewardsTableFilterComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakTargetDays => $composableBuilder(
      column: $table.streakTargetDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isClaimed => $composableBuilder(
      column: $table.isClaimed, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get claimedAt => $composableBuilder(
      column: $table.claimedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CommitmentsTableFilterComposer get commitmentId {
    final $$CommitmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.commitmentId,
        referencedTable: $db.commitments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitmentsTableFilterComposer(
              $db: $db,
              $table: $db.commitments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RewardsTableOrderingComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakTargetDays => $composableBuilder(
      column: $table.streakTargetDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isClaimed => $composableBuilder(
      column: $table.isClaimed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get claimedAt => $composableBuilder(
      column: $table.claimedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CommitmentsTableOrderingComposer get commitmentId {
    final $$CommitmentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.commitmentId,
        referencedTable: $db.commitments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitmentsTableOrderingComposer(
              $db: $db,
              $table: $db.commitments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RewardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get streakTargetDays => $composableBuilder(
      column: $table.streakTargetDays, builder: (column) => column);

  GeneratedColumn<bool> get isClaimed =>
      $composableBuilder(column: $table.isClaimed, builder: (column) => column);

  GeneratedColumn<DateTime> get claimedAt =>
      $composableBuilder(column: $table.claimedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CommitmentsTableAnnotationComposer get commitmentId {
    final $$CommitmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.commitmentId,
        referencedTable: $db.commitments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.commitments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RewardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RewardsTable,
    Reward,
    $$RewardsTableFilterComposer,
    $$RewardsTableOrderingComposer,
    $$RewardsTableAnnotationComposer,
    $$RewardsTableCreateCompanionBuilder,
    $$RewardsTableUpdateCompanionBuilder,
    (Reward, $$RewardsTableReferences),
    Reward,
    PrefetchHooks Function({bool commitmentId})> {
  $$RewardsTableTableManager(_$AppDatabase db, $RewardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RewardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RewardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RewardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int?> commitmentId = const Value.absent(),
            Value<int> streakTargetDays = const Value.absent(),
            Value<bool> isClaimed = const Value.absent(),
            Value<DateTime?> claimedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RewardsCompanion(
            id: id,
            title: title,
            commitmentId: commitmentId,
            streakTargetDays: streakTargetDays,
            isClaimed: isClaimed,
            claimedAt: claimedAt,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<int?> commitmentId = const Value.absent(),
            required int streakTargetDays,
            Value<bool> isClaimed = const Value.absent(),
            Value<DateTime?> claimedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              RewardsCompanion.insert(
            id: id,
            title: title,
            commitmentId: commitmentId,
            streakTargetDays: streakTargetDays,
            isClaimed: isClaimed,
            claimedAt: claimedAt,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RewardsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({commitmentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (commitmentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.commitmentId,
                    referencedTable:
                        $$RewardsTableReferences._commitmentIdTable(db),
                    referencedColumn:
                        $$RewardsTableReferences._commitmentIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RewardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RewardsTable,
    Reward,
    $$RewardsTableFilterComposer,
    $$RewardsTableOrderingComposer,
    $$RewardsTableAnnotationComposer,
    $$RewardsTableCreateCompanionBuilder,
    $$RewardsTableUpdateCompanionBuilder,
    (Reward, $$RewardsTableReferences),
    Reward,
    PrefetchHooks Function({bool commitmentId})>;
typedef $$ExercisesTableCreateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> muscleGroup,
  Value<DateTime> createdAt,
});
typedef $$ExercisesTableUpdateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> muscleGroup,
  Value<DateTime> createdAt,
});

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, Exercise> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkoutEntriesTable, List<WorkoutEntry>>
      _workoutEntriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.workoutEntries,
              aliasName: 'exercises__id__workout_entries__exercise_id');

  $$WorkoutEntriesTableProcessedTableManager get workoutEntriesRefs {
    final manager = $$WorkoutEntriesTableTableManager($_db, $_db.workoutEntries)
        .filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get muscleGroup => $composableBuilder(
      column: $table.muscleGroup, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> workoutEntriesRefs(
      Expression<bool> Function($$WorkoutEntriesTableFilterComposer f) f) {
    final $$WorkoutEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutEntries,
        getReferencedColumn: (t) => t.exerciseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutEntriesTableFilterComposer(
              $db: $db,
              $table: $db.workoutEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
      column: $table.muscleGroup, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get muscleGroup => $composableBuilder(
      column: $table.muscleGroup, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> workoutEntriesRefs<T extends Object>(
      Expression<T> Function($$WorkoutEntriesTableAnnotationComposer a) f) {
    final $$WorkoutEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutEntries,
        getReferencedColumn: (t) => t.exerciseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExercisesTable,
    Exercise,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (Exercise, $$ExercisesTableReferences),
    Exercise,
    PrefetchHooks Function({bool workoutEntriesRefs})> {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> muscleGroup = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExercisesCompanion(
            id: id,
            name: name,
            muscleGroup: muscleGroup,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> muscleGroup = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExercisesCompanion.insert(
            id: id,
            name: name,
            muscleGroup: muscleGroup,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExercisesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({workoutEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (workoutEntriesRefs) db.workoutEntries
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workoutEntriesRefs)
                    await $_getPrefetchedData<Exercise, $ExercisesTable,
                            WorkoutEntry>(
                        currentTable: table,
                        referencedTable: $$ExercisesTableReferences
                            ._workoutEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExercisesTableReferences(db, table, p0)
                                .workoutEntriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExercisesTable,
    Exercise,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (Exercise, $$ExercisesTableReferences),
    Exercise,
    PrefetchHooks Function({bool workoutEntriesRefs})>;
typedef $$WorkoutEntriesTableCreateCompanionBuilder = WorkoutEntriesCompanion
    Function({
  Value<int> id,
  required int exerciseId,
  required DateTime date,
  required int sets,
  required int reps,
  required double weightKg,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$WorkoutEntriesTableUpdateCompanionBuilder = WorkoutEntriesCompanion
    Function({
  Value<int> id,
  Value<int> exerciseId,
  Value<DateTime> date,
  Value<int> sets,
  Value<int> reps,
  Value<double> weightKg,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

final class $$WorkoutEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutEntriesTable, WorkoutEntry> {
  $$WorkoutEntriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias('workout_entries__exercise_id__exercises__id');

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager($_db, $_db.exercises)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WorkoutEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutEntriesTable> {
  $$WorkoutEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sets => $composableBuilder(
      column: $table.sets, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableFilterComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkoutEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutEntriesTable> {
  $$WorkoutEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sets => $composableBuilder(
      column: $table.sets, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableOrderingComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkoutEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutEntriesTable> {
  $$WorkoutEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseId,
        referencedTable: $db.exercises,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExercisesTableAnnotationComposer(
              $db: $db,
              $table: $db.exercises,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkoutEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutEntriesTable,
    WorkoutEntry,
    $$WorkoutEntriesTableFilterComposer,
    $$WorkoutEntriesTableOrderingComposer,
    $$WorkoutEntriesTableAnnotationComposer,
    $$WorkoutEntriesTableCreateCompanionBuilder,
    $$WorkoutEntriesTableUpdateCompanionBuilder,
    (WorkoutEntry, $$WorkoutEntriesTableReferences),
    WorkoutEntry,
    PrefetchHooks Function({bool exerciseId})> {
  $$WorkoutEntriesTableTableManager(
      _$AppDatabase db, $WorkoutEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> exerciseId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> sets = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<double> weightKg = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              WorkoutEntriesCompanion(
            id: id,
            exerciseId: exerciseId,
            date: date,
            sets: sets,
            reps: reps,
            weightKg: weightKg,
            notes: notes,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int exerciseId,
            required DateTime date,
            required int sets,
            required int reps,
            required double weightKg,
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              WorkoutEntriesCompanion.insert(
            id: id,
            exerciseId: exerciseId,
            date: date,
            sets: sets,
            reps: reps,
            weightKg: weightKg,
            notes: notes,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkoutEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (exerciseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseId,
                    referencedTable:
                        $$WorkoutEntriesTableReferences._exerciseIdTable(db),
                    referencedColumn:
                        $$WorkoutEntriesTableReferences._exerciseIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WorkoutEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutEntriesTable,
    WorkoutEntry,
    $$WorkoutEntriesTableFilterComposer,
    $$WorkoutEntriesTableOrderingComposer,
    $$WorkoutEntriesTableAnnotationComposer,
    $$WorkoutEntriesTableCreateCompanionBuilder,
    $$WorkoutEntriesTableUpdateCompanionBuilder,
    (WorkoutEntry, $$WorkoutEntriesTableReferences),
    WorkoutEntry,
    PrefetchHooks Function({bool exerciseId})>;
typedef $$DietPlanEntriesTableCreateCompanionBuilder = DietPlanEntriesCompanion
    Function({
  Value<int> id,
  required int dayOfWeek,
  required String mealType,
  required String description,
  Value<DateTime> createdAt,
});
typedef $$DietPlanEntriesTableUpdateCompanionBuilder = DietPlanEntriesCompanion
    Function({
  Value<int> id,
  Value<int> dayOfWeek,
  Value<String> mealType,
  Value<String> description,
  Value<DateTime> createdAt,
});

class $$DietPlanEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DietPlanEntriesTable> {
  $$DietPlanEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
      column: $table.dayOfWeek, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mealType => $composableBuilder(
      column: $table.mealType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$DietPlanEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DietPlanEntriesTable> {
  $$DietPlanEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
      column: $table.dayOfWeek, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mealType => $composableBuilder(
      column: $table.mealType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DietPlanEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DietPlanEntriesTable> {
  $$DietPlanEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DietPlanEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DietPlanEntriesTable,
    DietPlanEntry,
    $$DietPlanEntriesTableFilterComposer,
    $$DietPlanEntriesTableOrderingComposer,
    $$DietPlanEntriesTableAnnotationComposer,
    $$DietPlanEntriesTableCreateCompanionBuilder,
    $$DietPlanEntriesTableUpdateCompanionBuilder,
    (
      DietPlanEntry,
      BaseReferences<_$AppDatabase, $DietPlanEntriesTable, DietPlanEntry>
    ),
    DietPlanEntry,
    PrefetchHooks Function()> {
  $$DietPlanEntriesTableTableManager(
      _$AppDatabase db, $DietPlanEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DietPlanEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DietPlanEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DietPlanEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> dayOfWeek = const Value.absent(),
            Value<String> mealType = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DietPlanEntriesCompanion(
            id: id,
            dayOfWeek: dayOfWeek,
            mealType: mealType,
            description: description,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dayOfWeek,
            required String mealType,
            required String description,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DietPlanEntriesCompanion.insert(
            id: id,
            dayOfWeek: dayOfWeek,
            mealType: mealType,
            description: description,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DietPlanEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DietPlanEntriesTable,
    DietPlanEntry,
    $$DietPlanEntriesTableFilterComposer,
    $$DietPlanEntriesTableOrderingComposer,
    $$DietPlanEntriesTableAnnotationComposer,
    $$DietPlanEntriesTableCreateCompanionBuilder,
    $$DietPlanEntriesTableUpdateCompanionBuilder,
    (
      DietPlanEntry,
      BaseReferences<_$AppDatabase, $DietPlanEntriesTable, DietPlanEntry>
    ),
    DietPlanEntry,
    PrefetchHooks Function()>;
typedef $$MonthlyIncomeTableCreateCompanionBuilder = MonthlyIncomeCompanion
    Function({
  Value<int> id,
  required int year,
  required int month,
  required double amount,
  Value<DateTime> createdAt,
});
typedef $$MonthlyIncomeTableUpdateCompanionBuilder = MonthlyIncomeCompanion
    Function({
  Value<int> id,
  Value<int> year,
  Value<int> month,
  Value<double> amount,
  Value<DateTime> createdAt,
});

class $$MonthlyIncomeTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyIncomeTable> {
  $$MonthlyIncomeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$MonthlyIncomeTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyIncomeTable> {
  $$MonthlyIncomeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$MonthlyIncomeTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyIncomeTable> {
  $$MonthlyIncomeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MonthlyIncomeTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MonthlyIncomeTable,
    MonthlyIncomeData,
    $$MonthlyIncomeTableFilterComposer,
    $$MonthlyIncomeTableOrderingComposer,
    $$MonthlyIncomeTableAnnotationComposer,
    $$MonthlyIncomeTableCreateCompanionBuilder,
    $$MonthlyIncomeTableUpdateCompanionBuilder,
    (
      MonthlyIncomeData,
      BaseReferences<_$AppDatabase, $MonthlyIncomeTable, MonthlyIncomeData>
    ),
    MonthlyIncomeData,
    PrefetchHooks Function()> {
  $$MonthlyIncomeTableTableManager(_$AppDatabase db, $MonthlyIncomeTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyIncomeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyIncomeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyIncomeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> year = const Value.absent(),
            Value<int> month = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MonthlyIncomeCompanion(
            id: id,
            year: year,
            month: month,
            amount: amount,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int year,
            required int month,
            required double amount,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MonthlyIncomeCompanion.insert(
            id: id,
            year: year,
            month: month,
            amount: amount,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MonthlyIncomeTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MonthlyIncomeTable,
    MonthlyIncomeData,
    $$MonthlyIncomeTableFilterComposer,
    $$MonthlyIncomeTableOrderingComposer,
    $$MonthlyIncomeTableAnnotationComposer,
    $$MonthlyIncomeTableCreateCompanionBuilder,
    $$MonthlyIncomeTableUpdateCompanionBuilder,
    (
      MonthlyIncomeData,
      BaseReferences<_$AppDatabase, $MonthlyIncomeTable, MonthlyIncomeData>
    ),
    MonthlyIncomeData,
    PrefetchHooks Function()>;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  required double amount,
  required String category,
  Value<String?> description,
  required DateTime date,
  Value<DateTime> createdAt,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  Value<double> amount,
  Value<String> category,
  Value<String?> description,
  Value<DateTime> date,
  Value<DateTime> createdAt,
});

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
    Expense,
    PrefetchHooks Function()> {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            amount: amount,
            category: category,
            description: description,
            date: date,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required double amount,
            required String category,
            Value<String?> description = const Value.absent(),
            required DateTime date,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ExpensesCompanion.insert(
            id: id,
            amount: amount,
            category: category,
            description: description,
            date: date,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExpensesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
    Expense,
    PrefetchHooks Function()>;
typedef $$VaultEntriesTableCreateCompanionBuilder = VaultEntriesCompanion
    Function({
  Value<int> id,
  required String vaultType,
  required String title,
  required String content,
  Value<String> tags,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$VaultEntriesTableUpdateCompanionBuilder = VaultEntriesCompanion
    Function({
  Value<int> id,
  Value<String> vaultType,
  Value<String> title,
  Value<String> content,
  Value<String> tags,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$VaultEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $VaultEntriesTable> {
  $$VaultEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vaultType => $composableBuilder(
      column: $table.vaultType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$VaultEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $VaultEntriesTable> {
  $$VaultEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vaultType => $composableBuilder(
      column: $table.vaultType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$VaultEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VaultEntriesTable> {
  $$VaultEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get vaultType =>
      $composableBuilder(column: $table.vaultType, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$VaultEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VaultEntriesTable,
    VaultEntry,
    $$VaultEntriesTableFilterComposer,
    $$VaultEntriesTableOrderingComposer,
    $$VaultEntriesTableAnnotationComposer,
    $$VaultEntriesTableCreateCompanionBuilder,
    $$VaultEntriesTableUpdateCompanionBuilder,
    (VaultEntry, BaseReferences<_$AppDatabase, $VaultEntriesTable, VaultEntry>),
    VaultEntry,
    PrefetchHooks Function()> {
  $$VaultEntriesTableTableManager(_$AppDatabase db, $VaultEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VaultEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VaultEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VaultEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> vaultType = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> tags = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              VaultEntriesCompanion(
            id: id,
            vaultType: vaultType,
            title: title,
            content: content,
            tags: tags,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String vaultType,
            required String title,
            required String content,
            Value<String> tags = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              VaultEntriesCompanion.insert(
            id: id,
            vaultType: vaultType,
            title: title,
            content: content,
            tags: tags,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VaultEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VaultEntriesTable,
    VaultEntry,
    $$VaultEntriesTableFilterComposer,
    $$VaultEntriesTableOrderingComposer,
    $$VaultEntriesTableAnnotationComposer,
    $$VaultEntriesTableCreateCompanionBuilder,
    $$VaultEntriesTableUpdateCompanionBuilder,
    (VaultEntry, BaseReferences<_$AppDatabase, $VaultEntriesTable, VaultEntry>),
    VaultEntry,
    PrefetchHooks Function()>;
typedef $$UserProfileTableCreateCompanionBuilder = UserProfileCompanion
    Function({
  Value<int> id,
  Value<String> nickname,
  Value<String?> avatarPath,
  Value<DateTime> memberSince,
  Value<bool> reduceMotion,
});
typedef $$UserProfileTableUpdateCompanionBuilder = UserProfileCompanion
    Function({
  Value<int> id,
  Value<String> nickname,
  Value<String?> avatarPath,
  Value<DateTime> memberSince,
  Value<bool> reduceMotion,
});

class $$UserProfileTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarPath => $composableBuilder(
      column: $table.avatarPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get memberSince => $composableBuilder(
      column: $table.memberSince, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get reduceMotion => $composableBuilder(
      column: $table.reduceMotion, builder: (column) => ColumnFilters(column));
}

class $$UserProfileTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarPath => $composableBuilder(
      column: $table.avatarPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get memberSince => $composableBuilder(
      column: $table.memberSince, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get reduceMotion => $composableBuilder(
      column: $table.reduceMotion,
      builder: (column) => ColumnOrderings(column));
}

class $$UserProfileTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfileTable> {
  $$UserProfileTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get avatarPath => $composableBuilder(
      column: $table.avatarPath, builder: (column) => column);

  GeneratedColumn<DateTime> get memberSince => $composableBuilder(
      column: $table.memberSince, builder: (column) => column);

  GeneratedColumn<bool> get reduceMotion => $composableBuilder(
      column: $table.reduceMotion, builder: (column) => column);
}

class $$UserProfileTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfileTable,
    UserProfileData,
    $$UserProfileTableFilterComposer,
    $$UserProfileTableOrderingComposer,
    $$UserProfileTableAnnotationComposer,
    $$UserProfileTableCreateCompanionBuilder,
    $$UserProfileTableUpdateCompanionBuilder,
    (
      UserProfileData,
      BaseReferences<_$AppDatabase, $UserProfileTable, UserProfileData>
    ),
    UserProfileData,
    PrefetchHooks Function()> {
  $$UserProfileTableTableManager(_$AppDatabase db, $UserProfileTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfileTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfileTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfileTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nickname = const Value.absent(),
            Value<String?> avatarPath = const Value.absent(),
            Value<DateTime> memberSince = const Value.absent(),
            Value<bool> reduceMotion = const Value.absent(),
          }) =>
              UserProfileCompanion(
            id: id,
            nickname: nickname,
            avatarPath: avatarPath,
            memberSince: memberSince,
            reduceMotion: reduceMotion,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nickname = const Value.absent(),
            Value<String?> avatarPath = const Value.absent(),
            Value<DateTime> memberSince = const Value.absent(),
            Value<bool> reduceMotion = const Value.absent(),
          }) =>
              UserProfileCompanion.insert(
            id: id,
            nickname: nickname,
            avatarPath: avatarPath,
            memberSince: memberSince,
            reduceMotion: reduceMotion,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserProfileTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfileTable,
    UserProfileData,
    $$UserProfileTableFilterComposer,
    $$UserProfileTableOrderingComposer,
    $$UserProfileTableAnnotationComposer,
    $$UserProfileTableCreateCompanionBuilder,
    $$UserProfileTableUpdateCompanionBuilder,
    (
      UserProfileData,
      BaseReferences<_$AppDatabase, $UserProfileTable, UserProfileData>
    ),
    UserProfileData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$CommitmentsTableTableManager get commitments =>
      $$CommitmentsTableTableManager(_db, _db.commitments);
  $$CommitmentSessionsTableTableManager get commitmentSessions =>
      $$CommitmentSessionsTableTableManager(_db, _db.commitmentSessions);
  $$LifePassUsageTableTableManager get lifePassUsage =>
      $$LifePassUsageTableTableManager(_db, _db.lifePassUsage);
  $$RewardsTableTableManager get rewards =>
      $$RewardsTableTableManager(_db, _db.rewards);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$WorkoutEntriesTableTableManager get workoutEntries =>
      $$WorkoutEntriesTableTableManager(_db, _db.workoutEntries);
  $$DietPlanEntriesTableTableManager get dietPlanEntries =>
      $$DietPlanEntriesTableTableManager(_db, _db.dietPlanEntries);
  $$MonthlyIncomeTableTableManager get monthlyIncome =>
      $$MonthlyIncomeTableTableManager(_db, _db.monthlyIncome);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$VaultEntriesTableTableManager get vaultEntries =>
      $$VaultEntriesTableTableManager(_db, _db.vaultEntries);
  $$UserProfileTableTableManager get userProfile =>
      $$UserProfileTableTableManager(_db, _db.userProfile);
}
