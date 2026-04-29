# PowerShell Script Block Logging

## What it is
Like a court stenographer who transcribes every word spoken regardless of how fast the lawyer talks, Script Block Logging captures the full decoded content of every PowerShell code block before it executes — even if it was obfuscated or downloaded at runtime. Specifically, it records script block contents to Windows Event Log (Event ID 4104), giving defenders visibility into what PowerShell actually ran, not just what was typed.

## Why it matters
Attackers routinely use multi-stage PowerShell payloads where an initial innocuous-looking command downloads and executes obfuscated malicious code in memory — a technique central to fileless malware like Empire or Cobalt Strike stagers. Without Script Block Logging, the deobfuscated payload never touches disk and leaves no obvious trace; with it enabled, Event ID 4104 captures the fully decoded malicious code the moment before execution, giving incident responders the smoking gun.

## Key facts
- Enabled via Group Policy under **Administrative Templates → Windows Components → Windows PowerShell → Turn on PowerShell Script Block Logging**
- Logs to **Microsoft-Windows-PowerShell/Operational** channel; Event ID **4104** is the critical one to monitor
- PowerShell 5.0+ automatically enables Script Block Logging for blocks containing **suspicious keywords** (e.g., `Invoke-Expression`, `EncodedCommand`) even without explicit policy — called "protected event logging" mode
- Complements **Module Logging** (Event ID 4103) and **Transcription Logging**, but Script Block Logging is most effective against obfuscation
- Log volume can be significant in enterprise environments; SIEM tuning is required to avoid alert fatigue while catching high-severity blocks

## Related concepts
[[Windows Event Log Monitoring]] [[Fileless Malware]] [[PowerShell Constrained Language Mode]] [[SIEM Log Ingestion]] [[Obfuscation Detection]]