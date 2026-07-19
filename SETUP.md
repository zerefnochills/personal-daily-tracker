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

## What's in Phase 3 — Fitness + Finance
- Fitness: add exercises, log sets (sets/reps/weight) per exercise, auto
  personal-record display (heaviest weight logged), weekly diet planner
  (Mon–Sun, repeats every week — not tied to specific calendar dates)
- Finance: set monthly income, log expenses with category + optional
  description, auto-calculated remaining balance for the current month,
  category breakdown, swipe-to-delete on expenses
- Both are self-contained modules — no dependency on Phase 1/2 data

## What's in Phase 4 — Vaults
- Founder Vault + Knowledge Vault: same underlying schema (title, content,
  comma-separated tags), differentiated by `vaultType` — tabs in one screen
- Add/edit/delete freeform entries, swipe-to-delete
- Search box filters live via SQL `LIKE` across title/content/tags — not
  SQLite FTS5, kept simple since this is a personal, low-volume dataset;
  revisit only if entry count grows large enough to feel slow

## What's in the UI overhaul
- New palette: creamish background, wine primary, muted-gold accent (see
  `lib/theme/app_theme.dart` for exact hex values)
- New typography: Lora (headings) + Inter (body) via `google_fonts`. These
  are fetched from Google's CDN on first run — needs internet the very
  first time the app launches to look right; falls back to the system font
  gracefully if offline, so nothing breaks either way
- Real navigation: a shared `AppDrawer` (side nav) is now on every screen,
  with a profile header (avatar + nickname, tap to edit) at the top and
  links to every section
- Dashboard: time-of-day greeting ("Good morning/afternoon/evening/night" +
  your nickname if set), today's tasks in a card, and a 2-column quick
  access grid to every module (replacing the old plain button rows)
- Profile screen: tap the avatar to pick a photo from your gallery (saved
  locally into app storage so it survives cache clears), set a nickname
  used in the greeting

## What's in the refinement pass (animations, streaks, richer profile)
- **Streak badge**: top-right of the dashboard app bar, shows your best
  current streak across all active commitments (flame icon + number), tap
  to jump to Commitments
- **Page transitions**: fade + subtle upward slide everywhere instead of
  the plain Material cut (`lib/widgets/route_transitions.dart`)
- **Dashboard quick-access tiles**: staggered entrance animation on load,
  press-scale feedback, and each module now has its own accent color
  (wine/gold/rust/plum/green/teal/umber) instead of one flat color repeated
  seven times
- **Recent activity carousel**: horizontal scrolling cards on the dashboard
  pulling your most recent tasks, commitments, and vault entries — a
  lighter version of a "recents" row
- **Speed-dial FAB**: tap the dashboard's + button to expand quick shortcuts
  to Tasks/Commitments/Finance/Vaults
- **Reward unlock animation**: reward icons pop with a spring animation
  when a streak crosses the unlock threshold
- **Profile screen overhaul**: stats grid (best streak, active commitments,
  tasks completed, vault entries), "Member since" date, a Reduce Motion
  toggle that actually disables the above animations app-wide, and a
  Danger Zone card with a "Reset all local data" action (wipes every
  table, with a confirmation dialog first)
- All new animations respect the Reduce Motion setting — check
  `AppSettings.reduceMotion` (`lib/state/app_settings.dart`) before adding
  any new animated widget so this stays consistent

## Known gaps (intentional, for later)
- Goal↔Task linking (`goalId`/`parentGoalId` columns exist in the schema but
  there's no picker UI yet)
- No reminders/notifications yet
- No live per-second timer display while a commitment session is running
- Finance is calendar-month only — no custom date range reporting
- Diet plan has no dashboard "what to eat today" surfacing yet
- Vault search is plain LIKE, not fuzzy/semantic (Phase 5 territory)
- Drawer navigation pushes a new screen instance each time rather than
  popping back to an existing one — fine for normal use, but bouncing
  between drawer items a lot will grow the back stack. Revisit with
  `Navigator.pushAndRemoveUntil` later if that becomes annoying in practice
- AI layer not started (Phase 5, blocked on LLM API budget)
