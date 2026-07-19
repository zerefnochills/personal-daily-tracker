# LifeOS — Personal Daily Tracker

## Status
- Phase 1 (Core Daily Loop) skeleton pushed to `main`.
- Phase 2 (Discipline Engine) code pushed to `main`.
- Phase 3 (Fitness + Finance) code pushed to `main`.
- Phase 4 (Vaults) code pushed to `main`.
- UI overhaul (theme, drawer nav, profile, greeting) code pushed to `main`.
- **Milestone: Flutter build confirmed working** — Deepak got the app running and shared real screenshots for the first time. Everything up to that point renders correctly (dashboard, drawer, profile header).
- Refinement pass (streak badge, animations, richer profile, colorful module accents) code pushed to `main`, in response to feedback that the UI felt generic/"vibe coded." Not yet re-verified on device since this pass.
- Next up after this: Phase 5 (AI layer) — still blocked on LLM API budget (see below).

## Approach / Phase Plan (PROTECTED)
1. **Phase 1 — Core Daily Loop (done, unverified):** Dashboard, Tasks CRUD, hierarchical Goals (day/week/month/year), local SQLite via Drift. No backend, no auth, no sync.
2. **Phase 2 — Discipline Engine (done, unverified):** Commitments (study/workout/read/code/custom) with daily minute targets. Sessions are timestamp-based (start/stop saved to DB, elapsed = time math) — deliberately chosen over a live ticking timer/foreground service so progress survives app kill with no extra Android complexity. Streaks computed by walking backward day-by-day (target met OR Life Pass used = day counts). Life Passes: global pool of 4/month shared across all commitments (not per-commitment). Rewards: linked to a commitment + streak-day target, unlock computed dynamically, claiming is manual.
3. **Phase 3 — Fitness + Finance (done, unverified):** Fitness = exercises + logged sets (sets/reps/weight), auto personal-record (max weight per exercise), weekly diet planner (Mon–Sun, repeats weekly, not date-specific). Finance = monthly income (upserted per year/month), expense log with category, auto remaining-balance and category breakdown for the current calendar month. Both modules are self-contained, no dependency on Phase 1/2 data.
4. **Phase 4 — Vaults (done, unverified):** Founder Vault + Knowledge Vault, same schema (title/content/tags) differentiated by `vaultType`, tabbed in one screen. Add/edit/delete, swipe-to-delete, live search via SQL `LIKE` across title/content/tags (not FTS5 — kept simple for a low-volume personal dataset).
5. **UI/Theming overhaul (done, verified rendering on device):** Creamish background + wine primary + muted-gold accent palette (`lib/theme/app_theme.dart`). Lora (headings) + Inter (body) via `google_fonts` (fetched from CDN on first run, falls back to system font offline). Shared `AppDrawer` side-nav on every screen with a profile header (avatar + nickname). Dashboard rebuilt: time-of-day greeting + nickname, today's tasks card, 2-column quick-access grid to every module. New `ProfileScreen`: pick avatar from gallery (copied into app storage so it survives cache clears), set nickname.
6. **Refinement pass (done, unverified since this pass):** Requested after Deepak saw the running app and found it "vibe coded" / generic. Added: streak badge top-right of dashboard app bar (best active streak across commitments); fade+slide page transitions everywhere (`lib/widgets/route_transitions.dart`) replacing plain MaterialPageRoute; per-module accent colors (`AppColors.moduleColors`) instead of one flat wine color everywhere; staggered entrance + press-scale animation on dashboard tiles; a horizontal "Recent" activity carousel pulling from tasks/commitments/vault entries; an expanding speed-dial FAB with quick-nav shortcuts; a spring "pop" animation on reward icons when they unlock; and a substantially richer Profile screen (stats grid, member-since date, a functional Reduce Motion toggle, and a Danger Zone "Reset all local data" action). All new animations check `AppSettings.reduceMotion` (`lib/state/app_settings.dart`) and collapse to instant/no-op when it's on.
7. **Phase 5 — AI layer (blocked, not started):** Hybrid RAG pipeline over the vaults. Blocked on: no paid LLM API budget currently — free-tier keys considered inadequate for this use case. Needs a decision on approach (e.g., a cheaper/free-tier-viable model, on-device embedding + retrieval with only occasional paid calls, or waiting until budget exists) before this phase can start meaningfully.
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
  pubspec.yaml    (google_fonts, image_picker)
  SETUP.md
  lib/
    main.dart               (applies AppTheme, syncs reduceMotion from profile at startup)
    theme/app_theme.dart    (colors incl. moduleColors, typography)
    state/app_settings.dart (ValueNotifier<bool> reduceMotion — read by animated widgets)
    widgets/
      app_drawer.dart        (shared side-nav w/ profile header, module-colored icons)
      route_transitions.dart (fade+slide page route helper, respects reduceMotion)
      animated_entrance_tile.dart (staggered entrance + press-scale, respects reduceMotion)
      streak_badge.dart      (dashboard app bar — best active streak)
      speed_dial_fab.dart    (dashboard FAB — expanding quick-nav shortcuts)
    logic/
      streak_service.dart         (streak/target/life-pass calcs + bestActiveStreak)
      recent_activity_service.dart (merges recent tasks/commitments/vault entries)
    data/database.dart      (Drift, schema v6: ...previous tables..., UserProfile w/ memberSince + reduceMotion)
    screens/dashboard_screen.dart  (greeting, recent carousel, colorful animated quick-access grid, streak badge, speed dial FAB)
    screens/profile_screen.dart    (avatar picker, nickname, stats grid, reduce motion toggle, danger zone reset)
    screens/tasks_screen.dart
    screens/goals_screen.dart
    screens/commitments_screen.dart
    screens/rewards_screen.dart    (reward icons animate on unlock)
    screens/fitness_screen.dart
    screens/finance_screen.dart
    screens/vaults_screen.dart
    (all screens include the shared AppDrawer)
```

## Known Gaps (intentional, deferred)
- No goal↔task linking UI yet (`goalId`, `parentGoalId` columns exist in schema)
- No reminders/notifications yet
- No live per-second timer display while a commitment session is running
- Finance is calendar-month only — no custom date range reporting
- Diet plan has no dashboard "what to eat today" surfacing yet
- Vault search is plain LIKE, not fuzzy/semantic (Phase 5 territory)
- Drawer/dashboard nav pushes new screen instances each time rather than
  popping to an existing one — back stack can grow with heavy navigation.
  Revisit with `Navigator.pushAndRemoveUntil` if that's annoying in practice
- Speed-dial FAB shortcuts just navigate to the target screen — they don't
  auto-open that screen's "add" dialog. Would need converting a few
  currently-Stateless screens to Stateful to support an "open add dialog on
  load" flag; skipped for now to avoid unnecessary refactors
- AI layer not started (Phase 5, blocked on LLM API budget — see Status)

## Next Steps
1. Rebuild and reinstall on device after the refinement pass — new
   dependencies (`google_fonts`, `image_picker` were already there;
   nothing new added this pass, just new Dart files) so a plain
   `flutter run` should pick everything up, but do a `flutter clean` first
   since the schema bumped to v6 (SQLite migration path added, but a clean
   install avoids any doubt on a device that already has v5 data)
2. Verify: streak badge shows the right number with 0/1+ active commitments;
   dashboard tiles animate in and don't feel janky; Reduce Motion toggle in
   Profile actually kills the animations when turned on; reward icon pop
   animation triggers correctly the moment a streak crosses the unlock
   threshold; Reset All Data in the Danger Zone actually wipes everything
   and the app doesn't crash on the now-empty tables
3. Original debugging priority list (still applies, now lower priority than
   re-verifying the refinement pass since that touched the most files):
   - Discipline Engine: force-close mid-session, reopen, verify minutes correct; streak logic across a midnight boundary
   - Finance: month rollover scoping
   - Fitness: PR calculation as heavier sets are logged
   - Vaults: search matches across title/content/tags
   - Profile: avatar picker permission flow, nickname persists after restart
4. Phase 5 (AI layer) stays paused until there's a decision on LLM API budget/approach
