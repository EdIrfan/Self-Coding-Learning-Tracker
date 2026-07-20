# Progress log

Newest entry on top. Update at the end of every study session.

---

## 2026-07-20 — SQL intermediate notebook 02 complete

- Learner completed `notebooks/sql/intermediate/02_more_windows_set_ops.ipynb` (5/5
  correct):
  - Q1 (`LAG()`): correct first try.
  - Q2 (running total via `SUM() OVER (... ROWS BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW)`): correct first try.
  - Q3 (`UNION` of `Customer`/`Employee` from Canada): correct first try.
  - Q4 (`NOT IN` set difference for artists with no albums): correct first try.
  - Q5 (multi-CTE, `GenreCounts` → `TopGenres`): first attempt wrote `WITH` twice
    (`WITH GenreCounts AS (...), WITH TopGenres AS (...)`) — SQLite only allows one
    `WITH` keyword introducing a comma-separated CTE chain, so the second `WITH` was a
    syntax error. Learner fixed it by dropping the second `WITH`, re-ran, correct
    output (5 genres with >100 tracks: Rock, Latin, Metal, Alternative & Punk, Jazz).
- **Running total: 25/150.**
- Created `notebooks/sql/intermediate/03_ties_intersect_except.ipynb` — window
  `SUM() OVER ()` with no `PARTITION BY` (percent-of-total pattern), `EXCEPT`,
  `RANK()` within a partition, multi-CTE combining `RANK()` with tie behavior (flagged
  explicitly in the question since ties genuinely produce multiple rows per group —
  not a bug), `INTERSECT`. All 5 reference solutions written and verified against
  `datasets/chinook.db` before publishing (per the ground rule), including checking
  join pairs for non-empty/interesting results (e.g. `Rock ∩ Jazz` artists = 0, so
  switched to `Rock ∩ Alternative & Punk` = 6 artists). Not yet attempted.
- **Next:** notebook 03 done → continue intermediate SQL or move to advanced SQL
  depending on how solid intermediate feels.

---

## 2026-07-19 — SQL intermediate notebook 01 complete

- Learner completed `notebooks/sql/intermediate/01_cte_window_correlated.ipynb` (5/5
  correct after several rounds of fixes):
  - Q1 (CTE + filter + sort): correct first try.
  - Q2 (RANK() PARTITION BY): correct first try.
  - Q3 (ROW_NUMBER() top-N per group): first attempt included an invalid
    `ROWS BETWEEN unbounded_preceding AND current_row` frame clause — SQLite's
    `ROW_NUMBER()` doesn't accept a frame at all, learner correctly identified this.
    Second bug: `rn <= 1` instead of `rn <= 3` (only returned 1 row instead of 3),
    fixed on second pass.
  - Q4 (correlated-style subquery vs. overall average): three rounds of bugs —
    (1) used `WHERE sum(Total) > ...` instead of `HAVING`, since aggregates aren't
    available yet at the `WHERE` stage (pre-grouping); (2) after switching to
    `HAVING`, wrote `AVG(Total)` instead of `AVG(TotalSpent)` inside the subquery —
    the derived table only has a `TotalSpent` column, so SQLite silently resolved
    `Total` by correlating out to the enclosing `Invoice.Total`, turning it into an
    unintended correlated subquery with wrong per-row semantics instead of a fixed
    overall average (no SQL error, just silently wrong output — good "trust but
    verify real output" example); (3) missing `ORDER BY TotalSpent DESC` before
    `LIMIT 10`, so the first 10 rows in arbitrary `GROUP BY` order were returned
    instead of the top 10 by spend. All three fixed, final output matches Q1's
    high-spender list truncated to 10.
  - Q5 (self-join on `Employee.ReportsTo`): correct first try.
- **Current:** SQL intermediate, notebook 02, in progress. Running total: 20/150.
- Created `notebooks/sql/intermediate/02_more_windows_set_ops.ipynb` — LAG/LEAD,
  running total (window frame), UNION, set-difference via `NOT IN`/`EXCEPT`-style
  pattern, multi-CTE query. Reference solutions verified against `datasets/chinook.db`.
  Not yet attempted.
- **Next:** notebook 02 done → continue intermediate SQL (more advanced window/set-op
  patterns) or move to advanced SQL depending on how solid intermediate feels.

---

## 2026-07-19 — SQL beginner notebook 03 complete — beginner SQL closed out

- Learner completed `notebooks/sql/beginner/03_left_join_case_subquery.ipynb` (5/5
  correct, no corrections needed): Q1 LEFT JOIN anti-join (correctly 0 rows, right 3
  cols), Q2 DISTINCT BillingCountry (24 countries, alphabetical), Q3 MIN/MAX/AVG
  Milliseconds in one row, Q4 CASE WHEN + GROUP BY (Short 1462 / Long 2041), Q5
  subquery vs. AVG(UnitPrice) (10 rows, all $1.99 > avg).
- **Beginner SQL fully complete: 15/15.**
- Created `notebooks/sql/intermediate/01_cte_window_correlated.ipynb` — CTE, window
  function (PARTITION BY + RANK/ROW_NUMBER), correlated subquery, self-join. Reference
  solutions verified against `datasets/chinook.db`. Not yet attempted.
- **Current:** SQL intermediate, notebook 01, in progress. Running total: 15/150.
- **Next:** notebook 01 done → next intermediate notebook (more window functions /
  set operations), continuing toward advanced.

---

## 2026-07-19 — SQL beginner notebook 02 complete

- Learner completed `notebooks/sql/beginner/02_joins_and_grouping.ipynb` (5/5 correct).
  Two friction rounds surfaced systemic issues in question quality:
  - Q3 didn't name the join key, inconsistent with Q1/Q2. Learner called it out. Added
    ground rule: every question must name exact tables/columns/join keys — no schema
    exploration.
  - Discovered on review that Q1/Q2 were missing `LIMIT 10` in the actual query despite
    the question asking for it (output showed 3503 rows, not 10). Added stronger ground
    rule: before posting any question, write the full reference solution, then re-check
    the question text alone can reproduce it (verify join keys, aggregate target, sort
    column/direction, aliases are all stated).
  - Final pass: learner added `LIMIT 10` to Q1/Q2, all 5 correct.
- Created `notebooks/sql/beginner/03_left_join_case_subquery.ipynb` — LEFT JOIN
  anti-join, DISTINCT, MIN/MAX/AVG, CASE WHEN + GROUP BY, basic subquery. Last beginner
  notebook. Reference solutions verified. Not yet attempted.
- **Current:** SQL beginner, notebook 03, in progress. Running total: 10/150 questions done.
- **Next:** Notebook 03 done → beginner SQL closed → intermediate (CTEs, window functions,
  correlated subqueries, self-joins).

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
