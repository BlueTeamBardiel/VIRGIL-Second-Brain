# ClickFix

## What it is
Like a fake "Check Engine" light that tricks you into opening the hood so a mechanic can steal your wallet, ClickFix is a social engineering technique that presents users with a fabricated error message or CAPTCHA prompt, then instructs them to manually run a malicious PowerShell or terminal command to "fix" the problem. It exploits user trust in technical-looking dialogs to bypass endpoint defenses entirely by making the victim execute the payload themselves.

## Why it matters
In 2024, threat actors distributed ClickFix campaigns through compromised websites and phishing emails impersonating Google Meet, GitHub, and Cloudflare verification pages. Victims were shown a fake browser error and told to press `Win+R`, paste a PowerShell command into Run, and hit Enter — delivering infostealers like Lumma Stealer or remote access trojans without triggering standard email attachment controls, because the user's own hands launched the process.

## Key facts
- ClickFix abuses the Windows `Run` dialog or macOS Terminal as the execution vector, meaning no malicious file attachment is ever delivered or scanned
- The technique is classified under **T1204.002** (User Execution: Malicious File) and **T1059.001** (PowerShell) in the MITRE ATT&CK framework
- Payloads are typically hosted remotely and pulled via `curl` or `iwr` (Invoke-WebRequest) commands embedded in the clipboard-copied string
- Defenses include disabling or restricting PowerShell execution policy (`Constrained Language Mode`), monitoring for `cmd.exe`/`powershell.exe` spawned by `explorer.exe`, and user awareness training targeting fake CAPTCHA patterns
- ClickFix is effective precisely because it routes around email gateway sandboxing, EDR file-write detection, and macro controls — the human IS the execution engine

## Related concepts
[[Social Engineering]] [[PowerShell Abuse]] [[Living off the Land (LOLBins)]] [[Phishing]] [[MITRE ATT&CK]]