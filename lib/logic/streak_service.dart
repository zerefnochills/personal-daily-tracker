import '../data/database.dart';

/// Handles the "is today's target met / what's the current streak" math
/// for the Discipline Engine. Kept separate from the widgets so the streak
/// logic can be reasoned about (and unit-tested) without any UI involved.
class StreakService {
  final AppDatabase db;
  StreakService(this.db);

  /// Total minutes logged for [commitmentId] on [date], summing all
  /// sessions that day. An open session (endTime == null, i.e. running
  /// right now) counts its elapsed time up to "now".
  Future<int> minutesOnDate(int commitmentId, DateTime date) async {
    final sessions = await db.sessionsOnDate(commitmentId, date);
    var totalSeconds = 0;
    final now = DateTime.now();
    for (final s in sessions) {
      final end = s.endTime ?? now;
      totalSeconds += end.difference(s.startTime).inSeconds;
    }
    return totalSeconds ~/ 60;
  }

  Future<bool> targetMetOnDate(
      int commitmentId, DateTime date, int targetMinutes) async {
    final minutes = await minutesOnDate(commitmentId, date);
    return minutes >= targetMinutes;
  }

  /// Walks backward day-by-day from today. A day counts toward the streak
  /// if the target was met OR a Life Pass was used that day. Stops at the
  /// first day where neither is true. Today itself is only required to be
  /// "in progress or met" — if today hasn't been touched at all yet, we
  /// don't break the streak for it (the day isn't over), we just don't
  /// count it either; the streak reflects days up through yesterday plus
  /// today only if today already qualifies.
  Future<int> currentStreak(int commitmentId, int targetMinutes,
      {int maxLookbackDays = 400}) async {
    final today = DateTime.now();
    var streak = 0;
    var checkingToday = true;

    for (var i = 0; i < maxLookbackDays; i++) {
      final date = DateTime(today.year, today.month, today.day)
          .subtract(Duration(days: i));

      final met = await targetMetOnDate(commitmentId, date, targetMinutes);
      final passUsed = await db.passUsedOnDate(commitmentId, date);

      if (met || passUsed) {
        streak++;
        checkingToday = false;
        continue;
      }

      if (checkingToday) {
        // Today not yet met and no pass used — don't break the streak
        // for an unfinished day, just don't count it, and move on to
        // check yesterday onward.
        checkingToday = false;
        continue;
      }

      // A genuinely missed day with no pass — streak ends here.
      break;
    }

    return streak;
  }

  Future<int> lifePassesRemainingThisMonth() async {
    final now = DateTime.now();
    final used = await db.monthlyLifePassesUsed(now.year, now.month);
    const monthlyAllowance = 4;
    final remaining = monthlyAllowance - used;
    return remaining < 0 ? 0 : remaining;
  }

  /// Highest current streak across all active commitments — used for the
  /// dashboard's top-right streak badge. Returns 0 if there are no
  /// commitments yet.
  Future<int> bestActiveStreak() async {
    final active = await db.watchActiveCommitments().first;
    if (active.isEmpty) return 0;
    var best = 0;
    for (final c in active) {
      final streak = await currentStreak(c.id, c.targetMinutes);
      if (streak > best) best = streak;
    }
    return best;
  }
}
