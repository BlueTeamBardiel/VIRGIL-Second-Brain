# ntopng

## What it is
Think of it as a flight radar dashboard for your network — instead of tracking planes, it tracks every flow of packets in real time, showing you exactly who's talking to whom, how much, and for how long. ntopng (next-generation ntop) is an open-source, web-based network traffic monitoring and analysis tool that provides deep visibility into network flows using NetFlow, sFlow, and live packet capture data.

## Why it matters
During a lateral movement attack, an adversary that has compromised a workstation begins quietly scanning internal subnets via SMB. ntopng can surface this behavior by flagging anomalous host-to-host traffic patterns — specifically, a single internal host initiating dozens of connections to port 445 across multiple subnets in a short window — giving a SOC analyst the visibility needed to isolate the host before ransomware deploys.

## Key facts
- ntopng operates at Layer 3–7, capable of identifying application-layer protocols (e.g., HTTP, DNS, TLS) through Deep Packet Inspection (DPI) using the nDPI library.
- It ingests data via PCAP (live or file), NetFlow v5/v9, IPFIX, and sFlow — making it compatible with most enterprise network infrastructure.
- Hosts are scored with a behavioral **traffic score** that flags suspicious anomalies like excessive DNS queries, geographic IP anomalies, or known-bad IPs via threat intelligence feeds.
- ntopng can integrate with intrusion detection systems like Suricata and forward alerts to SIEMs via syslog or Elasticsearch.
- The community edition is free and open-source; the professional/enterprise editions add features like historical flow analysis and active monitoring scripts (Lua-based).

## Related concepts
[[NetFlow Analysis]] [[Deep Packet Inspection]] [[Network Traffic Analysis]] [[SIEM]] [[Suricata]]