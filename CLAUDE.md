# LifeOS — Personal Daily Tracker

## Status
- Phase 1 (Core Daily Loop) skeleton pushed to `main`.
- Phase 2 (Discipline Engine) code pushed to `main`.
- Phase 3 (Fitness + Finance) code pushed to `main`.
- Phase 4 (Vaults) code pushed to `main`.
- UI overhaul (theme, drawer nav, profile, greeting) code pushed to `main`.
- None of it has been built/run locally yet — still untested outside design/review.
- Next up after this: Phase 5 (AI layer) — blocked on LLM API budget (see below), so likely stays paused until that's resolved.

## Approach / Phase Plan (PROTECTED)
1. **Phase 1 — Core Daily Loop (done, unverified):** Dashboard, Tasks CRUD, hierarchical Goals (day/week/month/year), local SQLite via Drift. No backend, no auth, no sync.
2. **Phase 2 — Discipline Engine (done, unverified):** Commitments (study/workout/read/code/custom) with daily minute targets. Sessions are timestamp-based (start/stop saved to DB, elapsed = time math) — deliberately chosen over a live ticking timer/foreground service so progress survives app kill with no extra Android complexity. Streaks computed by walking backward day-by-day (target met OR Life Pass used = day counts). Life Passes: global pool of 4/month shared across all commitments (not per-commitment). Rewards: linked to a commitment + streak-day target, unlock computed dynamically, claiming is manual.
3. **Phase 3 — Fitness + Finance (done, unverified):** Fitness = exercises + logged sets (sets/reps/weight), auto personal-record (max weight per exercise), weekly diet planner (Mon–Sun, repeats weekly, not date-specific). Finance = monthly income (upserted per year/month), expense log with category, auto remaining-balance and category breakdown for the current calendar month. Both modules are self-contained, no dependency on Phase 1/2 data.
4. **Phase 4 — Vaults (done, unverified):** Founder Vault + Knowledge Vault, same schema (title/content/tags) differentiated by `vaultType`, tabbed in one screen. Add/edit/delete, swipe-to-delete, live search via SQL `LIKE` across title/content/tags (not FTS5 — kept simple for a low-volume personal dataset).
5. **UI/Theming overhaul (done, unverified):** Creamish background + wine primary + muted-gold accent palette (`lib/theme/app_theme.dart`). Lora (headings) + Inter (body) via `google_fonts` (fetched from CDN on first run, falls back to system font offline). Shared `AppDrawer` side-nav on every screen with a profile header (avatar + nickname). Dashboard rebuilt: time-of-day greeting + nickname, today's tasks card, 2-column quick-access grid to every module. New `ProfileScreen`: pick avatar from gallery (copied into app storage so it survives cache clears), set nickname.
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
  pubspec.yaml    (added google_fonts, image_picker)
  SETUP.md
  lib/
    main.dart               (applies AppTheme)
    theme/app_theme.dart    (new — colors, typography)
    widgets/app_drawer.dart (new — shared side-nav w/ profile header)
    data/database.dart      (Drift, schema v5: ...previous tables..., UserProfile)
    logic/streak_service.dart
    screens/dashboard_screen.dart  (rewritten — greeting, quick-access grid, drawer)
    screens/profile_screen.dart    (new — avatar picker, nickname)
    screens/tasks_screen.dart
    screens/goals_screen.dart
    screens/commitments_screen.dart
    screens/rewards_screen.dart
    screens/fitness_screen.dart
    screens/finance_screen.dart
    screens/vaults_screen.dart
    (all screens above now include the shared AppDrawer)
```

## Known Gaps (intentional, deferred)
- No goal↔task linking UI yet (`goalId`, `parentGoalId` columns exist in schema)
- No reminders/notifications yet
- No live per-second timer display while a commitment session is running
- Finance is calendar-month only — no custom date range reporting
- Diet plan has no dashboard "what to eat today" surfacing yet
- Vault search is plain LIKE, not fuzzy/semantic (Phase 5 territory)
- Drawer nav pushes new screen instances each time rather than popping to
  an existing one — fine normally, but the back stack can grow if you
  bounce between drawer items a lot. Revisit with
  `Navigator.pushAndRemoveUntil` if that's annoying in practice
- AI layer not started (Phase 5, blocked on LLM API budget — see Status)

## Next Steps
1. Finish local Flutter/Android Studio setup → `flutter doctor` clean
2. `flutter create`, drop in these files, `pub get`, `build_runner build`, `flutter run`
3. First run needs internet once so `google_fonts` can fetch Lora/Inter —
   after that they're cached locally
4. Debugging pass across everything (deferred intentionally — nothing has
   been run yet). Priority checks:
   - Discipline Engine: force-close mid-session, reopen, verify minutes correct; streak logic across a midnight boundary
   - Finance: month rollover scoping
   - Fitness: PR calculation as heavier sets are logged
   - Vaults: search matches across title/content/tags
   - Profile: avatar picker permission flow on a real device, nickname persists after app restart
5. Phase 5 (AI layer) stays paused until there's a decision on LLM API budget/approach
