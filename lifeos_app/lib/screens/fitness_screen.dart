import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import '../main.dart';
import '../data/database.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Workouts'), Tab(text: 'Diet Plan')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [_WorkoutsTab(), _DietPlanTab()],
      ),
    );
  }
}

// ---------------- Workouts ----------------

class _WorkoutsTab extends StatelessWidget {
  const _WorkoutsTab();

  void _addExerciseDialog(BuildContext context) {
    final nameController = TextEditingController();
    final muscleController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Exercise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Exercise name'),
            ),
            TextField(
              controller: muscleController,
              decoration: const InputDecoration(
                  labelText: 'Muscle group (optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isEmpty) return;
              db.addExercise(ExercisesCompanion(
                name: Value(name),
                muscleGroup: Value(muscleController.text.trim().isEmpty
                    ? null
                    : muscleController.text.trim()),
              ));
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addExerciseDialog(context),
        child: const Icon(Icons.add),
        heroTag: 'add_exercise',
      ),
      body: StreamBuilder<List<Exercise>>(
        stream: db.watchAllExercises(),
        builder: (context, snapshot) {
          final exercises = snapshot.data ?? [];
          if (exercises.isEmpty) {
            return const Center(child: Text('No exercises yet — add one'));
          }
          return ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, i) => _ExerciseCard(exercise: exercises[i]),
          );
        },
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  const _ExerciseCard({required this.exercise});

  void _logSetDialog(BuildContext context) {
    final setsController = TextEditingController(text: '3');
    final repsController = TextEditingController(text: '10');
    final weightController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Log: ${exercise.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: setsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Sets'),
            ),
            TextField(
              controller: repsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Reps'),
            ),
            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final sets = int.tryParse(setsController.text) ?? 0;
              final reps = int.tryParse(repsController.text) ?? 0;
              final weight = double.tryParse(weightController.text) ?? 0;
              db.addWorkoutEntry(WorkoutEntriesCompanion(
                exerciseId: Value(exercise.id),
                date: Value(DateTime.now()),
                sets: Value(sets),
                reps: Value(reps),
                weightKg: Value(weight),
              ));
              Navigator.pop(ctx);
            },
            child: const Text('Log'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ExpansionTile(
        title: Text(exercise.name),
        subtitle: exercise.muscleGroup != null
            ? Text(exercise.muscleGroup!)
            : null,
        children: [
          FutureBuilder<double?>(
            future: db.personalRecord(exercise.id),
            builder: (context, snapshot) {
              final pr = snapshot.data;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(pr == null
                      ? 'No PR yet'
                      : '🏆 PR: ${pr.toStringAsFixed(1)} kg'),
                ),
              );
            },
          ),
          StreamBuilder<List<WorkoutEntry>>(
            stream: db.watchEntriesForExercise(exercise.id),
            builder: (context, snapshot) {
              final entries = snapshot.data ?? [];
              if (entries.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No sets logged yet'),
                );
              }
              return Column(
                children: entries
                    .take(5)
                    .map((e) => ListTile(
                          dense: true,
                          title: Text(
                              '${e.sets}x${e.reps} @ ${e.weightKg.toStringAsFixed(1)}kg'),
                          subtitle: Text(e.date.toString().split(' ').first),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, size: 20),
                            onPressed: () => db.deleteWorkoutEntry(e.id),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextButton(
              onPressed: () => _logSetDialog(context),
              child: const Text('+ Log a set'),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Diet Plan ----------------

class _DietPlanTab extends StatelessWidget {
  const _DietPlanTab();

  static const dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  void _addMealDialog(BuildContext context, int dayOfWeek) {
    final descController = TextEditingController();
    String mealType = 'breakfast';
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text('Add meal — ${dayNames[dayOfWeek]}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: mealType,
                items: ['breakfast', 'lunch', 'dinner', 'snack']
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (val) =>
                    setState(() => mealType = val ?? 'breakfast'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'What to eat'),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                final desc = descController.text.trim();
                if (desc.isEmpty) return;
                db.addDietEntry(DietPlanEntriesCompanion(
                  dayOfWeek: Value(dayOfWeek),
                  mealType: Value(mealType),
                  description: Value(desc),
                ));
                Navigator.pop(ctx);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, dayOfWeek) {
        return ExpansionTile(
          title: Text(dayNames[dayOfWeek]),
          children: [
            StreamBuilder<List<DietPlanEntry>>(
              stream: db.watchDietForDay(dayOfWeek),
              builder: (context, snapshot) {
                final meals = snapshot.data ?? [];
                if (meals.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Nothing planned'),
                  );
                }
                return Column(
                  children: meals
                      .map((m) => ListTile(
                            dense: true,
                            title: Text(m.description),
                            subtitle: Text(m.mealType),
                            trailing: IconButton(
                              icon:
                                  const Icon(Icons.delete_outline, size: 20),
                              onPressed: () => db.deleteDietEntry(m.id),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextButton(
                onPressed: () => _addMealDialog(context, dayOfWeek),
                child: const Text('+ Add meal'),
              ),
            ),
          ],
        );
      },
    );
  }
}
