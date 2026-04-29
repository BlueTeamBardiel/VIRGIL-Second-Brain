# RCU

## What it is
Like a library that lets readers browse books freely while a librarian quietly swaps out old editions for new ones — readers never get blocked, but the old copy stays available until everyone's done reading. Read-Copy-Update (RCU) is a Linux kernel synchronization mechanism that allows multiple readers to access shared data concurrently without locking, while writers create an updated copy and atomically swap it in, deferring cleanup until all pre-existing readers have finished.

## Why it matters
RCU has been the target of kernel exploitation techniques where attackers exploit the **grace period** — the window between when a pointer is updated and when the old object is freed. CVE-2022-4543 and similar "use-after-free" kernel bugs have leveraged RCU reclamation timing to access freed memory, allowing privilege escalation from unprivileged user space to root — a critical vector in container escape attacks.

## Key facts
- RCU allows **concurrent reads with zero locking overhead**, making it common in performance-critical kernel paths like networking and filesystem code
- The **grace period** is the dangerous window: old data objects are freed only after all readers holding references at the time of the update have completed
- **Use-after-free vulnerabilities** in RCU-protected structures are a class of kernel exploits often chained with heap spraying to achieve arbitrary code execution
- Linux kernel mitigations include **SLAB_TYPESAFE_BY_RCU** and **CONFIG_RCU_EXPERT** hardening options
- RCU bugs are particularly dangerous because they are **race conditions** — hard to reproduce reliably but exploitable with precise timing techniques like heap grooming

## Related concepts
[[Use-After-Free]] [[Race Condition]] [[Kernel Privilege Escalation]] [[Heap Spraying]]