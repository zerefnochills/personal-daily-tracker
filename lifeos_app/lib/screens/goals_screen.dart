import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import '../main.dart';
import '../data/database.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final types = ['day', 'week', 'month', 'year'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: types.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addGoalDialog(BuildContext context, String type) {
    final titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('New $type goal'),
        content: TextField(
          controller: titleController,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isEmpty) return;
              db.addGoal(GoalsCompanion(
                title: Value(titleController.text.trim()),
                type: Value(type),
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
      appBar: AppBar(
        title: const Text('Goals'),
        bottom: TabBar(
          controller: _tabController,
          tabs: types.map((t) => Tab(text: t)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addGoalDialog(context, types[_tabController.index]),
        child: const Icon(Icons.add),
      ),
      body: TabBarView(
        controller: _tabController,
        children: types.map((type) {
          return StreamBuilder<List<Goal>>(
            stream: db.watchGoalsByType(type),
            builder: (context, snapshot) {
              final goals = snapshot.data ?? [];
              if (goals.isEmpty) {
                return Center(child: Text('No $type goals yet'));
              }
              return ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, i) {
                  final g = goals[i];
                  return Dismissible(
                    key: ValueKey(g.id),
                    onDismissed: (_) => db.deleteGoal(g.id),
                    background: Container(color: Colors.red),
                    child: CheckboxListTile(
                      title: Text(
                        g.title,
                        style: TextStyle(
                            decoration: g.isDone
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      value: g.isDone,
                      onChanged: (val) =>
                          db.updateGoal(g.copyWith(isDone: val ?? false)),
                    ),
                  );
                },
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
