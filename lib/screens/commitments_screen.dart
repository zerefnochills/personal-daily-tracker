import 'dart:async';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import '../main.dart';
import '../data/database.dart';
import '../logic/streak_service.dart';
import '../widgets/app_drawer.dart';

class CommitmentsScreen extends StatelessWidget {
  const CommitmentsScreen({super.key});

  void _addCommitmentDialog(BuildContext context) {
    final titleController = TextEditingController();
    final targetController = TextEditingController(text: '30');
    String type = 'study';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('New Commitment'),
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
                value: type,
                items: ['study', 'workout', 'read', 'code', 'custom']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setState(() => type = val ?? 'study'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: targetController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Daily target (minutes)'),
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
                final title = titleController.text.trim();
                final target = int.tryParse(targetController.text) ?? 30;
                if (title.isEmpty) return;
                db.addCommitment(CommitmentsCompanion(
                  title: Value(title),
                  type: Value(type),
                  targetMinutes: Value(target),
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
    final streakService = StreakService(db);
    return Scaffold(
      appBar: AppBar(title: const Text('Commitments')),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addCommitmentDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          FutureBuilder<int>(
            future: streakService.lifePassesRemainingThisMonth(),
            builder: (context, snapshot) {
              final remaining = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  remaining == null
                      ? 'Life Passes: —'
                      : 'Life Passes remaining this month: $remaining / 4',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            },
          ),
          Expanded(
            child: StreamBuilder<List<Commitment>>(
              stream: db.watchActiveCommitments(),
              builder: (context, snapshot) {
                final list = snapshot.data ?? [];
                if (list.isEmpty) {
                  return const Center(
                      child: Text('No commitments yet — add one'));
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) =>
                      CommitmentTile(commitment: list[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CommitmentTile extends StatefulWidget {
  final Commitment commitment;
  const CommitmentTile({super.key, required this.commitment});

  @override
  State<CommitmentTile> createState() => _CommitmentTileState();
}

class _CommitmentTileState extends State<CommitmentTile> {
  Timer? _refreshTimer;
  late StreakService _streakService;

  @override
  void initState() {
    super.initState();
    _streakService = StreakService(db);
    // Cosmetic-only refresh while a session might be running, so the
    // displayed minutes/streak update without needing a live per-second
    // ticker. The actual elapsed time is always computed from stored
    // timestamps, so this timer being killed/delayed changes nothing
    // about correctness.
    _refreshTimer = Timer.periodic(const Duration(seconds: 20), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _toggleSession(CommitmentSession? open) async {
    if (open == null) {
      await db.startSession(widget.commitment.id);
    } else {
      await db.stopSession(open.id);
    }
    setState(() {});
  }

  Future<void> _usePass() async {
    final remaining = await _streakService.lifePassesRemainingThisMonth();
    if (remaining <= 0) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No Life Passes left this month')),
        );
      }
      return;
    }
    await db.useLifePass(widget.commitment.id, DateTime.now());
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.commitment;
    return StreamBuilder<CommitmentSession?>(
      stream: db.watchOpenSession(c.id),
      builder: (context, sessionSnapshot) {
        final openSession = sessionSnapshot.data;
        return FutureBuilder<int>(
          future: _streakService.minutesOnDate(c.id, DateTime.now()),
          builder: (context, minutesSnapshot) {
            final minutesToday = minutesSnapshot.data ?? 0;
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.title,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text('${c.type} • target ${c.targetMinutes} min/day'),
                    const SizedBox(height: 8),
                    Text('Today: $minutesToday / ${c.targetMinutes} min'),
                    FutureBuilder<int>(
                      future:
                          _streakService.currentStreak(c.id, c.targetMinutes),
                      builder: (context, streakSnapshot) {
                        final streak = streakSnapshot.data ?? 0;
                        return Text('🔥 Streak: $streak day(s)');
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => _toggleSession(openSession),
                          child: Text(openSession == null ? 'Start' : 'Stop'),
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: _usePass,
                          child: const Text('Use Life Pass for today'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
