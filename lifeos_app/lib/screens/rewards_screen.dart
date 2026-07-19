import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import '../main.dart';
import '../data/database.dart';
import '../logic/streak_service.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  void _addRewardDialog(BuildContext context) async {
    final titleController = TextEditingController();
    final streakTargetController = TextEditingController(text: '30');
    final commitments = await db.watchActiveCommitments().first;
    int? selectedCommitmentId =
        commitments.isNotEmpty ? commitments.first.id : null;

    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('New Reward'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Reward title'),
              ),
              const SizedBox(height: 12),
              if (commitments.isNotEmpty)
                DropdownButton<int>(
                  value: selectedCommitmentId,
                  items: commitments
                      .map((c) =>
                          DropdownMenuItem(value: c.id, child: Text(c.title)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => selectedCommitmentId = val),
                )
              else
                const Text('Add a commitment first to link a reward to it'),
              const SizedBox(height: 12),
              TextField(
                controller: streakTargetController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Streak target (days)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: selectedCommitmentId == null
                  ? null
                  : () {
                      final title = titleController.text.trim();
                      final target =
                          int.tryParse(streakTargetController.text) ?? 30;
                      if (title.isEmpty) return;
                      db.addReward(RewardsCompanion(
                        title: Value(title),
                        commitmentId: Value(selectedCommitmentId),
                        streakTargetDays: Value(target),
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
      appBar: AppBar(title: const Text('Rewards')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addRewardDialog(context),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Reward>>(
        stream: db.watchAllRewards(),
        builder: (context, snapshot) {
          final rewards = snapshot.data ?? [];
          if (rewards.isEmpty) {
            return const Center(child: Text('No rewards set up yet'));
          }
          return ListView.builder(
            itemCount: rewards.length,
            itemBuilder: (context, i) {
              final r = rewards[i];
              return FutureBuilder<List<Commitment>>(
                future: db.watchActiveCommitments().first,
                builder: (context, commitmentsSnapshot) {
                  final commitment = commitmentsSnapshot.data
                      ?.where((c) => c.id == r.commitmentId)
                      .cast<Commitment?>()
                      .firstWhere((c) => c != null, orElse: () => null);

                  if (commitment == null) {
                    return ListTile(title: Text(r.title));
                  }

                  return FutureBuilder<int>(
                    future: streakService.currentStreak(
                        commitment.id, commitment.targetMinutes),
                    builder: (context, streakSnapshot) {
                      final streak = streakSnapshot.data ?? 0;
                      final unlocked = streak >= r.streakTargetDays;
                      return ListTile(
                        leading: Icon(
                          r.isClaimed
                              ? Icons.check_circle
                              : (unlocked
                                  ? Icons.lock_open
                                  : Icons.lock_outline),
                          color: r.isClaimed
                              ? Colors.green
                              : (unlocked ? Colors.amber : Colors.grey),
                        ),
                        title: Text(r.title),
                        subtitle: Text(
                            '${commitment.title} • needs $streak/${r.streakTargetDays} day streak'),
                        trailing: r.isClaimed
                            ? const Text('Claimed')
                            : (unlocked
                                ? TextButton(
                                    onPressed: () => db.claimReward(r.id),
                                    child: const Text('Claim'),
                                  )
                                : null),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
