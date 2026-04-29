# AsyncRAT

## What it is
Think of it like a puppet master controlling marionettes over an encrypted radio channel — the puppets (victims) await silent commands while the master hides offstage. AsyncRAT (Asynchronous Remote Access Trojan) is an open-source .NET-based RAT first released on GitHub in 2019, designed to give attackers persistent, encrypted remote control over compromised Windows systems.

## Why it matters
In 2023, AsyncRAT was observed being delivered via phishing emails containing HTML smuggling attachments that dropped the payload onto victim machines, bypassing email gateway filters entirely. Defenders hunting for AsyncRAT look for suspicious outbound connections on port 6606 or 7707 and unusual child processes spawned by legitimate .NET runtime executables.

## Key facts
- **Open-source origin**: AsyncRAT's full source code was publicly released on GitHub, meaning any threat actor can compile and customize it with minimal technical skill — dramatically lowering the barrier to entry.
- **Encrypted C2 channel**: Uses AES-encrypted communications over TCP, making traffic inspection by basic IDS/IPS signatures ineffective without SSL inspection or behavioral analysis.
- **Capabilities**: Keylogging, screen capture, remote shell, file management, process injection, and persistence via Windows Registry Run keys or Task Scheduler.
- **Defense evasion**: Commonly delivered via HTML smuggling, Discord CDN, or malicious OneNote files; frequently injects into legitimate processes like `RegAsm.exe` or `MSBuild.exe` to blend in.
- **Detection angle**: CySA+ relevance — look for anomalous .NET CLR loading in non-developer processes and outbound connections to dynamic DNS providers, which AsyncRAT operators frequently abuse.

## Related concepts
[[Remote Access Trojan]] [[HTML Smuggling]] [[Command and Control (C2)]] [[Process Injection]] [[Persistence Mechanisms]]