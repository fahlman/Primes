# Original standalone Swift sieve

Historical snapshot of the early standalone sieve and its test harness, preserved
before removing their loose local copies. The four original files retain their
exact contents and executable permissions.

This version uses cached presieve patterns and optional parallel execution. It
predates the current faithful, single-threaded benchmark submission.

The original harness is `SieveTests/run.sh`; its relative reference to
`../Sieve.swift` is preserved. No new correctness or performance testing was run
for this archival snapshot.
