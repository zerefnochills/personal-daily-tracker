import 'package:flutter/material.dart';
import '../main.dart';
import '../data/database.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/streak_badge.dart';
import '../widgets/speed_dial_fab.dart';
import '../widgets/animated_entrance_tile.dart';
import '../widgets/route_transitions.dart';
import '../state/app_settings.dart';
import '../logic/recent_activity_service.dart';
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

  static const _quickAccess = [
    ('tasks', Icons.check_circle_outline, 'Tasks'),
    ('goals', Icons.flag_outlined, 'Goals'),
    ('commitments', Icons.local_fire_department_outlined, 'Commitments'),
    ('rewards', Icons.card_giftcard_outlined, 'Rewards'),
    ('fitness', Icons.fitness_center_outlined, 'Fitness'),
    ('finance', Icons.account_balance_wallet_outlined, 'Finance'),
    ('vaults', Icons.inventory_2_outlined, 'Vaults'),
  ];

  Widget _screenFor(String key) {
    switch (key) {
      case 'tasks':
        return const TasksScreen();
      case 'goals':
        return const GoalsScreen();
      case 'commitments':
        return const CommitmentsScreen();
      case 'rewards':
        return const RewardsScreen();
      case 'fitness':
        return const FitnessScreen();
      case 'finance':
        return const FinanceScreen();
      case 'vaults':
        return const VaultsScreen();
      default:
        return const DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LifeOS'),
        actions: const [StreakBadge()],
      ),
      drawer: const AppDrawer(),
      floatingActionButton: const SpeedDialFab(),
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
          FutureBuilder<List<RecentActivityItem>>(
            future: fetchRecentActivity(db),
            builder: (context, snapshot) {
              final items = snapshot.data ?? [];
              if (items.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 92,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, i) {
                        final item = items[i];
                        return Container(
                          width: 160,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border(
                              left: BorderSide(color: item.color, width: 4),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item.icon, size: 18, color: item.color),
                              const SizedBox(height: 6),
                              Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(item.subtitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 11)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            },
          ),
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
              for (var i = 0; i < _quickAccess.length; i++)
                AnimatedEntranceTile(
                  index: i,
                  onTap: () => Navigator.push(
                    context,
                    appRoute(
                      _screenFor(_quickAccess[i].$1),
                      reduceMotion: AppSettings.reduceMotion.value,
                    ),
                  ),
                  child: _QuickTile(
                    icon: _quickAccess[i].$2,
                    label: _quickAccess[i].$3,
                    color: AppColors.moduleColors[_quickAccess[i].$1]!,
                  ),
                ),
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
  final Color color;
  const _QuickTile(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(label,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
