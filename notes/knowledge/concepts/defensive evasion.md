# defensive evasion

## What it is
Like a burglar who disables the motion-sensor lights *before* breaking in rather than running past them, defensive evasion describes an attacker's deliberate techniques to avoid detection by security tools *during* an intrusion. Precisely, it is MITRE ATT&CK Tactic TA0005 — a collection of methods adversaries use to hide malicious activity, bypass security controls, and remain undetected on a compromised system.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors injected malicious code that lay dormant for up to two weeks before activating — deliberately designed to evade sandbox analysis tools that only observe short execution windows. Security teams relying solely on signature-based detection had no visibility into the compromise for months. This is a textbook case of defensive evasion defeating traditional defenses at scale.

## Key facts
- **Masquerading** (T1036) involves naming malicious executables after legitimate system processes (e.g., `svch0st.exe` mimicking `svchost.exe`) to avoid casual inspection
- **Indicator Removal** (T1070) includes clearing Windows Event Logs, bash history, or deleting files to destroy forensic evidence
- **Obfuscated Files or Information** (T1027) covers Base64 encoding, packing, or encrypting payloads to defeat signature-based AV scanning
- **Rootkits** operate at the kernel level to hide processes, files, and network connections from the OS itself — making them invisible to user-space security tools
- MITRE ATT&CK lists defensive evasion as the tactic with the *most* individual techniques, reflecting how central it is to real-world attacker tradecraft

## Related concepts
[[MITRE ATT&CK]] [[obfuscation]] [[rootkits]] [[log tampering]] [[indicator of compromise]]