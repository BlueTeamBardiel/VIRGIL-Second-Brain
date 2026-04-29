# Defense Evasion Tactics

## What it is
Like a smuggler who hides contraband inside a hollowed-out Bible to pass through customs, defense evasion is an attacker's toolkit for disguising malicious activity as normal, trusted operations. Precisely, it refers to techniques adversaries use to avoid detection by security controls throughout an intrusion — including disabling defenses, obfuscating code, and masquerading as legitimate processes. It is formally catalogued as TA0005 in the MITRE ATT&CK framework.

## Why it matters
During the 2020 SolarWinds attack, threat actors injected malicious code (SUNBURST) into a legitimate software build process, making the backdoor appear as a signed, trusted update. Because the malware masqueraded as normal Orion traffic and used obfuscated communications, it evaded detection across thousands of networks for nearly nine months — demonstrating how evasion can completely nullify perimeter and endpoint controls.

## Key facts
- **Obfuscation techniques** include Base64 encoding, packing, and steganography to hide malicious payloads from signature-based AV scanners
- **Living off the Land (LotL)** abuses legitimate tools like PowerShell, WMI, and certutil so malicious commands blend with normal admin activity
- **Indicator Removal** covers log deletion, timestomping (modifying file timestamps), and clearing event logs to destroy forensic evidence
- **Process injection** (e.g., DLL injection, process hollowing) runs malicious code inside trusted processes like `svchost.exe` to bypass application whitelisting
- **Disable or Modify Tools** is a sub-technique where attackers tamper with EDR agents, Windows Defender, or audit policies to blind defenders before executing their primary objective

## Related concepts
[[MITRE ATT&CK Framework]] [[Indicators of Compromise]] [[Living Off the Land Attacks]] [[Process Injection]] [[Log Management and SIEM]]