# NFLOG

## What it is
Think of NFLOG as a security camera feed that doesn't block traffic — it just silently copies packets to a waiting observer. Precisely, NFLOG is a Linux netfilter target that passes matched network packets to userspace processes (like `ulogd`) via a netlink socket for logging, rather than dropping or accepting them. Unlike traditional syslog-based firewall logging, NFLOG decouples the logging decision from the forwarding decision.

## Why it matters
During incident response on a compromised Linux server, analysts can add iptables rules with `-j NFLOG` to capture specific suspicious traffic (e.g., outbound connections on unusual ports) without disrupting production flows or alerting the attacker by blocking traffic. This passive capture capability feeds directly into SIEMs or pcap files, giving defenders forensic evidence of lateral movement or C2 beaconing in real time.

## Key facts
- NFLOG is an **iptables/nftables target** (not a standalone tool); it requires a userspace daemon like `ulogd2` to actually write logs to disk or a database.
- Packets are sent via **netlink group IDs** (`--nflog-group`), allowing multiple consumers to subscribe to different traffic categories simultaneously.
- NFLOG supports **packet truncation** (`--nflog-size`) to capture only headers, reducing storage overhead while preserving metadata for analysis.
- Unlike `LOG` target (which writes to kernel syslog), NFLOG output can be written to **pcap format**, making captures directly importable into Wireshark or Zeek.
- NFLOG operates at the **kernel level**, meaning a compromised userspace process cannot prevent packets from being logged if the iptables rule is in place.

## Related concepts
[[Netfilter]] [[iptables]] [[Network Traffic Analysis]] [[Intrusion Detection Systems]] [[Packet Capture]]