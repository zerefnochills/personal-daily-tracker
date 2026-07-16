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
- Dashboard: today's tasks + nav to Tasks/Goals
- Tasks: add (title, priority, due date), complete, swipe-to-delete
- Goals: tabbed by day/week/month/year, add, complete, swipe-to-delete
- Local SQLite via Drift — no backend, no auth, no sync

## Known gaps (intentional, for later phases)
- Goal↔Task linking (`goalId`/`parentGoalId` columns exist in the schema but
  there's no picker UI yet) — add once the basic loop is in daily use
- No reminders/notifications yet — needed before Phase 1 is "done" for the
  calendar/reminder promise in the original doc; small addition
  (flutter_local_notifications) once the CRUD flows feel solid
- Plain Material theme — the Notion + creamish/wine restyle is a separate pass
