# LifeOS — Personal Daily Tracker

## Status
- Phase 1 (Core Daily Loop) skeleton pushed to `main`.
- Phase 2 (Discipline Engine) code pushed to `main`.
- Phase 3 (Fitness + Finance) code pushed to `main`.
- Phase 4 (Vaults) code pushed to `main`.
- None of the four phases have been built/run locally yet — still untested outside design/review.
- **Build paused here by design.** Next planned work is a UI/theming pass (Notion-style layout + creamish/wine color palette + better fonts — currently plain Material) before touching Phase 5. Phase 5 also has an open blocker: no paid LLM API budget yet, so free-tier API keys are the only option and are "of literally no use" per Deepak — needs a real plan before Phase 5 starts (see note in Phase 5 section below).

## Approach / Phase Plan (PROTECTED)
1. **Phase 1 — Core Daily Loop (done, unverified):** Dashboard, Tasks CRUD, hierarchical Goals (day/week/month/year), local SQLite via Drift. No backend, no auth, no sync.
2. **Phase 2 — Discipline Engine (done, unverified):** Commitments (study/workout/read/code/custom) with daily minute targets. Sessions are timestamp-based (start/stop saved to DB, elapsed = time math) — deliberately chosen over a live ticking timer/foreground service so progress survives app kill with no extra Android complexity. Streaks computed by walking backward day-by-day (target met OR Life Pass used = day counts). Life Passes: global pool of 4/month shared across all commitments (not per-commitment). Rewards: linked to a commitment + streak-day target, unlock computed dynamically, claiming is manual.
3. **Phase 3 — Fitness + Finance (done, unverified):** Fitness = exercises + logged sets (sets/reps/weight), auto personal-record (max weight per exercise), weekly diet planner (Mon–Sun, repeats weekly, not date-specific). Finance = monthly income (upserted per year/month), expense log with category, auto remaining-balance and category breakdown for the current calendar month. Both modules are self-contained, no dependency on Phase 1/2 data.
4. **Phase 4 — Vaults (done, unverified):** Founder Vault + Knowledge Vault, same schema (title/content/tags) differentiated by `vaultType`, tabbed in one screen. Add/edit/delete, swipe-to-delete, live search via SQL `LIKE` across title/content/tags (not FTS5 — kept simple for a low-volume personal dataset).
5. **UI/Theming pass (next, before Phase 5):** Notion-style layout + creamish/wine color palette + better fonts. Currently everything is plain Material on purpose, so styling and data logic weren't fought simultaneously.
6. **Phase 5 — AI layer (blocked, not started):** Hybrid RAG pipeline over the vaults. Blocked on: no paid LLM API budget currently — free-tier keys considered inadequate for this use case. Needs a decision on approach (e.g., a cheaper/free-tier-viable model, on-device embedding + retrieval with only occasional paid calls, or waiting until budget exists) before this phase can start meaningfully.
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
    data/database.dart       (Drift, schema v4: Goals, Tasks, Commitments, CommitmentSessions, LifePassUsage, Rewards, Exercises, WorkoutEntries, DietPlanEntries, MonthlyIncome, Expenses, VaultEntries)
    logic/streak_service.dart (streak/target/life-pass calculations, kept separate from UI)
    screens/dashboard_screen.dart
    screens/tasks_screen.dart
    screens/goals_screen.dart
    screens/commitments_screen.dart
    screens/rewards_screen.dart
    screens/fitness_screen.dart
    screens/finance_screen.dart
    screens/vaults_screen.dart
```

## Known Gaps (intentional, deferred)
- No goal↔task linking UI yet (`goalId`, `parentGoalId` columns exist in schema)
- No reminders/notifications yet
- No live per-second timer display while a commitment session is running —
  tile refreshes every 20s cosmetically; underlying data is always correct
  regardless (timestamp-based)
- Finance is calendar-month only — no custom date range reporting
- Diet plan has no dashboard "what to eat today" surfacing yet
- Vault search is plain LIKE, not fuzzy/semantic (that's what Phase 5 adds)
- Plain Material theme (next phase of work)
- AI layer not started (Phase 5, blocked on LLM API budget — see Status)

## Next Steps
1. Finish local Flutter/Android Studio setup → `flutter doctor` clean
2. `flutter create`, drop in these files, `pub get`, `build_runner build`, `flutter run`
3. Debugging pass across all 4 phases together (deferred intentionally during
   build — nothing has been run yet). Priority checks:
   - Discipline Engine: force-close mid-session, reopen, verify minutes correct; verify streak logic across a midnight boundary
   - Finance: verify month rollover (income/expenses correctly scoped to the right year+month)
   - Fitness: verify PR calculation updates correctly as new heavier sets are logged
   - Vaults: verify search matches across title/content/tags as expected
4. **Paused here by Deepak's choice.** Next actual work is a UI/theming pass
   (Notion-style layout, creamish/wine palette, better fonts) — not more
   phases. Phase 5 (AI layer) comes after that, and needs an LLM API/budget
   decision first (see Status).
