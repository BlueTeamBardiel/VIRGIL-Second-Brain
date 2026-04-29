# CAPWAP

## What it is
Think of CAPWAP like a postal sorting facility: individual wireless access points (APs) are just drop boxes that collect mail, but all the actual decisions about routing happen at one central sorting hub. Control and Provisioning of Wireless Access Points (CAPWAP) is an IETF protocol (RFC 5415) that centralizes wireless network management by tunneling traffic from lightweight APs to a Wireless LAN Controller (WLC), which handles authentication, policy enforcement, and configuration.

## Why it matters
In a split-MAC architecture using CAPWAP, an attacker who compromises a single access point gains limited leverage because the AP holds no local intelligence — all sensitive decisions live on the WLC. However, if an attacker spoofs or hijacks the CAPWAP control channel between an AP and WLC (UDP port 5246), they can push malicious configurations to every AP the controller manages, turning a single point of failure into a network-wide compromise.

## Key facts
- CAPWAP uses **UDP port 5246** for control traffic and **UDP port 5247** for data traffic
- It operates in two modes: **split-MAC** (AP handles real-time functions, WLC handles management) and **local MAC** (AP handles everything locally)
- CAPWAP tunnels are protected by **DTLS (Datagram TLS)**, providing encryption and mutual authentication between AP and WLC
- It replaced the proprietary **LWAPP (Lightweight Access Point Protocol)** developed by Cisco, becoming the open standard
- A rogue AP that successfully completes CAPWAP handshake with a legitimate WLC is treated as trusted, making discovery of rogue controllers a critical security concern

## Related concepts
[[Wireless LAN Controller (WLC)]] [[DTLS]] [[Rogue Access Point]] [[802.1X Authentication]] [[Network Segmentation]]