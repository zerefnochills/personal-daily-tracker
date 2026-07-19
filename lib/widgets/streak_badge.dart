import 'package:flutter/material.dart';
import '../main.dart';
import '../logic/streak_service.dart';
import '../theme/app_theme.dart';
import '../widgets/route_transitions.dart';
import '../state/app_settings.dart';
import '../screens/commitments_screen.dart';

class StreakBadge extends StatelessWidget {
  const StreakBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final streakService = StreakService(db);
    return FutureBuilder<int>(
      future: streakService.bestActiveStreak(),
      builder: (context, snapshot) {
        final streak = snapshot.data ?? 0;
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => Navigator.push(
                context,
                appRoute(
                  const CommitmentsScreen(),
                  reduceMotion: AppSettings.reduceMotion.value,
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.moduleColors['commitments']!
                      .withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_fire_department,
                        size: 18,
                        color: AppColors.moduleColors['commitments']),
                    const SizedBox(width: 4),
                    Text(
                      '$streak',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.moduleColors['commitments'],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
