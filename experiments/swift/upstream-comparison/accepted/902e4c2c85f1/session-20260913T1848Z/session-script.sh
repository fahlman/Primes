#!/bin/sh
# Accepted upstream comparison at cutoff 111: run at halftime, machine quiet.
set -eu
REPO=/Users/ryan/Developer/Primes
CAND=902e4c2c85f198fdb2c93457f7c9f0307d750934
OUT="$1"   # a new directory for this session's record and condition snapshots
LOCK=/tmp/primes-timing.lock
if [ -e "$LOCK" ]; then echo "lock held: $(cat "$LOCK")" >&2; exit 1; fi
mkdir "$OUT"
echo "Claude: accepted upstream comparison session, candidate $CAND (cutoff 111)" > "$LOCK"
trap 'rm -f "$LOCK"' EXIT
pgrep -fl 'swiftc|swift-build|xcodebuild|docker|Music|QuickTime' > "$OUT/competing-processes-before.txt" || true
top -l 2 -n 12 -o cpu -stats pid,cpu,command | tail -14 > "$OUT/top-before.txt"
swift "$REPO/fork/swift/compare-upstream.swift" --repo "$REPO" --candidate "$CAND" --output "$OUT/upstream-cutoff111.json" 2>&1 | tee "$OUT/session.log"
top -l 2 -n 12 -o cpu -stats pid,cpu,command | tail -14 > "$OUT/top-after.txt"
jq '{recorded_at_utc, cpu, candidate: .candidate.revision, median_ms, speedups}' "$OUT/upstream-cutoff111.json"
