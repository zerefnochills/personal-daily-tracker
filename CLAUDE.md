# LifeOS — Personal Daily Tracker

## Status
- Phase 1 (Core Daily Loop) skeleton pushed to `main`.
- Phase 2 (Discipline Engine) code pushed to `main`.
- Neither phase has been built/run locally yet — still untested outside design/review.
- Currently: Deepak setting up Flutter + Android Studio on his dev machine.

## Approach / Phase Plan (PROTECTED)
1. **Phase 1 — Core Daily Loop (done, unverified):** Dashboard, Tasks CRUD, hierarchical Goals (day/week/month/year), local SQLite via Drift. No backend, no auth, no sync.
2. **Phase 2 — Discipline Engine (done, unverified):** Commitments (study/workout/read/code/custom) with daily minute targets. Sessions are timestamp-based (start/stop saved to DB, elapsed = time math) — deliberately chosen over a live ticking timer/foreground service so progress survives app kill with no extra Android complexity. Streaks computed by walking backward day-by-day (target met OR Life Pass used = day counts). Life Passes: global pool of 4/month shared across all commitments (not per-commitment). Rewards: linked to a commitment + streak-day target, unlock computed dynamically, claiming is manual.
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
    data/database.dart       (Drift: Goals, Tasks, Commitments, CommitmentSessions, LifePassUsage, Rewards — schema v2)
    logic/streak_service.dart (streak/target/life-pass calculations, kept separate from UI)
    screens/dashboard_screen.dart
    screens/tasks_screen.dart
    screens/goals_screen.dart
    screens/commitments_screen.dart
    screens/rewards_screen.dart
```

## Known Gaps (intentional, deferred)
- No goal↔task linking UI yet (`goalId`, `parentGoalId` columns exist in schema)
- No reminders/notifications yet
- No live per-second timer display while a commitment session is running —
  tile refreshes every 20s cosmetically; underlying data is always correct
  regardless (timestamp-based)
- Fitness/Finance modules not started (Phase 3)
- Vaults not started (Phase 4)
- AI layer not started (Phase 5)

## Next Steps
1. Finish local Flutter/Android Studio setup → `flutter doctor` clean
2. `flutter create`, drop in these files, `pub get`, `build_runner build`, `flutter run`
3. Use Phases 1+2 daily for ~1 week — specifically watch for: does the
   20s-refresh session tile feel laggy? Does the streak logic (today not
   breaking an unfinished day) match intuition in practice?
4. Then start Phase 3: Fitness + Finance modules
