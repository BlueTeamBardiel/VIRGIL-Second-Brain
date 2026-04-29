# Mitre ATT&CK T1195

## What it is
Like poisoning a city's water supply at the reservoir rather than targeting individual homes, Supply Chain Compromise means attackers inject malicious code or hardware *before* software reaches the victim. T1195 specifically covers adversaries compromising third-party suppliers, software updates, or hardware components to gain access to downstream targets without ever attacking them directly.

## Why it matters
In the 2020 SolarWinds attack, threat actors (APT29/Cozy Bear) inserted a backdoor called SUNBURST into a legitimate software build process, which was then digitally signed and distributed to ~18,000 organizations via a routine update. Defenders never saw the attack coming because the malicious binary arrived via a trusted, authenticated vendor channel — bypassing most perimeter controls entirely.

## Key facts
- **Three sub-techniques exist:** T1195.001 (Compromise Software Dependencies/Development Tools), T1195.002 (Compromise Software Supply Chain), T1195.003 (Compromise Hardware Supply Chain)
- Attackers exploit the **implicit trust** organizations place in vendor-signed software and update mechanisms
- Defense-in-depth countermeasures include **software composition analysis (SCA)**, code signing verification, and integrity monitoring of binaries
- NIST SP 800-161 provides a formal **Cyber Supply Chain Risk Management (C-SCRM)** framework specifically addressing this threat
- Because compromise occurs *upstream*, traditional endpoint detection may not flag malicious activity until post-exploitation behaviors emerge — making **behavioral analytics** critical

## Related concepts
[[Software Composition Analysis]] [[Code Signing]] [[Trusted Relationship T1199]] [[Defense Evasion]] [[Vulnerability Management]]