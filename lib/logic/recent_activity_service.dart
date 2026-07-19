import 'package:flutter/material.dart';
import '../data/database.dart';
import '../theme/app_theme.dart';

class RecentActivityItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final DateTime timestamp;

  RecentActivityItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.timestamp,
  });
}

/// Pulls the most recently created/updated items across Tasks, Commitments,
/// and Vault entries and merges them into one recency-sorted feed for the
/// dashboard's "Recent" carousel — a lighter-weight version of what Notion
/// does with its own Recents row.
Future<List<RecentActivityItem>> fetchRecentActivity(AppDatabase db,
    {int limit = 8}) async {
  final items = <RecentActivityItem>[];

  final tasks = await db.watchAllTasks().first;
  for (final t in tasks.take(5)) {
    items.add(RecentActivityItem(
      title: t.title,
      subtitle: 'Task',
      icon: Icons.check_circle_outline,
      color: AppColors.moduleColors['tasks']!,
      timestamp: t.createdAt,
    ));
  }

  final commitments = await db.watchActiveCommitments().first;
  for (final c in commitments.take(5)) {
    items.add(RecentActivityItem(
      title: c.title,
      subtitle: 'Commitment',
      icon: Icons.local_fire_department_outlined,
      color: AppColors.moduleColors['commitments']!,
      timestamp: c.createdAt,
    ));
  }

  final vaultFounder = await db.watchVaultEntries('founder').first;
  final vaultKnowledge = await db.watchVaultEntries('knowledge').first;
  for (final v in [...vaultFounder, ...vaultKnowledge].take(5)) {
    items.add(RecentActivityItem(
      title: v.title,
      subtitle: v.vaultType == 'founder' ? 'Founder Vault' : 'Knowledge Vault',
      icon: Icons.inventory_2_outlined,
      color: AppColors.moduleColors['vaults']!,
      timestamp: v.updatedAt,
    ));
  }

  items.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  return items.take(limit).toList();
}
