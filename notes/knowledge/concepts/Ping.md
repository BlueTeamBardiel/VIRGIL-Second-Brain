# Ping

## What it is
Like knocking on a neighbor's door to see if anyone's home, ping sends a small "are you there?" message to an IP address and waits for a reply. Technically, it uses ICMP Echo Request packets (Type 8) and listens for ICMP Echo Reply packets (Type 0) to verify whether a host is reachable and measure round-trip latency.

## Why it matters
During reconnaissance, attackers perform **ping sweeps** — sending ICMP Echo Requests to every address in a subnet to map which hosts are alive before launching targeted attacks. Defenders counter this by configuring firewalls or host-based rules to block or rate-limit ICMP, making hosts "invisible" to simple sweeps — though this can complicate legitimate network troubleshooting.

## Key facts
- Uses **ICMP (Internet Control Message Protocol)**, not TCP or UDP — operates at Layer 3 (Network layer)
- A **ping sweep** (also called an ICMP sweep) is a classic active reconnaissance technique used to discover live hosts across a range
- Tools like **Nmap** use ping sweeps as a host discovery phase (`-sn` flag) before port scanning
- **Ping of Death** is a historical DoS attack where an oversized, malformed ICMP packet crashed vulnerable systems — patched in modern OSes but still exam-tested
- ICMP is **connectionless and stateless**, meaning it has no handshake; blocking it entirely can break path MTU discovery and network diagnostics
- Default Windows ping sends **4 packets**; default Linux/macOS ping sends continuously until interrupted

## Related concepts
[[ICMP]] [[Network Reconnaissance]] [[Nmap]] [[Ping Sweep]] [[DoS Attacks]] [[Firewall Rules]]