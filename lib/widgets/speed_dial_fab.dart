import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/route_transitions.dart';
import '../state/app_settings.dart';
import '../screens/tasks_screen.dart';
import '../screens/commitments_screen.dart';
import '../screens/finance_screen.dart';
import '../screens/vaults_screen.dart';

class SpeedDialFab extends StatefulWidget {
  const SpeedDialFab({super.key});

  @override
  State<SpeedDialFab> createState() => _SpeedDialFabState();
}

class _SpeedDialFabState extends State<SpeedDialFab> {
  bool _open = false;

  void _toggle() => setState(() => _open = !_open);

  void _go(Widget screen) {
    setState(() => _open = false);
    Navigator.push(
      context,
      appRoute(screen, reduceMotion: AppSettings.reduceMotion.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_open) ...[
          _MiniAction(
            label: 'Vaults',
            icon: Icons.inventory_2_outlined,
            color: AppColors.moduleColors['vaults']!,
            onTap: () => _go(const VaultsScreen()),
          ),
          const SizedBox(height: 10),
          _MiniAction(
            label: 'Log expense',
            icon: Icons.account_balance_wallet_outlined,
            color: AppColors.moduleColors['finance']!,
            onTap: () => _go(const FinanceScreen()),
          ),
          const SizedBox(height: 10),
          _MiniAction(
            label: 'Start a session',
            icon: Icons.local_fire_department_outlined,
            color: AppColors.moduleColors['commitments']!,
            onTap: () => _go(const CommitmentsScreen()),
          ),
          const SizedBox(height: 10),
          _MiniAction(
            label: 'New task',
            icon: Icons.check_circle_outline,
            color: AppColors.moduleColors['tasks']!,
            onTap: () => _go(const TasksScreen()),
          ),
          const SizedBox(height: 14),
        ],
        FloatingActionButton(
          onPressed: _toggle,
          child: AnimatedRotation(
            turns: _open ? 0.125 : 0, // 45 degrees when open, plus -> x
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class _MiniAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MiniAction({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(label, style: const TextStyle(fontSize: 13)),
        ),
        const SizedBox(width: 10),
        FloatingActionButton.small(
          heroTag: label,
          backgroundColor: color,
          onPressed: onTap,
          child: Icon(icon, color: Colors.white),
        ),
      ],
    );
  }
}
