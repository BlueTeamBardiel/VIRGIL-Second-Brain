# Dropper

## What it is
Think of a dropper like a Trojan horse filled with a smaller Trojan horse — its entire purpose is to sneak past the gates and then *release* the real threat inside. Precisely defined, a dropper is a type of malware whose sole function is to install a secondary malicious payload onto a target system, either by extracting it from within itself or by downloading it from a remote location (the latter variant is called a **downloader**). The dropper itself often contains no destructive logic — it is purely a delivery mechanism.

## Why it matters
In the 2016 Locky ransomware campaigns, attackers distributed malicious Word documents containing macros that acted as droppers — once a victim enabled macros, the dropper silently fetched and installed the Locky ransomware binary from a remote C2 server. Defenders who monitored for unusual outbound HTTP requests immediately after Office process spawning could catch the dropper mid-execution before the ransomware payload activated.

## Key facts
- Droppers are classified as **stagers** in attack frameworks like MITRE ATT&CK (T1587.001), forming the first link in a multi-stage malware chain.
- A **dropper** carries the payload internally (self-contained); a **downloader** fetches the payload from a network source — Security+ exams frequently test this distinction.
- Droppers commonly abuse legitimate file formats (Office macros, PDFs, ISO files) to avoid initial detection and bypass perimeter controls.
- Because the dropper itself may be benign-looking, traditional signature-based AV often misses it — **behavioral analysis** and sandbox detonation are the primary detection methods.
- Droppers frequently employ **process injection** or write payloads to disk in temp directories (`%APPDATA%`, `%TEMP%`) to evade standard install monitoring.

## Related concepts
[[Trojan]] [[Command and Control (C2)]] [[Malware Staging]] [[Process Injection]] [[Downloader]]