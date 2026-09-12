#!/usr/bin/python3
"""Forward unchanged arguments to the pinned compiler and record build duration."""
import json
import os
from pathlib import Path
import subprocess
import sys
import time
from datetime import datetime, timezone

compiler = os.environ['PRIMES_REAL_SWIFTC']
log = Path(os.environ['PRIMES_COMPILER_LOG'])
assert Path(compiler).is_absolute() and Path(compiler).resolve() != Path(__file__).resolve()
entry = {'argv': [compiler, *sys.argv[1:]], 'cwd': os.getcwd(),
         'started_at_utc': datetime.now(timezone.utc).isoformat(),
         'is_compile': '-o' in sys.argv[1:], 'pid': os.getpid()}
with log.open('a') as f:
    f.write(json.dumps(dict(entry, event='started')) + '\n')
start = time.perf_counter()
result = subprocess.run(entry['argv'])
entry.update(event='finished', exit_code=result.returncode,
             elapsed_seconds=time.perf_counter() - start,
             finished_at_utc=datetime.now(timezone.utc).isoformat())
with log.open('a') as f:
    f.write(json.dumps(entry) + '\n')
sys.exit(result.returncode if result.returncode >= 0 else 128 - result.returncode)
