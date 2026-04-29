# Microsoft Office

## What it is
Like a Swiss Army knife that secretly includes a lockpick — Office is a productivity suite so deeply embedded in organizations that attackers treat it as a pre-installed intrusion toolkit. Precisely, Microsoft Office is a collection of applications (Word, Excel, PowerPoint, Outlook) that supports embedded scripting, macro execution, and external content linking, making it a persistent attack surface in enterprise environments.

## Why it matters
In 2017, the Emotet banking trojan spread massively through malicious Word documents that prompted users to "Enable Editing" then "Enable Content," triggering VBA macros that downloaded the payload. Defenders respond by enforcing Group Policy to disable macros entirely or restrict them to digitally signed macros only — a core hardening control in CIS Benchmarks.

## Key facts
- **VBA macros** are the primary weaponization vector; attackers embed shellcode or download cradles (e.g., `PowerShell IEX (New-Object Net.WebClient).DownloadString(...)`) inside macro-enabled documents (.docm, .xlsm)
- **MOTW (Mark of the Web)** is a Zone Identifier applied to files downloaded from the internet; CVE-2022-41091 was a zero-day that bypassed MOTW, allowing unsigned macros to execute silently
- **OLE/ActiveX objects** can embed executable content inside Office documents independently of macros
- **Protected View** is a sandbox mode that opens downloaded documents as read-only — disabling it is a common social engineering goal
- **Office 2022 policy change**: Microsoft now blocks macros from internet-sourced files by default across Office apps, significantly reducing this attack surface

## Related concepts
[[Macros and Malware]] [[Phishing]] [[Mark of the Web (MOTW)]] [[Social Engineering]] [[VBA Scripting]]