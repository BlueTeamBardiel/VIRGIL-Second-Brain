# DAAP

## What it is
Think of DAAP like a waiter who shouts your entire music library order across a restaurant — anyone in earshot can hear the menu. Digital Audio Access Protocol (DAAP) is Apple's proprietary protocol used by iTunes to share music libraries over a local network, operating over TCP port 3689 and using HTTP as its transport layer.

## Why it matters
In corporate environments, DAAP services left running on employee machines can inadvertently expose sensitive filenames, organizational data embedded in media metadata, or act as a pivot point for internal network reconnaissance. An attacker on the same LAN segment can enumerate DAAP shares without authentication (early iTunes versions required no password by default), revealing hostnames, usernames, and shared content — useful for social engineering or targeted attacks.

## Key facts
- DAAP operates over **TCP port 3689** and uses HTTP-based requests/responses to stream and list media content
- Early implementations had **no authentication by default**, meaning any device on the local network could browse and stream another user's shared library
- DAAP uses **mDNS/Bonjour (UDP port 5353)** for service discovery, making shares automatically visible on the local subnet
- Metadata exposure is a real risk — track names, playlist titles, and library structure can reveal organizational or personal details
- DAAP traffic is **cleartext by default**, making it susceptible to passive sniffing on unsegmented networks

## Related concepts
[[mDNS]] [[Bonjour Protocol]] [[Network Service Enumeration]] [[Cleartext Protocols]] [[Port Scanning]]