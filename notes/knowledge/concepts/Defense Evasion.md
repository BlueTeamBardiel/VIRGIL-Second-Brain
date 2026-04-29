# defense evasion

## What it is
Like a spy who changes clothes, walks with a limp, and dyes their hair to slip past border guards — defense evasion is the collection of techniques attackers use to avoid detection by security tools after gaining access. It is MITRE ATT&CK Tactic TA0005, encompassing methods that disable, deceive, or circumvent defensive controls such as antivirus, EDR, logging, and firewalls.

## Why it matters
During the SolarWinds attack, threat actors injected malicious code into a legitimate software build pipeline, meaning their backdoor (SUNBURST) arrived digitally signed and trusted — bypassing application allowlisting and AV scanning entirely. Security teams only discovered the compromise months later, illustrating how effective evasion can hollow out your entire detection capability.

## Key facts
- **Obfuscation and encoding** (Base64, XOR, packing) hide malicious payloads from signature-based scanners — a core evasion sub-technique
- **Timestomping** modifies file metadata timestamps to blend malicious files with legitimate system files during forensic triage
- **Process injection** (e.g., DLL injection, process hollowing) runs malicious code inside a trusted process like `svchost.exe`, defeating process-level controls
- **Disabling security tools** — attackers may use `net stop` or tamper with Windows Defender via registry edits — is itself classified as a defense evasion technique
- **Living off the Land (LotL)** uses built-in system tools (PowerShell, certutil, wmic) to avoid dropping custom malware that might trigger behavioral detection

## Related concepts
[[MITRE ATT&CK]] [[indicator of compromise]] [[endpoint detection and response]] [[obfuscation]] [[process injection]]