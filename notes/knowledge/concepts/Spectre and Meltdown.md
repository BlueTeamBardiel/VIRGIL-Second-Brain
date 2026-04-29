# Spectre and Meltdown

## What it is
Imagine a bank teller who, while processing your transaction, briefly glances at the next customer's account balance before realizing they shouldn't — Spectre and Meltdown exploit a similar "peek" that modern CPUs take at privileged memory during speculative execution. Spectre tricks other processes into leaking their data through a shared CPU optimization; Meltdown breaks the fundamental isolation between user applications and the operating system kernel by reading kernel memory before hardware permission checks catch up.

## Why it matters
In a cloud hosting environment, a malicious virtual machine could exploit Spectre to extract cryptographic keys or passwords from a neighboring VM running on the same physical CPU — without ever escaping the hypervisor in the traditional sense. This forced massive emergency patches (kernel page-table isolation, or KPTI) across every major cloud provider in January 2018, causing measurable performance degradation of 5–30% on certain workloads.

## Key facts
- **Meltdown (CVE-2017-5754)** exploits out-of-order execution to read kernel memory from user space; patched via KPTI (formerly KAISER)
- **Spectre (CVE-2017-5753, CVE-2017-5715)** manipulates branch prediction to leak data across process boundaries; harder to patch fully because it exploits a fundamental CPU design feature
- Both are **side-channel attacks** — they infer secrets by observing timing differences in CPU cache behavior (Flush+Reload technique)
- Mitigations include **microcode updates**, **retpoline** compiler patches, and **site isolation** in browsers (preventing cross-origin timer abuse)
- Spectre affects nearly all modern CPUs (Intel, AMD, ARM); Meltdown primarily affected Intel and some ARM designs

## Related concepts
[[Side-Channel Attacks]] [[Speculative Execution]] [[Privilege Escalation]] [[Cache Timing Attacks]] [[Virtual Machine Escape]]