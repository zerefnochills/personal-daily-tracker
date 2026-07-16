# LifeOS — Personal Daily Tracker

## Status
- Phase 1 (Core Daily Loop) skeleton pushed to `main`. Not yet built/run locally.
- Currently: Deepak setting up Flutter + Android Studio on his dev machine.

## Approach / Phase Plan (PROTECTED)
1. **Phase 1 — Core Daily Loop (current):** Dashboard, Tasks CRUD, hierarchical Goals (day/week/month/year), local SQLite via Drift. No backend, no auth, no sync.
2. **Phase 2 — Discipline Engine (next):** Timer-based commitments (study/workout/read/code), streaks, 4 monthly Life Passes, reward system. Hardest part: timers surviving app kill (foreground service / WorkManager on Android).
3. **Phase 3 — Fitness + Finance:** Gym log (sets/reps/weights/PRs) + diet planner; income/expense tracker with auto-balance. Self-contained modules.
4. **Phase 4 — Vaults:** Founder Vault + Knowledge Vault, freeform capture + tags + full-text search (SQLite FTS, no AI yet).
5. **Phase 5 — AI layer (optional, later):** Plug existing Hybrid RAG pipeline (HyDE + FAISS + BM25 + RRF + reranker) over the vaults. Only after real data exists in Phases 1–4.

## Key Decisions

| Decision | Rationale |
|---|---|
| Android-only, no Windows/cross-platform sync | Removes hardest problem (multi-device conflict resolution) |
| Flutter + Drift (SQLite), no backend until Phase 5 | Simplicity first |
| Plain Material theme now | Notion-layout + creamish/wine restyle is a separate later pass — don't mix styling with data logic work |

## Structure (PROTECTED)
```
lifeos/
  pubspec.yaml
  SETUP.md
  lib/
    main.dart
    data/database.dart       (Drift: Goals + Tasks tables, schema v1)
    screens/dashboard_screen.dart
    screens/tasks_screen.dart
    screens/goals_screen.dart
```

## Known Gaps (intentional, deferred)
- No goal↔task linking UI yet (`goalId`, `parentGoalId` columns exist in schema)
- No reminders/notifications yet
- No Discipline Engine yet (Phase 2)

## Next Steps
1. Finish local Flutter/Android Studio setup → `flutter doctor` clean
2. `flutter create`, drop in these files, `pub get`, `build_runner build`, `flutter run`
3. Use Phase 1 daily ~1 week before starting Phase 2
4. Design Phase 2: Discipline Engine schema + timer logic
