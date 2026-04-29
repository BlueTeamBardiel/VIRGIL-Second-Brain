# GL.iNet

## What it is
Think of it as a Swiss Army knife that fits in your pocket — GL.iNet produces small, open-source-friendly travel routers that run OpenWrt, a Linux-based firmware giving users deep control over network behavior. These devices act as portable network gateways, capable of VPN tunneling, traffic filtering, and network segmentation in a device smaller than a deck of cards.

## Why it matters
A red team operator traveling to a client site can plug a GL.iNet router into a hotel ethernet port, automatically tunnel all traffic through WireGuard back to a secure home base, preventing credential interception on untrusted networks. Conversely, attackers have demonstrated that GL.iNet devices with default credentials left exposed on management interfaces (port 80/443) can be hijacked to perform man-in-the-middle attacks against every device connected through them — making default credential hygiene critical.

## Key facts
- GL.iNet routers run **OpenWrt**, an open-source Linux firmware that allows packet-level inspection, custom firewall rules, and VPN client/server configuration unavailable on consumer routers
- Common models (GL-MT300N "Mango", GL-AR750S "Slate") support **WireGuard and OpenVPN** natively via the admin UI — relevant to VPN implementation scenarios on CySA+
- The web admin interface defaults to port **80** with password `goodlife` on older firmware — a classic default-credential vulnerability (CWE-1392)
- Supports **network segmentation** by creating guest VLANs and isolating IoT traffic — a defense-in-depth tactic directly tested on Security+
- Because they run full Linux, they can be loaded with tools like **tcpdump or Nmap**, making them dual-use devices relevant to both offense and defense scenarios

## Related concepts
[[OpenWrt]] [[WireGuard]] [[Default Credentials]] [[Man-in-the-Middle Attack]] [[Network Segmentation]]