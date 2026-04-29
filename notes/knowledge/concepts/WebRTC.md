# WebRTC

## What it is
Like two people passing notes directly across a classroom instead of through the teacher, WebRTC lets browsers communicate peer-to-peer without routing traffic through a central server. It is an open standard and browser API that enables real-time audio, video, and data transfer directly between clients using protocols like DTLS and SRTP for encryption.

## Why it matters
WebRTC is a well-known privacy leak vector: even behind a VPN, a malicious website can use WebRTC's ICE (Interactive Connectivity Establishment) protocol to trigger STUN requests that reveal a user's **real local and public IP address**. Attackers embed WebRTC calls in phishing pages to de-anonymize targets, bypassing VPN protections entirely — a technique actively exploited in surveillance and OSINT operations.

## Key facts
- **IP Leakage**: WebRTC bypasses VPN tunnels by querying STUN servers directly, exposing the host's true IP; browsers like Firefox allow disabling this via `media.peerconnection.enabled`
- **Encryption is mandatory**: All WebRTC media must be encrypted using **SRTP** (Secure Real-Time Transport Protocol); data channels use **DTLS** (Datagram TLS)
- **STUN/TURN servers** facilitate NAT traversal — STUN discovers public IP, TURN relays traffic when direct peer connection fails
- **Signaling is not standardized**: WebRTC handles media negotiation (via SDP — Session Description Protocol) but leaves signaling channel security to the developer, creating a common misconfiguration risk
- **Attack surface**: Vulnerable WebRTC implementations have suffered buffer overflows and DoS via malformed SDP packets (CVE-class vulnerabilities in browser engines)

## Related concepts
[[VPN Tunneling]] [[STUN Protocol]] [[DTLS]] [[NAT Traversal]] [[IP Address Spoofing]]