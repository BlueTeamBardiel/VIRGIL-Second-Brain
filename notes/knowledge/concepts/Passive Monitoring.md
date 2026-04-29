# Passive Monitoring

## What it is
Like a wildlife photographer hiding in the brush — observing animal behavior without disturbing it — passive monitoring captures network traffic and system activity without injecting probes, queries, or test packets. It involves collecting and analyzing data that already flows through a network (packets, logs, NetFlow records) rather than generating new traffic to elicit responses. The observer remains invisible to the observed.

## Why it matters
During a threat hunt, a SOC analyst deploys a network TAP on the core switch to capture raw traffic and discovers a workstation beaconing to a known C2 IP every 60 seconds — a pattern invisible to active scanners because the malware only communicated during its own schedule. Active scanning would have missed this entirely; passive capture caught it because the traffic was already there.

## Key facts
- **Network TAPs and SPAN ports** are the two primary hardware/software mechanisms for passive traffic capture — TAPs are hardware inline devices; SPAN ports mirror traffic on managed switches
- Passive monitoring produces **no additional network load** on production systems, making it safe for sensitive OT/ICS environments where injecting packets can crash PLCs
- **Wireshark, Zeek (Bro), and Arkime (Moloch)** are the canonical passive capture/analysis tools on the Security+/CySA+ radar
- Passive DNS monitoring captures DNS query/response pairs to detect **domain generation algorithms (DGAs)** and data exfiltration via DNS tunneling
- A key limitation: passive monitoring **cannot detect encrypted payload content** without decryption mechanisms (like SSL/TLS inspection) and misses attacks that never cross the monitored segment

## Related concepts
[[Network TAP]] [[Packet Capture]] [[NetFlow Analysis]] [[Threat Hunting]] [[Network Baseline]]