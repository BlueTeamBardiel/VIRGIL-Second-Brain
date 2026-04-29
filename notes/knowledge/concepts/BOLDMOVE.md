# BOLDMOVE

## What it is
Like a deep-sea parasite that evolved specifically to live inside one rare species of fish, BOLDMOVE is a backdoor malware strain engineered to survive inside Fortinet FortiGate firewall appliances — a host most defenders never think to inspect. Precisely, it is a Linux-based backdoor (written in C++) attributed to a Chinese state-sponsored threat actor (UNC2286/China-nexus) that exploits CVE-2022-42475, a heap-based buffer overflow in FortiOS SSL-VPN, to establish persistent covert access on network edge devices.

## Why it matters
In late 2022, Mandiant observed BOLDMOVE deployed against government and telecom targets in Europe and Africa. Because firewalls sit at the network perimeter and are rarely subjected to EDR monitoring or file integrity checks, attackers used BOLDMOVE to maintain stealthy long-term access while the compromised device continued inspecting and passing traffic normally — a classic case of turning a trusted guardian into a silent spy.

## Key facts
- **CVE-2022-42475** (CVSS 9.3) is the initial access vector — a heap buffer overflow in FortiOS SSL-VPN (versions 7.2.2 and earlier).
- Two variants exist: a **Windows version** and a **Linux version** compiled to run on FortiOS specifically.
- BOLDMOVE can **read, write, and forward traffic**, open a remote shell, and self-update — full RAT capability.
- It patches FortiGate's own **logging mechanisms in memory** at runtime to suppress evidence of its presence.
- Attributed to **UNC2286**, a suspected Chinese espionage group; represents a broader trend of targeting network appliances that lack traditional endpoint security coverage.

## Related concepts
[[CVE-2022-42475]] [[Living-off-the-Land (LotL)]] [[Network Appliance Attacks]] [[Persistent Backdoor]] [[Heap Buffer Overflow]]