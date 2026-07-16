import 'package:flutter/material.dart';
import 'data/database.dart';
import 'screens/dashboard_screen.dart';

// Single shared DB instance for the app. Fine for Phase 1 scope;
// revisit if we introduce a proper DI setup later.
late AppDatabase db;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  db = AppDatabase();
  runApp(const LifeOSApp());
}

class LifeOSApp extends StatelessWidget {
  const LifeOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeOS',
      // Placeholder theme — swap for the creamish/wine Notion-style theme
      // once Phase 1 data flows are verified.
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.brown),
      home: const DashboardScreen(),
    );
  }
}
