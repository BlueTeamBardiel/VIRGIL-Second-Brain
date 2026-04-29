# Get-Process

## What it is
Like asking a factory floor supervisor for a full roster of every machine currently running — who started it, how much power it's drawing, and what its ID badge says — `Get-Process` is a PowerShell cmdlet that retrieves detailed information about all active processes on a Windows system. It exposes process names, PIDs, CPU/memory usage, and parent process relationships in real time.

## Why it matters
During incident response, defenders use `Get-Process` to hunt for malicious processes masquerading as legitimate ones — for example, catching a `svchost.exe` running from `C:\Users\Temp\` instead of `C:\Windows\System32\`. Adversaries also abuse it in the reconnaissance phase of post-exploitation to identify security tools like EDR agents or antivirus processes before attempting to kill them (a technique mapped to MITRE ATT&CK T1057: Process Discovery).

## Key facts
- Returns properties including `Name`, `Id` (PID), `CPU`, `WorkingSet`, `Path`, and `Handles` — `Path` is critical for spotting masquerading malware
- Piping output to `| Select-Object Name, Id, Path` gives a clean, analyst-friendly snapshot for triage
- Attackers use `Get-Process` to detect sandbox environments by checking for analysis tools like `wireshark.exe` or `procmon.exe`
- Unlike `tasklist`, `Get-Process` is native to PowerShell and its execution can be logged via **Script Block Logging** (Event ID 4104), making it forensically visible
- Combining with `Get-Process | Where-Object {$_.Path -notlike "*System32*"}` quickly surfaces anomalous process locations

## Related concepts
[[Process Injection]] [[PowerShell Logging]] [[MITRE ATT&CK T1057]] [[Living off the Land]] [[EDR Evasion]]