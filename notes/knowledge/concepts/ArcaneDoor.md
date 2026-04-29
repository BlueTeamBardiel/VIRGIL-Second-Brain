# ArcaneDoor

## What it is
Like a master lockpick who creates a hidden skeleton key to a building's service entrance — bypassing the front desk entirely — ArcaneDoor is a sophisticated espionage campaign where attackers implanted two custom backdoors ("Line Runner" and "Line Dancer") into Cisco Adaptive Security Appliance (ASA) devices to maintain persistent, covert access to target networks.

## Why it matters
In early 2024, a nation-state threat actor (assessed with high confidence to be China-linked) exploited zero-day vulnerabilities in Cisco ASA firewalls to compromise government and critical infrastructure networks globally. Because the attack targeted the perimeter device itself, traditional endpoint detection tools were blind — the attacker operated from inside the security boundary, intercepting traffic and exfiltrating credentials before defenders knew anything was wrong.

## Key facts
- **CVE-2024-20353** and **CVE-2024-20359** were the two zero-days exploited; the first enables denial-of-service/code execution, the second enables persistent local code execution across reboots
- **Line Dancer** is an in-memory shellcode implant that intercepts ASA processes to execute arbitrary commands without writing to disk (evades file-based forensics)
- **Line Runner** is a persistent backdoor that survives device reboots and upgrades by abusing ASA's legacy VPN client pre-loading feature
- Attributed to the threat actor tracked as **UAT4356** (Cisco Talos) / **STORM-1849** (Microsoft), consistent with state-sponsored espionage TTPs
- Defenders are advised to monitor ASA syslog for anomalies, verify device integrity with `show version` and memory checks, and apply Cisco's patches immediately — network device firmware integrity monitoring is a key CySA+ defensive control

## Related concepts
[[Zero-Day Vulnerability]] [[Advanced Persistent Threat]] [[Network Device Hardening]] [[Firmware Implant]] [[Living Off the Land]]