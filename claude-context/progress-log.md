# Progress log

Newest entry on top. Update at the end of every study session.

---

## 2026-07-19 — SQL beginner notebook 01 complete

- Learner completed `notebooks/sql/beginner/01_sql_basics.ipynb` (5/5 correct).
  First pass had two issues, both caught in review and fixed by the learner:
  - Q4 asked for top 5 most expensive tracks but used `LIMIT 10` — fixed to `LIMIT 5`.
  - Q3 used double-quoted string literal (`Country = "Canada"`). SQLite tolerates this
    (falls back to treating it as a string literal), but it's non-standard — Postgres/
    MySQL expect single quotes for string literals and double quotes for identifiers.
    Flagged as an interview-relevant portability gotcha; learner switched to `'Canada'`.
- **New standing rule, recorded in `claude-context/README.md` ground rules:** the
  "done" loop is now mandatory and automatic — when the learner says a notebook is
  done, Claude reviews real output (not just "did it run"), updates `README.md` +
  this log, commits + **pushes** to GitHub without asking each time (learner
  explicitly pre-approved auto-push), and hands off the next ~5-question notebook,
  all in the same reply.
- Created `notebooks/sql/beginner/02_joins_and_grouping.ipynb` — INNER JOIN, 3-table
  JOIN, GROUP BY + COUNT, GROUP BY + SUM, HAVING. Reference solutions verified against
  the real DB. Not yet attempted.
- **Current position:** SQL, beginner level, notebook 02, not started (0/5). Running
  total: 5/150 SQL questions done.
- **Next step:** learner works through notebook 02 live, says "done" — Claude reviews,
  updates tracker, commits/pushes, hands off notebook 03 (likely subqueries or basic
  window functions, still beginner-adjacent) automatically.

---

## 2026-07-19 — Program setup

- Set up project-local `.venv` with `ipykernel`, `jupyter`, `pandas`, `duckdb`, `pytest`,
  `pyspark`; registered Jupyter kernel "Python (SCLT tutor venv)". Network was unstable
  during install (repeated timeouts) but `pyspark` ultimately installed successfully.
  Java was missing too (`pyspark` needs a JVM at runtime, separate from the pip package;
  Claude can't install it — `sudo` needs an interactive password) — user installed
  `openjdk-17-jdk-headless` manually. PySpark then smoke-tested end to end
  (`SparkSession` starts, runs a job, reports version 4.2.0) — environment is fully
  functional. Known caveat: pandas 3.0.3 outpaces PySpark's officially supported pandas
  version, so `toPandas()`/pandas-UDF paths throw a `FutureWarning`; not blocking, revisit
  only if it actually breaks something.
- Folder structure reworked per user request: `sql/`, `pyspark/`, `python/` each get
  `beginner/intermediate/advanced/interview_style/`; `pytest/` gets only
  `beginner/intermediate/` (no advanced — not needed at 3 YOE scope).
- Downloaded `datasets/chinook.db` (SQL fixture, tracked in git) and
  `datasets/nyc_taxi/*.parquet` (6 months, Jan–Jun 2023, ~305MB, gitignored — regenerate
  via `claude-context/setup_datasets.sh`). Local network was unstable during setup
  (multiple stalled/partial downloads); all datasets verified complete after retry.
- Created `notebooks/sql/beginner/01_sql_basics.ipynb` — first 5-question session
  (SELECT/WHERE/ORDER BY/LIMIT/NULL handling against Chinook). Reference solutions
  verified to run correctly against the real DB. Not yet attempted by the learner.
- Root `README.md` rewritten as a live progress tracker (question-count table, updated
  after every solved question) rather than a static intro.
- **Current position:** SQL, beginner level, notebook 01, not started (0/5).
- **Next step:** open the notebook, select the "Python (SCLT tutor venv)" kernel, work
  through the 5 questions live. On completion: update the README progress table + this
  log, then generate the next beginner SQL notebook (JOINs/GROUP BY/aggregates).
