# Atomic Red Team

## What it is
Think of it as a cookbook of evil — each "recipe" (called an atomic test) is a small, self-contained procedure that replicates exactly one malicious technique. Atomic Red Team is an open-source library of adversary simulation tests, maintained by Red Canary, mapped directly to MITRE ATT&CK techniques. Each test can be executed independently to verify whether defensive controls detect or prevent a specific attack behavior.

## Why it matters
A SOC team deploys a new EDR solution and wants to know if it actually catches credential dumping via `lsass.exe`. Rather than waiting for a real attacker, they run Atomic Test T1003.001 (OS Credential Dumping: LSASS Memory) in a controlled lab environment, observe whether an alert fires, and tune detection rules accordingly. This transforms security validation from assumption-based ("we *should* detect this") to evidence-based ("we *do* detect this").

## Key facts
- Each atomic test is tagged to a specific **MITRE ATT&CK technique ID** (e.g., T1059.001 for PowerShell execution), enabling precise coverage mapping
- Tests are written in **YAML format** and can be executed via the **Invoke-AtomicRedTeam** PowerShell framework on Windows, Linux, and macOS
- Atomic Red Team supports **purple teaming** — red team executes tests while blue team simultaneously validates detection and response
- Tests include **cleanup commands** to restore system state after execution, making them safer for use in production-adjacent environments
- Commonly used alongside **SIEM/EDR gap analysis** to measure detection coverage — a core CySA+ skill for continuous security improvement

## Related concepts
[[MITRE ATT&CK]] [[Purple Teaming]] [[Threat Emulation]] [[EDR]] [[SIEM]]