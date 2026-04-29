# workqueue

## What it is
Like a restaurant's ticket rail where cooks process orders asynchronously without blocking the front-of-house, a workqueue is a kernel mechanism that defers processing tasks to worker threads running in process context. Specifically in Linux, workqueues allow interrupt handlers and other atomic contexts to schedule work that needs sleep-capable operations, executing those tasks later outside the interrupt context.

## Why it matters
Workqueue vulnerabilities have been exploited in privilege escalation attacks — CVE-2022-0516 (KVM workqueue race condition) allowed local attackers to write arbitrary kernel memory by racing workqueue callbacks. Defenders monitoring for unusual kernel thread spawning or workqueue exhaustion can detect certain rootkits that abuse kernel worker threads (`kworker` processes) to hide malicious activity in plain sight within normal system process lists.

## Key facts
- Linux workqueues spawn visible `kworker/X:Y` processes — malware can schedule malicious callbacks here to blend in with legitimate kernel activity
- Workqueue items run in **process context**, meaning they can sleep, allocate memory, and call blocking functions — unlike softirqs or tasklets
- A **use-after-free** vulnerability pattern commonly targets workqueue callbacks: if the containing object is freed before the queued work executes, the callback operates on freed memory
- `flush_workqueue()` and `cancel_work_sync()` are synchronization primitives — missing these calls is a classic race condition bug leading to exploitable UAF conditions
- Concurrency Managed Workqueue (CMWQ), introduced in Linux 2.6.36, dynamically manages worker thread pools — misconfigured workqueue priorities can cause denial-of-service via starvation

## Related concepts
[[use-after-free]] [[race condition]] [[privilege escalation]] [[kernel exploitation]] [[rootkit]]