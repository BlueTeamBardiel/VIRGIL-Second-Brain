# fio

## What it is
Like a stress-testing machine at a car factory that simulates 100,000 miles of road wear in 24 hours, `fio` (Flexible I/O Tester) is a Linux benchmarking tool that generates configurable read/write workloads to measure storage device performance. It allows security professionals and administrators to simulate realistic disk I/O patterns to validate storage performance under forensic acquisition, logging, or high-throughput security operations.

## Why it matters
During incident response, a SIEM or logging system under attack may experience log flooding — an adversary intentionally generating massive event volumes to overwhelm disk I/O and cause log loss. Running `fio` benchmarks beforehand lets defenders verify that their log storage infrastructure can handle peak throughput before a real attack exposes the gap, preventing evidence destruction through resource exhaustion.

## Key facts
- `fio` tests sequential read/write, random read/write, and mixed I/O patterns using job files (`.fio` config format)
- Critical metric output includes **IOPS** (Input/Output Operations Per Second), **latency (ms/µs)**, and **bandwidth (MB/s)** — all relevant to storage triage
- Used in forensic environments to validate write-blocker performance and ensure acquisition speed meets chain-of-custody time requirements
- Can simulate multiple simultaneous threads (`numjobs`) to mirror realistic multi-process logging or database workloads
- Not an offensive tool, but misuse in shared cloud environments can constitute a **denial-of-service** by monopolizing disk I/O resources (relevant to cloud tenancy abuse)

## Related concepts
[[Log Management]] [[Incident Response]] [[Forensic Acquisition]] [[Denial of Service]] [[SIEM]]