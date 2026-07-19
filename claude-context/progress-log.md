# Progress log

Newest entry on top. Update at the end of every study session.

---

## 2026-07-19 — Program setup

- Set up project-local `.venv` with `ipykernel`, `jupyter`, `pandas`, `duckdb`, `pytest`,
  `pyspark`; registered Jupyter kernel "Python (SCLT tutor venv)". Network was unstable
  during install (repeated timeouts) but `pyspark` ultimately installed successfully.
  **Java/JVM is still missing** on this machine (`pyspark` needs one at runtime, separate
  from the pip package) — Claude can't install it (`sudo` needs an interactive password).
  User needs to run `sudo apt install -y openjdk-17-jdk-headless` themselves before any
  PySpark notebook that actually starts a `SparkSession` will work.
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
