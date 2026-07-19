import 'dart:async';
import 'package:flutter/material.dart';
import 'data/database.dart';
import 'screens/dashboard_screen.dart';
import 'theme/app_theme.dart';
import 'state/app_settings.dart';

// Single shared DB instance for the app. Fine for Phase 1 scope;
// revisit if we introduce a proper DI setup later.
late AppDatabase db;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  db = AppDatabase();
  runApp(const LifeOSApp());
}

class LifeOSApp extends StatefulWidget {
  const LifeOSApp({super.key});

  @override
  State<LifeOSApp> createState() => _LifeOSAppState();
}

class _LifeOSAppState extends State<LifeOSApp> {
  StreamSubscription<UserProfileData>? _profileSub;

  @override
  void initState() {
    super.initState();
    // Keep the in-memory reduce-motion flag in sync with whatever's stored
    // in the profile row, so widgets that read AppSettings.reduceMotion
    // directly (rather than re-querying the DB) stay correct.
    _profileSub = db.watchProfile().listen((profile) {
      AppSettings.reduceMotion.value = profile.reduceMotion;
    });
  }

  @override
  void dispose() {
    _profileSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeOS',
      theme: AppTheme.themeData,
      home: const DashboardScreen(),
    );
  }
}
