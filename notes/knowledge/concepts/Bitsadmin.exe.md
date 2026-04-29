# Bitsadmin.exe

## What it is
Think of it as a postal clerk that quietly delivers packages in the background while you go about your day — except attackers can bribe that clerk to deliver malware instead. Bitsadmin.exe is a built-in Windows command-line tool used to manage Background Intelligent Transfer Service (BITS) jobs, which handle asynchronous file transfers over HTTP/HTTPS. It was designed for legitimate Windows Update downloads but has become a well-known Living-off-the-Land Binary (LOLBin).

## Why it matters
In real-world attacks, threat actors use bitsadmin.exe to download malicious payloads from remote servers while blending into normal Windows traffic — a technique seen in APT campaigns and ransomware staging. Because BITS transfers survive reboots and run under the BITS service (not a suspicious new process), they can evade basic process-monitoring defenses. Defenders must monitor BITS job creation events (Windows Event ID 59, 60, 61) to catch this abuse.

## Key facts
- Classified as a **LOLBAS** (Living Off the Land Binary and Script) — it's a signed Microsoft binary that can be abused to download/execute payloads
- Common attacker syntax: `bitsadmin /transfer <jobname> <remote_URL> <local_destination>` pulls files silently
- BITS jobs **persist across reboots** until explicitly deleted or completed, enabling stealthy persistence
- Microsoft deprecated bitsadmin.exe in favor of PowerShell cmdlets (`Start-BitsTransfer`) starting with Windows 10, but it remains present on most systems
- Mapped to **MITRE ATT&CK T1197** (BITS Jobs) under the Persistence and Defense Evasion tactics

## Related concepts
[[Living Off the Land Binaries (LOLBAS)]] [[MITRE ATT&CK Framework]] [[Defense Evasion]] [[Persistence Mechanisms]] [[Windows Event Log Monitoring]]