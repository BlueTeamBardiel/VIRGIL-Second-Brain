# MITRE ATT&CK T1562.006

## What it is
Like a thief disabling a store's security camera *before* breaking in, adversaries using this technique tamper with operating system indicators that show security tools whether auditing is active. T1562.006 — **Indicator Blocking** — describes adversaries preventing telemetry, logs, or security indicators from being generated or transmitted, specifically by manipulating the signals that defensive tools rely upon to detect malicious activity.

## Why it matters
During the 2020 SolarWinds compromise, attackers carefully avoided triggering security tools by manipulating how their activity was recorded and what telemetry was surfaced to defenders. An adversary who successfully implements indicator blocking can execute subsequent attack stages with dramatically reduced risk of detection, since SIEMs and EDR tools receive no signal to alert on — effectively blinding defenders mid-intrusion.

## Key facts
- **ETW (Event Tracing for Windows) tampering** is a primary mechanism: attackers patch or hook ETW providers in memory to suppress security-relevant events before they're written to logs
- This technique is a **sub-technique of T1562 (Impair Defenses)** — the parent technique covers broader defensive evasion via disabling security tools
- Attackers may use **`NtTraceControl` syscall manipulation** or patch the `EtwEventWrite` function in-process to null out logging
- Blocking indicators differs from *deleting* logs (T1070) — the goal here is **preventing generation**, not erasing evidence after the fact
- Detection relies on **monitoring ETW provider registration changes**, unexpected gaps in audit logs, or using a secondary out-of-band logging channel that attackers cannot easily reach

## Related concepts
[[Event Tracing for Windows (ETW)]] [[T1070 Indicator Removal]] [[T1562 Impair Defenses]] [[Security Information and Event Management (SIEM)]] [[Defense Evasion Tactic]]