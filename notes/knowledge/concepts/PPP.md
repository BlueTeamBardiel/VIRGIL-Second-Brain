# PPP

## What it is
Think of PPP like a universal phone adapter that lets any two devices "plug in" and talk, regardless of their native connectors. Point-to-Point Protocol (PPP) is a Layer 2 data link protocol used to establish a direct connection between two nodes over serial links, dial-up, or broadband connections, providing authentication, encryption negotiation, and error detection.

## Why it matters
PPP's authentication sub-protocols (PAP and CHAP) are a common exam and real-world attack surface. PAP transmits credentials in plaintext, making it trivially interceptable via a man-in-the-middle attack on a dial-up or VPN tunnel — an attacker sniffing the link captures usernames and passwords directly. CHAP improves this using a challenge-response mechanism, but weak shared secrets remain exploitable through offline dictionary attacks.

## Key facts
- PPP operates at **Layer 2 (Data Link)** of the OSI model and replaced the older SLIP protocol
- Supports two authentication protocols: **PAP** (Password Authentication Protocol — plaintext, weak) and **CHAP** (Challenge Handshake Authentication Protocol — uses MD5 challenge-response, stronger)
- **PPPoE** (PPP over Ethernet) is widely used by ISPs for DSL broadband connections and is still common in home router configurations
- PPP uses **LCP** (Link Control Protocol) to establish, configure, and test the connection, and **NCP** (Network Control Protocol) to negotiate higher-layer protocols like IP
- MS-CHAPv2, an extension used in many VPNs, was completely broken in 2012 — a captured handshake can be cracked in under 24 hours using cloud computing

## Related concepts
[[CHAP]] [[PAP]] [[VPN]] [[MS-CHAPv2]] [[OSI Model]]