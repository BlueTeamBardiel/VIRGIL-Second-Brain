# RDS

## What it is
Think of RDS (Remote Desktop Services) like a window into someone else's computer — you see their screen, type on their keyboard, and click their mouse, all while sitting somewhere else entirely. Technically, it's a Microsoft Windows feature that allows remote graphical access to a system over the network using the RDP protocol (default port 3389).

## Why it matters
In 2019, the **BlueKeep vulnerability (CVE-2019-0708)** exposed unpatched RDS services to unauthenticated remote code execution — attackers could compromise a machine without any user interaction, making it wormable. Organizations with internet-exposed RDP/RDS on port 3389 became prime targets, and many ransomware campaigns (including REvil and Dharma) used brute-forced RDS credentials as their initial access vector.

## Key facts
- **Default port is TCP 3389**; exposing this directly to the internet is a critical misconfiguration
- **Network Level Authentication (NLA)** requires users to authenticate *before* a full session is established, reducing attack surface against exploits like BlueKeep
- RDS differs from basic RDP: **RDS is the server role** that brokers multiple simultaneous sessions (common in enterprise environments), while RDP is the underlying protocol
- Attackers frequently use **credential stuffing and brute force** against RDS; account lockout policies and MFA are key mitigations
- The **RD Gateway** component tunnels RDS traffic over HTTPS (port 443), allowing secure remote access without exposing port 3389 directly to the internet

## Related concepts
[[Remote Desktop Protocol (RDP)]] [[BlueKeep (CVE-2019-0708)]] [[Network Level Authentication (NLA)]] [[VPN]] [[Lateral Movement]]