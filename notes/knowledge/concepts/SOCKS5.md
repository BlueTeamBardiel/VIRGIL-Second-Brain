# SOCKS5

## What it is
Think of SOCKS5 as a relay race baton-passer at the network level — your traffic hands off to a proxy server, which carries it the rest of the way, so the destination only sees the proxy's address. Precisely, SOCKS5 (Socket Secure version 5) is a general-purpose Layer 5 proxy protocol that tunnels arbitrary TCP and UDP traffic between a client and server through an intermediary, supporting authentication and IPv6. Unlike HTTP proxies, SOCKS5 is protocol-agnostic — it doesn't care if you're passing web traffic, SSH, or raw sockets.

## Why it matters
Attackers frequently abuse SOCKS5 to pivot through compromised internal hosts after initial access. Tools like **Chisel**, **reGeorg**, and **Cobalt Strike** can stand up a SOCKS5 tunnel over HTTP or a reverse shell, letting the attacker route their entire attack toolchain through a beachhead machine — effectively bypassing perimeter firewall rules that would block direct external connections to internal resources.

## Key facts
- SOCKS5 operates at **Layer 5 (Session layer)** of the OSI model, making it protocol-agnostic unlike HTTP proxies
- Supports three authentication methods: **no auth, username/password, and GSS-API (Kerberos)**
- Adds **UDP support** over SOCKS4, enabling DNS proxying and UDP-based protocol tunneling
- Default port is **1080/TCP** — unusual traffic on this port is a common indicator of compromise or unauthorized proxy use
- Commonly used in **C2 frameworks for lateral movement** and by threat actors to anonymize origin through proxy chains (proxychains tool)

## Related concepts
[[Proxy Servers]] [[Network Pivoting]] [[Command and Control (C2)]] [[Tunneling Protocols]] [[Port Forwarding]]