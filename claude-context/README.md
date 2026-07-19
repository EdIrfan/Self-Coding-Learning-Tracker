# claude-context

Purpose: let any future Claude session (or a different model entirely) pick up this
tutoring program with zero prior conversation history, just by reading this folder.
All durable context for this project lives **here, in-repo** — not in global/cross-project
memory — by explicit request of the user.

Read in this order:

1. [`profile.md`](profile.md) — who the learner is, why this program exists
2. [`tutoring-plan.md`](tutoring-plan.md) — topic order, level structure, session format
3. [`progress-log.md`](progress-log.md) — what's been covered, what's next, open threads

## Ground rules for whoever picks this up

- SQL → PySpark → Python → Pytest, in that order. Don't reorder without the user asking.
- SQL/PySpark/Python have `beginner/ → intermediate/ → advanced/ → interview_style/`
  notebook folders; Pytest has just `beginner/ → intermediate/`. Don't advance a level
  until the current one is solid — check `progress-log.md` for where things stand.
- Session format: ask ~5 questions at a time in a notebook, review live output, correct
  and explain the "why."
- **Every question must name the exact tables, columns, and join keys involved** —
  never make the learner explore/guess the schema to find a column name. This isn't an
  EDA exercise; the point is practicing SQL/PySpark/Python logic, not schema discovery.
  (Learned the hard way: Q1/Q2 of `notebooks/sql/beginner/02_joins_and_grouping.ipynb`
  said "join on AlbumId" / "on ArtistId" but Q3 just said "join Track to Genre" with no
  key named — learner correctly called this out as inconsistent and unfair.)
- **Before publishing any question, write and actually run a full reference solution
  first — then re-read the question text and check whether that exact solution could
  be reproduced from the text alone, with zero exploration or guessing.** Having a
  verified answer in hand isn't enough if the prompt doesn't fully specify it (join
  keys, which aggregate/column to count, sort column + direction, exact aliases). If
  the reference solution needed a detail the question didn't state, add it before
  posting. (Second instance of this: Q3 said "return ... ordered by NumTracks
  descending" but didn't specify what to aggregate on, and separately the learner's
  correct-logic answer came out unsorted because the question's own sort requirement
  wasn't restated clearly enough at the point of writing the query.)
- Keep the learner anchored on 3-YOE-appropriate fundamentals. If the conversation drifts
  toward advanced/unrelated tech, that's a known avoidance pattern (see `profile.md`) —
  gently redirect back to the current topic/level rather than following the tangent.
- **The "done" loop is mandatory, not optional — do it every time without being asked
  again:** when the learner says a notebook is done, (1) read the actual notebook file
  and check real output against what each question asked (not just "did it run") —
  correct anything wrong before proceeding; (2) once genuinely correct, update the
  `README.md` progress table and add a `progress-log.md` entry; (3) `git add -A`,
  commit, and **push** — every session, automatically, no need to ask permission each
  time (the user explicitly pre-approved this); (4) generate/open the next notebook
  (~5 questions) and hand it off in the same reply. Don't wait for the user to ask for
  any of these steps individually.
