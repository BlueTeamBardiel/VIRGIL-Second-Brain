# IP addressing

## What it is
Like a postal address on every envelope sent through the internet, an IP address is a numerical label assigned to each device on a network that serves two purposes: identification and location routing. IPv4 uses 32-bit addresses (e.g., 192.168.1.1), while IPv6 uses 128-bit addresses to solve IPv4 exhaustion.

## Why it matters
In a SYN flood DDoS attack, attackers spoof source IP addresses to send thousands of half-open TCP connection requests to a target server, exhausting its connection table. Defenders use ingress filtering (BCP38) at network edges to drop packets with source IPs that couldn't legitimately originate from that network, making spoofed-IP attacks significantly harder to execute.

## Key facts
- **IPv4** has ~4.3 billion addresses (2³²); **IPv6** has 340 undecillion (2¹²⁸), making exhaustion practically impossible
- **Private IP ranges** (RFC 1918): 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 — these are non-routable on the public internet
- **APIPA** range (169.254.0.0/16) indicates a host failed to obtain a DHCP lease — a red flag during network troubleshooting
- **Loopback** address (127.0.0.1 / ::1 in IPv6) routes traffic back to the local host; used for internal service testing
- IP addresses alone **do not authenticate identity** — source IPs can be spoofed at Layer 3, which is why higher-layer authentication mechanisms (TLS, tokens) are essential

## Related concepts
[[Subnetting]] [[NAT]] [[DHCP]] [[IPv6 Security]] [[Packet Spoofing]]