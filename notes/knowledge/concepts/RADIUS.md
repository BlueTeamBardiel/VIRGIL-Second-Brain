# RADIUS

## What it is
Think of RADIUS like a bouncer with a master guest list at a concert venue — individual doors don't decide who gets in, they all check with the one bouncer who has the authority. RADIUS (Remote Authentication Dial-In User Service) is a client-server protocol that centralizes authentication, authorization, and accounting (AAA) for network access. It runs over UDP (ports 1812 for authentication, 1813 for accounting) and is widely used in VPNs, Wi-Fi, and dial-up environments.

## Why it matters
In enterprise Wi-Fi attacks, WPA2-Enterprise deployments rely on RADIUS to authenticate users via 802.1X — if an attacker stands up a rogue access point with a spoofed RADIUS server, they can capture and crack MS-CHAPv2 handshakes, harvesting user credentials. This is why certificate validation on the client side is critical: without it, users silently authenticate to the attacker's fake RADIUS server and hand over their credentials.

## Key facts
- RADIUS uses **UDP ports 1812** (authentication/authorization) and **1813** (accounting); legacy deployments may use 1645/1646
- Only the **password is encrypted** in a RADIUS packet using MD5 — the username and other attributes are sent in plaintext
- RADIUS combines authentication and authorization into a single **Access-Accept/Access-Reject** response; TACACS+ separates these steps (a key exam distinction)
- It supports **PAP, CHAP, EAP**, and MS-CHAPv2 as inner authentication methods
- The **shared secret** between the NAS (Network Access Server) and RADIUS server is the critical trust anchor — a weak shared secret enables offline cracking attacks

## Related concepts
[[TACACS+]] [[802.1X]] [[EAP]] [[AAA]] [[WPA2-Enterprise]]