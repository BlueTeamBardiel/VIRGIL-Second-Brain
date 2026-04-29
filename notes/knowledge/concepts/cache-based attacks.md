# cache-based attacks

## What it is
Imagine a librarian who can tell which books you've been reading just by noticing which ones are warm to the touch — without ever seeing you. Cache-based attacks work the same way: an attacker infers secret information by measuring how long memory operations take, since cached data loads faster than uncached data. They are side-channel attacks that exploit CPU or memory cache behavior to leak sensitive data across process or VM boundaries.

## Why it matters
The Flush+Reload attack technique underpins both Spectre and Meltdown — two vulnerabilities disclosed in 2018 that affected virtually every modern processor. Attackers could read kernel memory from user-space processes, breaking the fundamental isolation that operating systems depend on. OS vendors scrambled to deploy microcode updates and kernel patches (like KPTI) that significantly degraded performance on some workloads.

## Key facts
- **Flush+Reload**: attacker flushes a cache line, waits for victim to execute, then measures reload time — fast = victim accessed it, slow = victim didn't
- **Prime+Probe**: attacker fills a cache set with their own data, lets the victim run, then checks which lines were evicted — no shared memory required
- **Spectre/Meltdown** are the highest-profile real-world exploits leveraging cache timing as the exfiltration channel
- Cache-based attacks break **co-location security assumptions** in cloud environments, where VMs share physical hardware
- Defenses include **constant-time programming**, cache partitioning, noise injection, and disabling shared memory between untrusted processes

## Related concepts
[[side-channel attacks]] [[Spectre and Meltdown]] [[timing attacks]] [[hypervisor security]] [[covert channels]]