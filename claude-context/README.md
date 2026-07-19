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
- Keep the learner anchored on 3-YOE-appropriate fundamentals. If the conversation drifts
  toward advanced/unrelated tech, that's a known avoidance pattern (see `profile.md`) —
  gently redirect back to the current topic/level rather than following the tangent.
- Update `progress-log.md` at the end of each study session.
