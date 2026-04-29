# Defense Evasion TA0005

## What it is
Like a burglar who wears gloves, disables the alarm, and walks out through the front door dressed as a repairman, Defense Evasion is the attacker's deliberate effort to avoid detection while already inside. It is the MITRE ATT&CK tactic covering techniques adversaries use to hide their presence, remove evidence, and bypass security controls throughout the attack lifecycle.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors used signed, legitimate-looking DLLs and blended malicious traffic with normal Orion software communications — classic Defense Evasion — to remain undetected across thousands of networks for nearly nine months. This illustrates why detection tools relying solely on signatures fundamentally fail against evasion-aware adversaries.

## Key facts
- **TA0005 contains the most sub-techniques of any ATT&CK tactic** (~40+ techniques), reflecting how many evasion options attackers have
- Common techniques include: **Obfuscated Files or Information (T1027)**, **Masquerading (T1036)**, **Indicator Removal (T1070)**, and **Rootkits (T1014)**
- **Log tampering** (clearing Windows Event Logs via `wevtutil cl`) is a heavily tested Defense Evasion behavior on CySA+ exams
- **Living off the Land (LOLBins)** — using native tools like `certutil.exe` or `mshta.exe` — is a primary evasion method because it abuses trusted, signed binaries
- Defenders counter this tactic with **immutable logging**, **UEBA baselines**, and **behavioral detection** rather than signature-based rules

## Related concepts
[[MITRE ATT&CK Framework]] [[Indicator Removal T1070]] [[Living off the Land Binaries]] [[Obfuscation T1027]] [[Rootkits]]