# Umbreon

## What it is
Like a parasite that rewires a host's nervous system to answer questions on its behalf, Umbreon is a Ring 0 rootkit that intercepts Linux kernel functions at the lowest level. Specifically, it is an advanced persistent threat (APT) toolkit developed by the Equation Group (linked to the NSA) that operates as a firmware-level rootkit targeting x86 and x86-64 Linux systems by hooking kernel system calls directly.

## Why it matters
Umbreon was part of the Shadow Brokers leak in 2016, which exposed NSA-grade offensive tools to the public — dramatically lowering the barrier for nation-state-level attacks. A compromised system running Umbreon can hide malicious processes, files, and network connections entirely from the operating system's own view, making traditional endpoint detection tools effectively blind. Defenders responding to an incident may see a completely clean system while the attacker maintains full shell access through a hidden backdoor called "Felids."

## Key facts
- Umbreon operates at **Ring 0** (kernel level), giving it higher privilege than any security software running in user space
- Uses **LD_PRELOAD hijacking** and direct kernel function hooks to intercept system calls and filter results returned to users
- Includes a built-in backdoor component named **Felids**, which provides covert remote access
- Survives system reboots via persistence mechanisms embedded in the Linux init process
- Detected via **memory forensics** or external integrity checking (e.g., comparing kernel symbol tables with a known-good baseline) — standard AV is insufficient
- Part of the **Equation Group** toolkit exposed by the Shadow Brokers in August 2016

## Related concepts
[[Rootkit]] [[Ring 0 vs Ring 3]] [[LD_PRELOAD Injection]] [[Shadow Brokers Leak]] [[Kernel Integrity Monitoring]]