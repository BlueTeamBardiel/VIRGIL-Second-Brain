# Meltdown

## What it is
Imagine a bank teller who briefly glances at the vault's contents while processing your request, even though you're not authorized to see inside — and you can tell what they saw by how long they hesitate. Meltdown is a hardware-level CPU vulnerability (CVE-2017-5754) that allows an unprivileged user-space process to read arbitrary kernel memory by exploiting speculative execution and a timing-based side channel. The CPU speculatively executes instructions before access permissions are checked, and the results are recoverable via cache timing before they're officially discarded.

## Why it matters
In a cloud hosting environment, a malicious virtual machine could exploit Meltdown to read memory belonging to the hypervisor or other tenants — extracting passwords, cryptographic keys, or session tokens from processes it should never touch. This forced emergency kernel patches (KPTI — Kernel Page Table Isolation) across Linux, Windows, and macOS, causing measurable performance degradation in I/O-intensive workloads on affected systems.

## Key facts
- Disclosed publicly in January 2018 alongside Spectre; discovered independently by Google Project Zero and academic researchers
- Affects primarily Intel x86 processors manufactured before 2018; AMD and ARM were largely unaffected by Meltdown specifically
- Exploits **out-of-order/speculative execution** combined with a **cache-based side channel** (Flush+Reload technique)
- Mitigation is **KPTI (Kernel Page Table Isolation)**, which separates kernel and user-space page tables — a software fix for a hardware flaw
- Unlike Spectre, Meltdown breaks the fundamental isolation between user processes and kernel memory (privilege boundary violation)

## Related concepts
[[Spectre]] [[Speculative Execution]] [[Side-Channel Attack]] [[Cache Timing Attack]] [[Kernel Page Table Isolation]]