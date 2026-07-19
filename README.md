# Self-Coding Learning Tracker

Interview-prep tutoring program for a ~3 YOE Data Engineer, run by Claude directly in
VS Code using live Jupyter notebooks against real datasets. Goal: rebuild verified,
independent fluency in the fundamentals — not chase new tech — before interviews.

## Why this exists

Most prior projects in this space were built with heavy AI assistance, which inflated
confidence beyond what's independently demonstrable in an interview. This tracker is a
reset: go back to fundamentals, drill volume, verify live rather than read passively.

Full context for how/why this program is run lives in [`claude-context/`](claude-context/)
— read that first if you're a new session picking this up cold.

---

## 📊 Progress

*Updated automatically after each question is worked through and verified live.*

| Topic | Target | Done | Status |
|---|---|---|---|
| **SQL** | 100–200 questions | 0 | 🟡 In progress — beginner |
| **PySpark** | 100–200 questions | 0 | ⚪ Not started |
| **Python** | TBD (scoped after SQL+PySpark) | 0 | ⚪ Not started |
| **Pytest** | TBD | 0 | ⚪ Not started |

**Order:** SQL → PySpark → Python → Pytest. Don't skip ahead — see
[`claude-context/tutoring-plan.md`](claude-context/tutoring-plan.md).

### SQL breakdown

| Level | Done | Notebook |
|---|---|---|
| Beginner | 0/5 | [`01_sql_basics.ipynb`](notebooks/sql/beginner/01_sql_basics.ipynb) — in progress |
| Intermediate | — | not started |
| Advanced | — | not started |
| Interview-style | — | not started |

### Currently up next

Open [`notebooks/sql/beginner/01_sql_basics.ipynb`](notebooks/sql/beginner/01_sql_basics.ipynb),
select the **"Python (SCLT tutor venv)"** kernel, and work through the 5 questions
(SELECT/WHERE/ORDER BY/LIMIT/NULL handling) against `datasets/chinook.db`.

---

## Order of study

1. **SQL** — 100–200 questions, primary focus first
2. **PySpark** — 100–200 questions, includes real execution-time/optimization work
3. **Python**
4. **Pytest**

Each topic (except Pytest) is split into `beginner/` → `intermediate/` → `advanced/` →
`interview_style/`. Pytest is `beginner/` → `intermediate/` only. Don't skip ahead a
level until the previous one is solid.

## How a session works

- Claude asks ~5 questions at a time inside a notebook (markdown cell = question,
  code cell = your answer).
- You answer by writing and running real code/SQL against a real dataset — real output,
  not toy examples.
- Claude reviews the actual output live, corrects, and explains the "why," not just the
  "what" — including interview-style follow-ups (complexity, alternatives, tradeoffs).
- This README's progress table and [`claude-context/progress-log.md`](claude-context/progress-log.md)
  are updated after every question is worked through, so progress is never lost between
  sessions.

## Structure

```
notebooks/
  sql/{beginner,intermediate,advanced,interview_style}/
  pyspark/{beginner,intermediate,advanced,interview_style}/
  python/{beginner,intermediate,advanced,interview_style}/
  pytest/{beginner,intermediate}/
datasets/
  chinook.db          # SQL practice — record-store schema (customers, invoices, tracks...)
  nyc_taxi/            # PySpark-scale practice — ~300MB of real trip data (6 months, 2023)
claude-context/        # handoff notes, learner profile, plan, progress log — read first
.venv/                 # project-local Python env, NOT committed
```

## Environment

A virtual environment is scoped to **this folder only** (`.venv/`), with a dedicated
Jupyter kernel: **"Python (SCLT tutor venv)"**. Select that kernel when opening any
notebook in VS Code.

Installed: `ipykernel`, `jupyter`, `pandas`, `duckdb`, `pytest`, `pyspark`, plus
`openjdk-17-jdk-headless` (system-level — PySpark needs a JVM at runtime, not just the
pip package). PySpark is smoke-tested and confirmed working end to end (`SparkSession`
starts, runs a job, reports version 4.2.0).

Known caveat: pandas 3.0.3 is ahead of what PySpark officially supports, so
`toPandas()`/pandas-UDF paths throw a `FutureWarning`. Not blocking so far.

Setup (already done, kept here for reference / re-setup after a fresh clone):

```bash
sudo apt install -y openjdk-17-jdk-headless   # JVM for PySpark — run manually, Claude can't sudo
python3 -m venv .venv
./.venv/bin/pip install ipykernel jupyter pandas duckdb pytest pyspark
./.venv/bin/python -m ipykernel install --user --name=sclt-venv --display-name "Python (SCLT tutor venv)"
./claude-context/setup_datasets.sh   # downloads chinook.db (if missing) + nyc_taxi parquet
```

## Datasets

- **`datasets/chinook.db`** — SQLite DB, small, real relational schema, **tracked in git**.
  Used for all SQL practice via `sqlite3` + `pandas.read_sql_query`.
- **`datasets/nyc_taxi/*.parquet`** — NYC Yellow Taxi trip records, Jan–Jun 2023, ~300MB
  total. Big enough to make partitioning/shuffle/caching/broadcast-join optimizations
  show a *real* measurable time difference locally in PySpark. **Gitignored** (too large
  to be worth committing) — regenerate anytime with `claude-context/setup_datasets.sh`.

## Start here

Open [`notebooks/sql/beginner/01_sql_basics.ipynb`](notebooks/sql/beginner/01_sql_basics.ipynb).
