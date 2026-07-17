import 'package:flutter/material.dart';
import '../main.dart';
import '../data/database.dart';
import 'tasks_screen.dart';
import 'goals_screen.dart';
import 'commitments_screen.dart';
import 'rewards_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LifeOS')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Today', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          StreamBuilder<List<Task>>(
            stream: db.watchTodayTasks(),
            builder: (context, snapshot) {
              final tasks = snapshot.data ?? [];
              if (tasks.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('No tasks due today'),
                );
              }
              return Column(
                children: tasks
                    .map((t) => CheckboxListTile(
                          title: Text(t.title),
                          value: t.isDone,
                          onChanged: (val) {
                            db.updateTask(t.copyWith(isDone: val ?? false));
                          },
                        ))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TasksScreen())),
                  child: const Text('All Tasks'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const GoalsScreen())),
                  child: const Text('Goals'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CommitmentsScreen())),
                  child: const Text('Commitments'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RewardsScreen())),
                  child: const Text('Rewards'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
