# tc - traffic control

## What it is
Like a traffic cop at a busy intersection who can wave certain cars through instantly, slow down trucks, or completely block off a lane — `tc` is the Linux kernel tool that shapes, schedules, and filters network packets before they leave or after they arrive on an interface. It uses queuing disciplines (qdiscs), classes, and filters to enforce bandwidth limits, introduce latency, and prioritize traffic at the OS level.

## Why it matters
Red teamers and malware authors abuse `tc` to simulate packet loss or throttle outbound connections, making exfiltration look like normal degraded network performance and evading anomaly-based detection. Defenders use it to rate-limit suspicious endpoints — for example, capping a compromised host's egress to 10 kbps while an incident is investigated, buying time without fully cutting off access and tipping off the attacker.

## Key facts
- `tc` operates via **qdiscs** (queuing disciplines); the default is `pfifo_fast`, but `netem` is the most powerful for simulation, allowing artificial delay, loss, duplication, and corruption
- Command structure: `tc qdisc add dev eth0 root netem delay 100ms loss 10%` — adds 100ms latency and 10% packet loss to all outbound traffic on eth0
- `tc` filters can match on IP, port, or DSCP markings, enabling **traffic classification** for QoS enforcement
- Used in **network emulation labs** (alongside tools like GNS3) to simulate real-world WAN conditions without physical hardware
- Because `tc` runs in **kernel space**, changes take effect immediately and survive across active connections — making it a high-privilege persistence and evasion technique if an attacker gains root

## Related concepts
[[Network Traffic Analysis]] [[Packet Filtering]] [[iptables]] [[Bandwidth Throttling]] [[Linux Privilege Escalation]]