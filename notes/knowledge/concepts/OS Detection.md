# OS Detection

## What it is
Like a doctor identifying a patient's age and health by reading an X-ray without asking their name, OS detection infers a target system's operating system by analyzing subtle patterns in its network traffic. Specifically, it examines characteristics like TCP/IP stack behavior, TTL values, TCP window sizes, and ICMP responses — quirks that differ predictably between Windows, Linux, macOS, and others. This process is called **fingerprinting**, and it can be active (sending crafted probes) or passive (silently observing existing traffic).

## Why it matters
An attacker mapping a corporate network before launching an exploit needs to know whether targets run Windows Server 2016 or Ubuntu — because exploits are OS-specific. Using Nmap's `-O` flag, they can fingerprint hosts and immediately narrow their toolkit to relevant CVEs, making OS detection a critical step in the reconnaissance phase of the kill chain.

## Key facts
- **Active fingerprinting** (e.g., Nmap `-O`) sends crafted packets and analyzes responses; **passive fingerprinting** (e.g., p0f) silently observes existing traffic without generating new connections
- TTL values are a quick indicator: Windows defaults to **128**, Linux to **64**, Cisco devices to **255**
- TCP window size and options ordering are among the most reliable passive fingerprinting signals
- Nmap uses a database of **OS fingerprint signatures** and requires at least one open and one closed port for accurate OS detection
- Defenders can **obscure OS identity** by normalizing TTL values and TCP stack behavior using firewalls or tools like PF/scrub, a technique called **IP stack normalization**

## Related concepts
[[Network Reconnaissance]] [[Nmap Port Scanning]] [[TCP/IP Stack Fingerprinting]] [[Passive Reconnaissance]] [[Banner Grabbing]]