# Tutoring plan

## Topic order

1. **SQL** — primary rewind/focus, start here. Target: 100–200 questions.
2. **PySpark** — target: 100–200 questions, includes real optimization/execution-time work.
3. **Python**
4. **Pytest**

Don't move to the next topic until the current one's most advanced level is solid,
unless the user explicitly asks to jump around.

## Level structure (per topic)

- `sql/`, `pyspark/`, `python/` → `beginner/` → `intermediate/` → `advanced/` → `interview_style/`
- `pytest/` → `beginner/` → `intermediate/` only (no advanced/interview_style — pytest
  scope for a 3 YOE role doesn't need it)

Progress sequentially within a topic. Use `progress-log.md` to track which level/notebook
is currently active, and `README.md` at repo root for the live question-count tracker.

## Session format

- Work inside `.ipynb` notebooks in VS Code, using the **"Python (SCLT tutor venv)"**
  kernel (project-local `.venv`, not global).
- Claude poses ~5 questions per notebook/session as markdown cells.
- Learner answers in code cells (SQL via sqlite3/pandas, or PySpark/Python/pytest code)
  and runs them to get real output.
- Claude reviews the actual output live — corrects mistakes, explains reasoning,
  connects to interview-style follow-ups ("why this over a subquery," "what's the
  complexity here," etc.) rather than just marking right/wrong.
- Real datasets live in `datasets/` (Chinook SQLite DB for SQL, NYC Taxi parquet for
  PySpark) so answers produce genuine output, not toy examples.

## Environment

- Virtual environment: `.venv/` at repo root, **scoped to this project only**.
- Jupyter kernel name: `sclt-venv`, display name: "Python (SCLT tutor venv)".
- Installed: `ipykernel`, `jupyter`, `pandas`, `duckdb`, `pytest`, `pyspark`.
- **Java/JVM:** PySpark needs a JVM at runtime, separate from the pip package. Not
  scoped to the project venv — always a system-level `apt` install, and Claude cannot
  run `sudo` (no interactive password). If `SparkSession.builder.getOrCreate()` fails,
  check `java -version` first and ask the user to run
  `sudo apt install -y openjdk-17-jdk-headless` themselves.

## Datasets

- `datasets/chinook.db` — SQLite, real relational schema (customers/invoices/tracks/
  artists/employees). Used for all SQL practice.
- `datasets/nyc_taxi/*.parquet` — NYC Yellow Taxi trips, Jan–Jun 2023, ~300MB total.
  Large enough that partitioning/shuffle/caching/broadcast-join choices in PySpark
  produce a real, measurable local time difference — not a toy dataset. The user has
  pre-approved scaling this up to 20–50GB later if PySpark optimization work calls for
  it — ask first before pulling that much down.
