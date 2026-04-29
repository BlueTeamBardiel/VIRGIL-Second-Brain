# OS Fingerprinting

## What it is
Like identifying a car's make and model by the sound of its engine and the shape of its exhaust, OS fingerprinting identifies a remote system's operating system by analyzing subtle quirks in how it responds to network packets. Attackers and defenders probe these behavioral differences — TTL values, TCP window sizes, packet flag handling — to determine what OS a target is running without ever logging in. It can be passive (sniffing existing traffic) or active (sending crafted probe packets).

## Why it matters
Before launching an exploit, an attacker needs to know whether the target runs Windows Server 2019 or Ubuntu 22.04 — a buffer overflow that works on one is useless against the other. During a penetration test, a tester runs `nmap -O` against a target subnet to map which hosts are Windows vs. Linux, then tailors their exploit selection accordingly. Defenders counter this by normalizing outbound packet characteristics using firewalls or packet scrubbers to obscure the true OS.

## Key facts
- **Active fingerprinting** tools include Nmap (`-O` flag) and Xprobe2; they send crafted TCP/UDP/ICMP probes and analyze responses
- **Passive fingerprinting** tools like p0f identify OSes without sending any packets — making detection nearly impossible
- Windows systems historically use a default TTL of **128**; Linux/Unix systems use **64** — a quick giveaway
- TCP **window size** and **options ordering** (timestamp, SACK, MSS) are primary fingerprinting signals used by Nmap's OS detection engine
- OS fingerprinting falls under **reconnaissance** in the cyber kill chain and maps to the **scanning** phase of network discovery

## Related concepts
[[Network Scanning]] [[Passive Reconnaissance]] [[Nmap]] [[TCP/IP Stack Fingerprinting]] [[Reconnaissance Techniques]]