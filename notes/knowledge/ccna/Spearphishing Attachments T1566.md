# Spearphishing Attachments T1566

## What it is
Like a poisoned gift wrapped specifically for one person — with their name on the card and their favorite wrapping paper — a spearphishing attachment is a malicious file delivered via email that is carefully tailored to a specific target to maximize the chance they'll open it. Unlike bulk phishing, this is precision social engineering where the attacker researches the victim to craft a believable pretext. The attachment itself (PDF, Office document, ZIP, etc.) serves as the initial payload delivery mechanism.

## Why it matters
In the 2016 Democratic National Committee breach, spearphishing emails carrying malicious Word documents were sent to specific staffers — when opened, macros executed a PowerShell payload that installed X-Agent malware. This single technique was the initial access vector for a nation-state intrusion that had global consequences, demonstrating how one clicked attachment can compromise an entire organization.

## Key facts
- Mapped to MITRE ATT&CK as **T1566.001** (the .001 sub-technique distinguishes attachments from links and spearphishing via service)
- Common malicious file types include **.docm, .xlsm** (macro-enabled Office files), **.pdf** with embedded exploits, **.lnk** shortcut files, and **.iso** containers used to bypass Mark-of-the-Web protections
- Attackers frequently abuse **Microsoft Office macros** or exploit document readers (e.g., CVE in Adobe Reader) as the execution mechanism after the file is opened
- Defense controls include **disabling macros by default** (now Microsoft's default policy), email attachment sandboxing, and user awareness training
- Detection focuses on email gateway logs, sandbox detonation results, and endpoint telemetry showing **Office spawning child processes** like cmd.exe or PowerShell

## Related concepts
[[Phishing T1566]] [[Malicious Macros]] [[Initial Access]] [[Email Security Gateways]] [[Mark-of-the-Web Bypass]]