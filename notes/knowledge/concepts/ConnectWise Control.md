# ConnectWise Control

## What it is
Think of it as a master skeleton key that lets a locksmith open any door in a building from their office miles away — ConnectWise Control (formerly ScreenConnect) is a remote desktop and support platform that allows technicians to view, control, and manage endpoints over the internet. It uses an agent installed on the target machine to establish persistent, authenticated sessions back to a central relay server.

## Why it matters
Threat actors — particularly ransomware groups like LockBit and BlackSuit — routinely abuse ConnectWise Control as a Living-off-the-Land (LotL) technique. Because it's legitimate software, it blends into enterprise environments, bypasses application allowlisting, and establishes persistent remote access without triggering standard malware alerts. In 2024, CISA issued an advisory warning that attackers were exploiting ConnectWise ScreenConnect vulnerabilities (CVE-2024-1708 and CVE-2024-1709) to achieve unauthenticated remote code execution at massive scale.

## Key facts
- **CVE-2024-1709** is a critical authentication bypass (CVSS 10.0) allowing unauthenticated access to the setup wizard, effectively granting admin control.
- **CVE-2024-1708** is a path traversal vulnerability (CVSS 8.4) chained with CVE-2024-1709 to achieve full remote code execution.
- ConnectWise Control operates over port **443 (HTTPS)** and **8040/8041**, making its traffic difficult to distinguish from normal web traffic.
- It is frequently deployed by Managed Service Providers (MSPs), making compromised MSP instances a force-multiplier attack vector affecting all downstream clients.
- Defenders should monitor for unexpected `ScreenConnect.ClientService.exe` processes, unusual outbound relay connections, and unauthorized setup wizard access in web logs.

## Related concepts
[[Remote Access Trojan (RAT)]] [[Living off the Land (LotL)]] [[Managed Service Provider (MSP) Attack]] [[Authentication Bypass]] [[CVE Vulnerability Scoring]]