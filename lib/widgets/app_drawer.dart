import 'dart:io';
import 'package:flutter/material.dart';
import '../main.dart';
import '../data/database.dart';
import '../theme/app_theme.dart';
import '../state/app_settings.dart';
import '../widgets/route_transitions.dart';
import '../screens/dashboard_screen.dart';
import '../screens/tasks_screen.dart';
import '../screens/goals_screen.dart';
import '../screens/commitments_screen.dart';
import '../screens/rewards_screen.dart';
import '../screens/fitness_screen.dart';
import '../screens/finance_screen.dart';
import '../screens/vaults_screen.dart';
import '../screens/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _navigate(BuildContext context, Widget screen) {
    Navigator.pop(context); // close drawer first
    Navigator.push(
      context,
      appRoute(screen, reduceMotion: AppSettings.reduceMotion.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            StreamBuilder<UserProfileData>(
              stream: db.watchProfile(),
              builder: (context, snapshot) {
                final profile = snapshot.data;
                final avatarPath = profile?.avatarPath;
                final nickname =
                    (profile?.nickname.isNotEmpty ?? false)
                        ? profile!.nickname
                        : 'Welcome';
                return InkWell(
                  onTap: () => _navigate(context, const ProfileScreen()),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: AppColors.primary,
                          backgroundImage: (avatarPath != null &&
                                  File(avatarPath).existsSync())
                              ? FileImage(File(avatarPath))
                              : null,
                          child: (avatarPath == null ||
                                  !File(avatarPath).existsSync())
                              ? const Icon(Icons.person,
                                  color: Colors.white, size: 32)
                              : null,
                        ),
                        const SizedBox(height: 12),
                        Text(nickname,
                            style: Theme.of(context).textTheme.titleMedium),
                        Text('Tap to edit profile',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 12)),
                      ],
                    ),
                  ),
                );
              },
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _tile(context, Icons.home_outlined, 'Dashboard',
                      AppColors.primary, const DashboardScreen()),
                  _tile(
                      context,
                      Icons.check_circle_outline,
                      'Tasks',
                      AppColors.moduleColors['tasks']!,
                      const TasksScreen()),
                  _tile(context, Icons.flag_outlined, 'Goals',
                      AppColors.moduleColors['goals']!, const GoalsScreen()),
                  _tile(
                      context,
                      Icons.local_fire_department_outlined,
                      'Commitments',
                      AppColors.moduleColors['commitments']!,
                      const CommitmentsScreen()),
                  _tile(
                      context,
                      Icons.card_giftcard_outlined,
                      'Rewards',
                      AppColors.moduleColors['rewards']!,
                      const RewardsScreen()),
                  _tile(
                      context,
                      Icons.fitness_center_outlined,
                      'Fitness',
                      AppColors.moduleColors['fitness']!,
                      const FitnessScreen()),
                  _tile(
                      context,
                      Icons.account_balance_wallet_outlined,
                      'Finance',
                      AppColors.moduleColors['finance']!,
                      const FinanceScreen()),
                  _tile(
                      context,
                      Icons.inventory_2_outlined,
                      'Vaults',
                      AppColors.moduleColors['vaults']!,
                      const VaultsScreen()),
                  const Divider(),
                  _tile(context, Icons.person_outline, 'Profile',
                      AppColors.textSecondary, const ProfileScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String label,
      Color color, Widget screen) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label),
      onTap: () => _navigate(context, screen),
    );
  }
}
