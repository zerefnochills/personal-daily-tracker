import 'dart:io';
import 'package:flutter/material.dart';
import '../main.dart';
import '../data/database.dart';
import '../theme/app_theme.dart';
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
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
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
                      const DashboardScreen()),
                  _tile(context, Icons.check_circle_outline, 'Tasks',
                      const TasksScreen()),
                  _tile(context, Icons.flag_outlined, 'Goals',
                      const GoalsScreen()),
                  _tile(context, Icons.local_fire_department_outlined,
                      'Commitments', const CommitmentsScreen()),
                  _tile(context, Icons.card_giftcard_outlined, 'Rewards',
                      const RewardsScreen()),
                  _tile(context, Icons.fitness_center_outlined, 'Fitness',
                      const FitnessScreen()),
                  _tile(context, Icons.account_balance_wallet_outlined,
                      'Finance', const FinanceScreen()),
                  _tile(context, Icons.inventory_2_outlined, 'Vaults',
                      const VaultsScreen()),
                  const Divider(),
                  _tile(context, Icons.person_outline, 'Profile',
                      const ProfileScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(
      BuildContext context, IconData icon, String label, Widget screen) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(label),
      onTap: () => _navigate(context, screen),
    );
  }
}
