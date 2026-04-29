# Network Flow Analysis

## What it is
Like reviewing a highway's traffic camera logs — you can't see inside each car, but you can track which vehicles traveled between which exits, for how long, and in what volumes. Network flow analysis examines metadata about traffic (source/destination IPs, ports, protocols, byte counts, timestamps) without capturing full packet payloads to identify behavioral patterns across a network.

## Why it matters
During the SolarWinds supply chain attack, defenders used flow analysis to detect unusual outbound connections from internal servers to unfamiliar external IPs — even though the traffic was encrypted and payload inspection was impossible. Flow data revealed abnormal volumes and timing patterns consistent with C2 beaconing, enabling incident responders to scope the breach across thousands of endpoints.

## Key facts
- **NetFlow** (Cisco), **IPFIX**, and **sFlow** are the three dominant flow collection standards; NetFlow v9 and IPFIX are most common on Security+/CySA+ exams
- Flow records capture the **5-tuple**: source IP, destination IP, source port, destination port, and protocol — never payload content
- **Beaconing detection** is a primary use case: C2 malware calls home at regular intervals, creating statistically regular inter-flow timing that analysts can spot
- Flow data is stored far longer than full packet captures (PCAP) due to dramatically smaller file sizes — making it preferred for **long-term trend analysis** and retrospective investigations
- A sudden spike in **ICMP flows** to a single external host, or large outbound transfers on port 443 to a brand-new domain, are classic indicators of **data exfiltration** detectable through flow analysis

## Related concepts
[[Intrusion Detection Systems]] [[Packet Capture Analysis]] [[Security Information and Event Management]] [[Threat Hunting]] [[Command and Control Infrastructure]]