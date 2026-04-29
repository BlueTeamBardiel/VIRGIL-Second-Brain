# Attack Surface Reduction Rules

## What it is
Think of ASR rules like a nightclub bouncer with a strict list — not just checking IDs at the door, but physically blocking certain behaviors (no standing on tables, no bottles near the DJ booth) before trouble starts. Attack Surface Reduction (ASR) rules are pre-configured security policies in Microsoft Defender that block specific high-risk behaviors — like Office macros spawning child processes or scripts executing obfuscated code — at the OS level before malware can establish a foothold.

## Why it matters
During the 2017 Emotet/TrickBot wave, attackers routinely used malicious Word documents to launch PowerShell via macro-spawned child processes. An ASR rule specifically blocking "Office applications from creating child processes" would have severed that attack chain at step one, preventing lateral movement entirely — regardless of whether AV signatures were current.

## Key facts
- ASR rules are part of **Microsoft Defender for Endpoint** and require Windows 10/11 with specific licensing tiers (MDE Plan 1+)
- Rules operate in three modes: **Audit** (log only), **Warn** (block with user override), and **Block** (hard enforcement) — critical for staged rollout
- A commonly tested rule: **"Block credential stealing from the Windows local security authority subsystem"** directly targets LSASS dumping (Mimikatz-style attacks)
- ASR rules are configured via **Group Policy, Intune, PowerShell, or MEM** and are identified by GUIDs, not human-readable names in raw config
- They target **behavior-based attack patterns** (fileless malware, living-off-the-land techniques), not just file signatures — making them effective against zero-days

## Related concepts
[[Endpoint Detection and Response]] [[Windows Defender Application Control]] [[Living Off the Land Attacks]] [[LSASS Protection]]