# T1046 Port Scan

## What it is
Like a burglar walking down a street testing every door handle and window latch before choosing which house to rob, a port scan probes a target system's TCP/UDP ports to discover which services are listening and potentially exploitable. It is classified under MITRE ATT&CK's Discovery tactic — an adversary systematically queries port numbers (0–65535) to map the attack surface before launching exploits.

## Why it matters
During the 2017 WannaCry outbreak, attackers used automated scanning to locate hosts with TCP port 445 (SMB) exposed before deploying the EternalBlue exploit. Defenders who monitored for rapid sequential connection attempts to port 445 across their networks had an early-warning signal that scanning — and likely a worm — was propagating internally.

## Key facts
- **Common tools**: Nmap, Masscan, Zmap, and Angry IP Scanner are the most frequently observed in both red team operations and real-world intrusions.
- **Scan types matter**: SYN (half-open) scans are stealthier than full TCP connect scans because they never complete the three-way handshake, generating fewer log entries.
- **Detection indicators**: High volume of SYN packets to sequential or random ports from a single source IP, especially with no corresponding ACK/RST responses from the target.
- **MITRE mapping**: T1046 falls under Tactic TA0007 (Discovery) and is frequently a precursor to T1190 (Exploit Public-Facing Application).
- **Defense controls**: Network intrusion detection systems (IDS) like Snort have specific signatures for port sweep and horizontal scan patterns; firewall default-deny policies reduce the information leaked by scans.

## Related concepts
[[Network Enumeration]] [[T1190 Exploit Public-Facing Application]] [[Intrusion Detection Systems]] [[Network Segmentation]] [[Banner Grabbing]]