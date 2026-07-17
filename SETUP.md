# LifeOS Phase 1 — Setup

This is not a full Flutter project (no Android/iOS platform folders) — it's the
`lib/` source + `pubspec.yaml` for Phase 1. Reason: this sandbox has no Flutter
SDK and no pub.dev access, so the app can't be built/run here. Drop these files
into a real Flutter project on your machine:

1. Create a fresh project (generates the Android platform folders you need):
   flutter create lifeos_app

2. Replace the generated `lib/` and `pubspec.yaml` in `lifeos_app/` with the
   ones from this folder.

3. Get packages:
   cd lifeos_app
   flutter pub get

4. Generate the Drift database code (this creates `lib/data/database.g.dart`,
   which is intentionally not included here since it's generated):
   dart run build_runner build --delete-conflicting-outputs

5. Run it:
   flutter run

## What's in Phase 1
- Dashboard: today's tasks + nav to Tasks/Goals/Commitments/Rewards
- Tasks: add (title, priority, due date), complete, swipe-to-delete
- Goals: tabbed by day/week/month/year, add, complete, swipe-to-delete
- Local SQLite via Drift — no backend, no auth, no sync

## What's in Phase 2 — Discipline Engine
- Commitments: recurring measurable objectives (study/workout/read/code/
  custom) with a daily target in minutes
- Session tracking is timestamp-based, not a live ticking timer — start/stop
  times are saved to the DB, elapsed time is computed as time math. This
  means progress survives the app being killed mid-session with no
  foreground-service complexity needed.
- Streaks: computed in `lib/logic/streak_service.dart`, walking backward
  day-by-day from today. A day counts if the daily target was met OR a
  Life Pass was used that day.
- Life Passes: a global pool of 4/month shared across all commitments
  (not 4 per commitment). Using one on a commitment+date protects that
  commitment's streak for that day.
- Rewards: linked to a commitment + a streak-length target (days). Unlock
  status is computed dynamically from the current streak, not stored;
  claiming is a manual action.

## Known gaps (intentional, for later phases)
- Goal↔Task linking (`goalId`/`parentGoalId` columns exist in the schema but
  there's no picker UI yet) — add once the basic loop is in daily use
- No reminders/notifications yet — small addition
  (flutter_local_notifications) once the CRUD flows feel solid
- No visible "elapsed time so far" live counter while a session is running —
  the tile refreshes every 20s as a cosmetic nicety, not a real-time
  stopwatch. Fine for study/workout sessions; revisit if that bothers you
  in daily use.
- Plain Material theme — the Notion + creamish/wine restyle is a separate pass
