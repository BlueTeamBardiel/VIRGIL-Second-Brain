# Empire

## What it is
Think of Empire as a remote TV remote control that works even when the TV is behind a firewall — it sends commands through channels the network already trusts. Empire is a post-exploitation command-and-control (C2) framework that uses PowerShell (and Python) agents to maintain persistent access on compromised Windows systems, communicating over encrypted HTTP/HTTPS to blend with normal traffic.

## Why it matters
In the 2016 Democratic National Committee breach, attackers used Empire-like PowerShell-based C2 techniques to move laterally across systems while evading traditional antivirus detection. Because Empire runs entirely in memory (fileless execution), signature-based defenses often miss it entirely — defenders must instead rely on behavioral analytics and PowerShell logging to detect suspicious script block execution.

## Key facts
- Empire was originally developed by Harmj0y and the BC-Security team; it is open-source and heavily used in red team engagements to simulate APT behavior
- Operates **fileless** — agents run in memory via PowerShell without dropping executables to disk, bypassing many AV solutions
- Uses **stageless or staged payloads** delivered through listeners (HTTP, HTTPS, or SMB), with built-in modules for credential harvesting (Mimikatz integration), lateral movement, and privilege escalation
- Detected defensively through **PowerShell ScriptBlock Logging** (Event ID 4104), **AMSI (Antimalware Scan Interface)** integration, and anomalous HTTPS beaconing patterns
- Empire agents use **RC4 or AES encryption** for C2 communications and support jitter/sleep settings to mimic human timing and avoid traffic analysis

## Related concepts
[[PowerShell Exploitation]] [[Command and Control (C2)]] [[Fileless Malware]] [[Lateral Movement]] [[Mimikatz]]