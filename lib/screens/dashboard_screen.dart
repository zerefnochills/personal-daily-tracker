import 'package:flutter/material.dart';
import '../main.dart';
import '../data/database.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import 'tasks_screen.dart';
import 'goals_screen.dart';
import 'commitments_screen.dart';
import 'rewards_screen.dart';
import 'fitness_screen.dart';
import 'finance_screen.dart';
import 'vaults_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 5) return 'Still up';
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    if (hour < 21) return 'Good evening';
    return 'Good night';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LifeOS')),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          StreamBuilder<UserProfileData>(
            stream: db.watchProfile(),
            builder: (context, snapshot) {
              final nickname = snapshot.data?.nickname ?? '';
              final greeting = _greeting();
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  nickname.isNotEmpty ? '$greeting, $nickname' : greeting,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
          ),
          _SectionCard(
            title: 'Today',
            child: StreamBuilder<List<Task>>(
              stream: db.watchTodayTasks(),
              builder: (context, snapshot) {
                final tasks = snapshot.data ?? [];
                if (tasks.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text('No tasks due today',
                        style: Theme.of(context).textTheme.bodyMedium),
                  );
                }
                return Column(
                  children: tasks
                      .map((t) => CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(t.title),
                            activeColor: AppColors.primary,
                            value: t.isDone,
                            onChanged: (val) {
                              db.updateTask(
                                  t.copyWith(isDone: val ?? false));
                            },
                          ))
                      .toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text('Quick access', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.4,
            children: [
              _QuickTile(
                  icon: Icons.check_circle_outline,
                  label: 'Tasks',
                  screen: const TasksScreen()),
              _QuickTile(
                  icon: Icons.flag_outlined,
                  label: 'Goals',
                  screen: const GoalsScreen()),
              _QuickTile(
                  icon: Icons.local_fire_department_outlined,
                  label: 'Commitments',
                  screen: const CommitmentsScreen()),
              _QuickTile(
                  icon: Icons.card_giftcard_outlined,
                  label: 'Rewards',
                  screen: const RewardsScreen()),
              _QuickTile(
                  icon: Icons.fitness_center_outlined,
                  label: 'Fitness',
                  screen: const FitnessScreen()),
              _QuickTile(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Finance',
                  screen: const FinanceScreen()),
              _QuickTile(
                  icon: Icons.inventory_2_outlined,
                  label: 'Vaults',
                  screen: const VaultsScreen()),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget screen;
  const _QuickTile(
      {required this.icon, required this.label, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => screen)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
