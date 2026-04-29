# Input Capture

## What it is
Like a hidden stenographer sitting between you and your boss, silently transcribing every word spoken in a meeting — input capture is any technique where an attacker intercepts and records user input (keystrokes, credentials, form data) before it reaches its intended destination. It operates invisibly between the user's action and the system's response.

## Why it matters
In the 2013 Target breach, attackers deployed memory-scraping malware on point-of-sale terminals that captured credit card data mid-transaction — before it could be encrypted — stealing 40 million card numbers. Defenders counter this with endpoint detection tools that flag suspicious hooks into keyboard and process memory APIs.

## Key facts
- **Keyloggers** are the most common form — they can be hardware (USB devices plugged between keyboard and PC) or software (kernel drivers, API hooks using `SetWindowsHookEx` on Windows)
- **MITRE ATT&CK T1056** covers Input Capture with sub-techniques including keylogging, GUI input capture, web portal credential harvesting, and credential API hooking
- **Credential API Hooking** intercepts calls to functions like `CredEnumerateA` or LSASS to steal credentials in memory before they are hashed or stored
- Hardware keyloggers are **physically undetectable by antivirus** — only physical inspection or USB port auditing reveals them
- Input capture is commonly paired with **privilege escalation** — attackers capture credentials specifically to move laterally or escalate to admin accounts
- Defenses include **application whitelisting**, monitoring for unexpected DLL injection, and using **virtual keyboards** for sensitive input (common in banking apps)

## Related concepts
[[Keylogger]] [[API Hooking]] [[Credential Dumping]] [[Man-in-the-Browser]] [[Process Injection]]