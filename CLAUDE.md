# LifeOS — Personal Daily Tracker

## Status
- Phase 1 (Core Daily Loop) skeleton pushed to `main`.
- Phase 2 (Discipline Engine) code pushed to `main`.
- Phase 3 (Fitness + Finance) code pushed to `main`.
- None of the three phases have been built/run locally yet — still untested outside design/review.
- Currently: Deepak setting up Flutter + Android Studio on his dev machine.

## Approach / Phase Plan (PROTECTED)
1. **Phase 1 — Core Daily Loop (done, unverified):** Dashboard, Tasks CRUD, hierarchical Goals (day/week/month/year), local SQLite via Drift. No backend, no auth, no sync.
2. **Phase 2 — Discipline Engine (done, unverified):** Commitments (study/workout/read/code/custom) with daily minute targets. Sessions are timestamp-based (start/stop saved to DB, elapsed = time math) — deliberately chosen over a live ticking timer/foreground service so progress survives app kill with no extra Android complexity. Streaks computed by walking backward day-by-day (target met OR Life Pass used = day counts). Life Passes: global pool of 4/month shared across all commitments (not per-commitment). Rewards: linked to a commitment + streak-day target, unlock computed dynamically, claiming is manual.
3. **Phase 3 — Fitness + Finance (done, unverified):** Fitness = exercises + logged sets (sets/reps/weight), auto personal-record (max weight per exercise), weekly diet planner (Mon–Sun, repeats weekly, not date-specific). Finance = monthly income (upserted per year/month), expense log with category, auto remaining-balance and category breakdown for the current calendar month. Both modules are self-contained, no dependency on Phase 1/2 data.
4. **Phase 4 — Vaults (not started):** Founder Vault + Knowledge Vault, freeform capture + tags + full-text search.
5. **Phase 5 — AI layer (not started):** Hybrid RAG pipeline over the vaults.
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
    data/database.dart       (Drift, schema v3: Goals, Tasks, Commitments, CommitmentSessions, LifePassUsage, Rewards, Exercises, WorkoutEntries, DietPlanEntries, MonthlyIncome, Expenses)
    logic/streak_service.dart (streak/target/life-pass calculations, kept separate from UI)
    screens/dashboard_screen.dart
    screens/tasks_screen.dart
    screens/goals_screen.dart
    screens/commitments_screen.dart
    screens/rewards_screen.dart
    screens/fitness_screen.dart
    screens/finance_screen.dart
```

## Known Gaps (intentional, deferred)
- No goal↔task linking UI yet (`goalId`, `parentGoalId` columns exist in schema)
- No reminders/notifications yet
- No live per-second timer display while a commitment session is running —
  tile refreshes every 20s cosmetically; underlying data is always correct
  regardless (timestamp-based)
- Finance is calendar-month only — no custom date range reporting
- Diet plan has no dashboard "what to eat today" surfacing yet
- Vaults not started (Phase 4)
- AI layer not started (Phase 5)

## Next Steps
1. Finish local Flutter/Android Studio setup → `flutter doctor` clean
2. `flutter create`, drop in these files, `pub get`, `build_runner build`, `flutter run`
3. Debugging pass across all 3 phases together (deferred intentionally during
   build — nothing has been run yet). Priority checks:
   - Discipline Engine: force-close mid-session, reopen, verify minutes correct; verify streak logic across a midnight boundary
   - Finance: verify month rollover (income/expenses correctly scoped to the right year+month)
   - Fitness: verify PR calculation updates correctly as new heavier sets are logged
4. Then start Phase 4: Vaults (Founder Vault + Knowledge Vault)
