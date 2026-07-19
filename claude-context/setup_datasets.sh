#!/usr/bin/env bash
# Regenerates datasets/ locally. datasets/nyc_taxi/ is gitignored (large binaries,
# not worth committing) — run this after a fresh clone before starting PySpark work.
# datasets/chinook.db is small and tracked in git, so this script leaves it alone
# unless it's missing.
set -euo pipefail
cd "$(dirname "$0")/.."

mkdir -p datasets/nyc_taxi

if [ ! -f datasets/chinook.db ]; then
  echo "chinook.db missing — fetching..."
  curl -sSL -o datasets/chinook.db \
    "https://github.com/lerocha/chinook-database/raw/master/ChinookDatabase/DataSources/Chinook_Sqlite.sqlite"
fi

# NYC Yellow Taxi trip data (parquet, ~50MB/month) — used for PySpark-scale exercises
# where partitioning/shuffle/caching produce a real, observable timing difference.
for m in 2023-01 2023-02 2023-03 2023-04 2023-05 2023-06; do
  f="datasets/nyc_taxi/yellow_tripdata_${m}.parquet"
  if [ ! -s "$f" ]; then
    echo "fetching $m..."
    curl -sS -C - --retry 8 --retry-delay 3 -o "$f" \
      "https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_${m}.parquet"
  fi
done

echo "Datasets ready:"
du -sh datasets/chinook.db datasets/nyc_taxi
