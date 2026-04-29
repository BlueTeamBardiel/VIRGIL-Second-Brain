# Bisonal

## What it is
Think of it like a Swiss Army knife left behind by a burglar — it's a multipurpose Remote Access Trojan (RAT) that attackers plant and then use to quietly control compromised systems over time. Bisonal is a long-running malware family attributed to the Chinese threat group TA459 (also associated with APT41) that provides backdoor access, file management, command execution, and keylogging capabilities on infected Windows systems.

## Why it matters
In documented campaigns targeting Japanese and South Korean defense contractors and Russian government agencies, Bisonal was delivered via spear-phishing emails with weaponized attachments. Once installed, it established persistence through Windows Registry Run keys and communicated with command-and-control (C2) servers using encrypted HTTP traffic, making it difficult to distinguish from legitimate web browsing and allowing long-term espionage operations to go undetected for months.

## Key facts
- **Attribution**: Linked to Chinese nation-state actors, specifically tracked under APT10/TA459; active since at least 2010 with periodic code updates
- **Delivery mechanism**: Primarily spear-phishing with malicious email attachments (Office documents exploiting CVEs) targeting defense, government, and energy sectors
- **Persistence**: Uses `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` registry keys to survive reboots
- **C2 communication**: Communicates over HTTP/HTTPS with encrypted payloads to blend into normal traffic; uses dynamic DNS to evade IP blocklists
- **Capabilities**: Includes remote shell access, keylogging, screenshot capture, file upload/download, and process enumeration — a full-featured espionage toolkit

## Related concepts
[[Remote Access Trojan (RAT)]] [[Spear Phishing]] [[Command and Control (C2)]] [[APT (Advanced Persistent Threat)]] [[Registry Persistence]]