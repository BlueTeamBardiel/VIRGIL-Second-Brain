# Promiscuous Mode Detection

## What it is
Like catching a nosy neighbor pressing their ear against every apartment door instead of just their own, promiscuous mode detection identifies network interface cards (NICs) that are capturing *all* traffic on a segment rather than only frames addressed to them. Normally a NIC discards frames not destined for its MAC address; in promiscuous mode, it accepts everything — a prerequisite for running a packet sniffer.

## Why it matters
An attacker who compromises an internal host and enables promiscuous mode can passively harvest credentials, session tokens, and sensitive data from shared network segments without generating any outbound traffic — making it nearly invisible to firewall logs. Defenders running network monitoring tools like `ifconfig` audits or purpose-built detection scripts can identify rogue sniffers before significant data exfiltration occurs.

## Key facts
- **DNS latency test**: Send a ping with a fake IP but a real hostname; a host in promiscuous mode may attempt a reverse DNS lookup on the fake IP, revealing itself through anomalous DNS traffic.
- **ARP test**: Craft an ARP request with a valid IP but a deliberately wrong (non-broadcast) destination MAC; only a NIC in promiscuous mode will process and respond to it.
- **OS-level detection**: On Linux, `ip link show` or `/proc/net/dev` flags reveal `PROMISC` status; on Windows, tools like PromqryUI enumerate affected adapters.
- **Switched networks reduce exposure**: On a switch, promiscuous mode only captures traffic on the local segment or VLAN — full capture requires combining it with ARP poisoning or a SPAN port.
- **Legitimate uses exist**: IDS/IPS sensors, Wireshark for diagnostics, and network TAPs intentionally run in promiscuous mode, so detection requires context to avoid false positives.

## Related concepts
[[Packet Sniffing]] [[ARP Poisoning]] [[Network Tap]] [[Passive Reconnaissance]] [[Intrusion Detection Systems]]