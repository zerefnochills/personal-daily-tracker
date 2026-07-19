import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../main.dart';
import '../data/database.dart';
import '../theme/app_theme.dart';
import '../state/app_settings.dart';
import '../logic/streak_service.dart';
import '../widgets/app_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nicknameController = TextEditingController();
  final _picker = ImagePicker();
  bool _loadedInitial = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (picked == null) return;

    final docsDir = await getApplicationDocumentsDirectory();
    final ext = p.extension(picked.path);
    final destPath = p.join(docsDir.path, 'profile_avatar$ext');
    await File(picked.path).copy(destPath);

    await db.setProfile(avatarPath: destPath);
    setState(() {});
  }

  Future<void> _saveNickname() async {
    await db.setProfile(nickname: _nicknameController.text.trim());
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Saved')));
    }
  }

  Future<void> _toggleReduceMotion(bool value) async {
    await db.setProfile(reduceMotion: value);
    AppSettings.reduceMotion.value = value;
  }

  void _confirmReset(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset all local data?'),
        content: const Text(
          'This permanently deletes every task, goal, commitment, streak, '
          'workout, expense, and vault entry stored on this device. Your '
          'profile will also reset. This cannot be undone.',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () async {
              await db.resetAllData();
              if (ctx.mounted) Navigator.pop(ctx);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All local data reset')),
                );
                setState(() => _loadedInitial = false);
              }
            },
            child: const Text('Delete everything'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final streakService = StreakService(db);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      drawer: const AppDrawer(),
      body: StreamBuilder<UserProfileData>(
        stream: db.watchProfile(),
        builder: (context, snapshot) {
          final profile = snapshot.data;
          if (profile != null && !_loadedInitial) {
            _nicknameController.text = profile.nickname;
            _loadedInitial = true;
          }
          final avatarPath = profile?.avatarPath;
          final hasAvatar = avatarPath != null && File(avatarPath).existsSync();
          final memberSince = profile?.memberSince ?? DateTime.now();
          final reduceMotion = profile?.reduceMotion ?? false;

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickAvatar,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 56,
                        backgroundColor: AppColors.primary,
                        backgroundImage:
                            hasAvatar ? FileImage(File(avatarPath)) : null,
                        child: !hasAvatar
                            ? const Icon(Icons.person,
                                color: Colors.white, size: 56)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit,
                              size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text('Tap the avatar to change your photo',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              Center(
                child: Text('Member since ${_formatDate(memberSince)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 12)),
              ),
              const SizedBox(height: 28),

              // ---- Stats grid ----
              Text('Your stats', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.7,
                children: [
                  FutureBuilder<int>(
                    future: streakService.bestActiveStreak(),
                    builder: (context, s) => _StatCard(
                      icon: Icons.local_fire_department_outlined,
                      color: AppColors.moduleColors['commitments']!,
                      value: '${s.data ?? 0}',
                      label: 'Best streak',
                    ),
                  ),
                  FutureBuilder<int>(
                    future: db.totalActiveCommitmentsCount(),
                    builder: (context, s) => _StatCard(
                      icon: Icons.checklist_outlined,
                      color: AppColors.moduleColors['tasks']!,
                      value: '${s.data ?? 0}',
                      label: 'Active commitments',
                    ),
                  ),
                  FutureBuilder<int>(
                    future: db.totalTasksCompletedCount(),
                    builder: (context, s) => _StatCard(
                      icon: Icons.check_circle_outline,
                      color: AppColors.moduleColors['goals']!,
                      value: '${s.data ?? 0}',
                      label: 'Tasks completed',
                    ),
                  ),
                  FutureBuilder<int>(
                    future: db.totalVaultEntriesCount(),
                    builder: (context, s) => _StatCard(
                      icon: Icons.inventory_2_outlined,
                      color: AppColors.moduleColors['vaults']!,
                      value: '${s.data ?? 0}',
                      label: 'Vault entries',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              TextField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  helperText: 'Used for your home screen greeting',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveNickname,
                child: const Text('Save nickname'),
              ),
              const SizedBox(height: 28),

              // ---- Preferences ----
              Text('Preferences', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Card(
                child: SwitchListTile(
                  title: const Text('Reduce motion'),
                  subtitle: const Text(
                      'Turns off entrance/press animations across the app'),
                  value: reduceMotion,
                  activeColor: AppColors.primary,
                  onChanged: _toggleReduceMotion,
                ),
              ),
              const SizedBox(height: 28),

              // ---- Danger zone ----
              Text('Danger zone',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppColors.danger)),
              const SizedBox(height: 8),
              Card(
                color: AppColors.danger.withOpacity(0.06),
                child: ListTile(
                  title: const Text('Reset all local data'),
                  subtitle: const Text(
                      'Permanently deletes everything stored on this device'),
                  trailing: TextButton(
                    onPressed: () => _confirmReset(context),
                    style: TextButton.styleFrom(foregroundColor: AppColors.danger),
                    child: const Text('Reset'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(value,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
