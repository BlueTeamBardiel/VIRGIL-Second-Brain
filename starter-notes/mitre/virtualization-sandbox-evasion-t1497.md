# Virtualization/Sandbox Evasion (T1497)

Adversaries employ detection and evasion techniques to avoid virtualization and analysis environments, altering behavior or concealing malware functions if a virtual machine or sandbox is detected. This tactic involves checking for VME artifacts, security tools, user activity patterns, and temporal delays to evade automated analysis.

## Summary

**ID:** T1497  
**Tactics:** Defense Evasion, Discovery  
**Platforms:** Linux, Windows, macOS  
**Last Modified:** 24 October 2025

## Sub-techniques

- **T1497.001** — [[System Checks]]: Detection of VME and analysis tool artifacts
- **T1497.002** — [[User Activity Based Checks]]: Monitoring legitimate user behavior patterns
- **T1497.003** — [[Time Based Checks]]: Sleep timers and delay loops to avoid transient sandboxes

## Detection Methods

Adversaries check for:
- Security monitoring tools ([[Sysinternals]], [[Wireshark]], etc.)
- System artifacts associated with virtualization or analysis environments
- Legitimate user activity patterns
- Use of sleep timers or code loops to evade temporary sandbox execution windows

## Known Malware

| Malware | Technique |
|---------|----------|
| [[Agent Tesla]] | Anti-sandboxing and anti-virtualization checks |
| [[Bazar]] | Overload sandbox analysis with printf calls |
| [[Bisonal]] | Check for VMware presence |
| [[Black Basta]] | Random kernel32.beep calls to hinder log analysis |
| [[Bumblebee]] | Anti-virtualization checks |
| [[Carberp]] | Hook removal to evade sandbox and analysis tools |
| [[CHOPSTICK]] | Runtime analysis environment detection |
| [[CozyCar]] | VM and known sandbox environment detection |
| [[Darkhotel]] | Just-in-time string decryption for sandbox evasion |
| [[Egregor]] | Multiple anti-analysis and anti-sandbox techniques |
| [[Gelsemium]] | Junk code to generate random activity |
| [[Hancitor]] | Macro checks for document objects; exits if missing |
| [[IcedID]] | Keitaro Traffic Direction filtering for researcher/sandbox traffic |
| [[Kevin]] | Sleep intervals between C2 communications |
| [[Metamorfo]] | vmdetect.exe embedding |

## Related Concepts

- [[Defense Evasion]]
- [[Discovery]]
- [[Automated Discovery]]
- [[Malware Analysis]]
- [[Virtualization Detection]]

## Tags

#attack-technique #defense-evasion #discovery #malware #virtualization #sandbox-evasion #t1497

---
_Ingested: [[2026-04-15]] 22:02 | Source: https://attack.mitre.org/techniques/T1497/_
