import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import '../main.dart';
import '../data/database.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  void _addTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    DateTime? dueDate;
    String priority = 'medium';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: priority,
                items: ['low', 'medium', 'high']
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (val) => setState(() => priority = val ?? 'medium'),
              ),
              TextButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: ctx,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 1)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) setState(() => dueDate = picked);
                },
                child: Text(dueDate == null
                    ? 'Pick due date'
                    : dueDate.toString().split(' ').first),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty) return;
                db.addTask(TasksCompanion(
                  title: Value(titleController.text.trim()),
                  priority: Value(priority),
                  dueDate: Value(dueDate),
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
    return Scaffold(
      appBar: AppBar(title: const Text('All Tasks')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTaskDialog(context),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Task>>(
        stream: db.watchAllTasks(),
        builder: (context, snapshot) {
          final tasks = snapshot.data ?? [];
          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks yet'));
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, i) {
              final t = tasks[i];
              return Dismissible(
                key: ValueKey(t.id),
                onDismissed: (_) => db.deleteTask(t.id),
                background: Container(color: Colors.red),
                child: CheckboxListTile(
                  title: Text(
                    t.title,
                    style: TextStyle(
                        decoration:
                            t.isDone ? TextDecoration.lineThrough : null),
                  ),
                  subtitle: Text(
                      '${t.priority}${t.dueDate != null ? ' • ${t.dueDate!.toString().split(' ').first}' : ''}'),
                  value: t.isDone,
                  onChanged: (val) =>
                      db.updateTask(t.copyWith(isDone: val ?? false)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
