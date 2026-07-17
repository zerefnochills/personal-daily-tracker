import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../main.dart';
import '../data/database.dart';
import '../theme/app_theme.dart';
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

    // Copy into app documents dir so the path stays valid even if the
    // original picked file (e.g. a cache file) gets cleared later.
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

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 32),
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
            ],
          );
        },
      ),
    );
  }
}
