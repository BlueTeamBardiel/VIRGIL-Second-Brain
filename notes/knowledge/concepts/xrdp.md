# xrdp

## What it is
Think of xrdp as a universal power adapter that lets Linux machines speak the language of Windows Remote Desktop — it's an open-source implementation of the Remote Desktop Protocol (RDP) server that allows RDP clients to connect to Linux systems. It translates RDP handshakes into X11 sessions, bridging the protocol gap without requiring Windows licensing.

## Why it matters
In a 2021 campaign, threat actors exploited CVE-2022-23468 and related xrdp vulnerabilities to achieve unauthenticated remote code execution on exposed Linux servers by sending malformed authentication packets that triggered buffer overflows. This highlights why security teams must treat xrdp-exposed ports (TCP 3389) with the same scrutiny as Windows RDP — scanning for internet-facing Linux hosts running xrdp is a common initial-access technique in ransomware campaigns that target mixed-OS environments.

## Key facts
- xrdp listens on **TCP port 3389** by default — the same port as Windows RDP, making it a high-value target in automated scans
- It uses X11rdp or Xvnc as a backend to render the desktop session, meaning VNC vulnerabilities can chain with xrdp weaknesses
- Authentication is handled via PAM (Pluggable Authentication Modules), so misconfigured PAM policies can allow bypasses
- Network Level Authentication (NLA) is supported in newer versions; older deployments without NLA are vulnerable to credential brute-force without session overhead
- Certificate management is often neglected — default self-signed certs enable **man-in-the-middle** attacks if clients don't enforce certificate validation

## Related concepts
[[Remote Desktop Protocol (RDP)]] [[Network Level Authentication (NLA)]] [[Brute Force Attacks]] [[X11 Forwarding]] [[PAM Authentication]]