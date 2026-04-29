# fio job file

## What it is
Like a recipe card telling a chef exactly how to stress-test an oven — what temperature, how long, how many dishes at once — an fio job file is a configuration script that tells the **Flexible I/O Tester (fio)** precisely how to hammer a storage device with synthetic workloads. It defines parameters like I/O depth, block size, read/write ratio, and runtime in a structured INI-style text file.

## Why it matters
In a forensic investigation or incident response scenario, an attacker may use fio with a destructive job file (e.g., `rw=write`, `bs=1M`, `filename=/dev/sda`) to rapidly overwrite a disk and destroy evidence — a form of anti-forensics. Defenders analyzing compromised systems should recognize fio artifacts in bash history, cron jobs, or scheduled tasks as potential indicators of data destruction or cover-up activity.

## Key facts
- A job file uses INI syntax with a `[global]` section for shared settings and named `[jobname]` sections for individual workloads.
- Critical destructive parameters: `rw=write` (sequential write), `rw=randwrite` (random write), combined with `filename=/dev/sdX` targeting raw block devices — bypassing filesystem protections.
- `iodepth` controls outstanding I/O requests; high values (e.g., 128) maximize throughput and accelerate overwrite speed.
- `runtime` and `size` parameters control how long or how much data fio writes — omitting `size` with `loops=0` can result in indefinite disk destruction.
- fio is a legitimate performance benchmarking tool (used by SREs and storage engineers), making it a **dual-use tool** — it won't trigger AV, which is why adversaries favor it for data wiping.

## Related concepts
[[Anti-Forensics]] [[Data Destruction Attack]] [[Dual-Use Security Tools]]