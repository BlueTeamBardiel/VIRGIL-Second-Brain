# OOM killer

## What it is
Like a triage nurse in a overwhelmed ER who must sacrifice one patient to save the ward, the OOM (Out-Of-Memory) killer is a Linux kernel mechanism that forcibly terminates processes when physical RAM and swap space are completely exhausted. It scores each running process using an "oom_score" (0–1000) and kills the highest-scoring candidate to reclaim memory and keep the system alive.

## Why it matters
Attackers can weaponize OOM conditions deliberately — by flooding a server with memory-exhausting requests, they can force the OOM killer to terminate critical security processes like auditd, syslog daemons, or intrusion detection agents. This creates a blind spot: the attack continues while the system's logging and monitoring infrastructure is silently dead. Defenders tune `/proc/[pid]/oom_score_adj` to protect critical security processes from being killed (setting -1000 makes a process immune).

## Key facts
- The OOM killer calculates `oom_score` based on process memory consumption, runtime, and ownership; root-owned processes get a slight reprieve but are not immune by default
- Setting `oom_score_adj` to **-1000** via `/proc/[pid]/oom_score_adj` makes a process OOM-immune — critical for protecting security daemons
- OOM conditions can be triggered intentionally as a **Denial of Service (DoS)** vector, qualifying as a resource exhaustion attack
- In container environments (Docker/Kubernetes), OOM kills are common and logged; an attacker exploiting a memory leak can trigger container restarts, causing service disruption
- The kernel logs OOM kill events to `/var/log/kern.log` or via `dmesg` — forensically valuable for detecting memory-based DoS attacks

## Related concepts
[[Denial of Service]] [[Resource Exhaustion]] [[Linux Process Hardening]] [[Container Security]] [[Kernel Security Mechanisms]]