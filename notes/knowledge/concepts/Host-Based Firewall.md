# Host-based Firewall

## What it is
Think of it as a bouncer stationed *inside* your apartment door — even if someone gets past building security, they still have to answer to you personally. A host-based firewall is software running directly on an individual endpoint that inspects and filters inbound and outbound network traffic based on defined rules, operating independently of any network-level firewall.

## Why it matters
In 2017, the WannaCry ransomware spread laterally across corporate networks by exploiting SMB port 445 — but endpoints with Windows Firewall properly configured to block unsolicited inbound SMB traffic were significantly more resistant to infection. A network perimeter firewall couldn't stop east-west movement once the attacker was already inside, but the host-based firewall could. This illustrates why defense-in-depth requires protection at the host layer, not just the network edge.

## Key facts
- **Examples include**: Windows Defender Firewall, iptables/nftables (Linux), and macOS Application Firewall — all built into the OS at no extra cost
- **Operates at the transport layer (Layer 4)** by default, filtering by IP address, port, and protocol; advanced versions inspect application identity (Layer 7)
- **Protects against lateral movement** — even after an attacker breaches the network perimeter, host-based rules can block peer-to-peer propagation between internal hosts
- **Logs are a detection asset** — host firewall logs can reveal port scanning, beaconing, or unauthorized outbound connections to C2 infrastructure
- **Security+ distinguishes** host-based firewalls from network firewalls by scope: host-based protects one device; network firewalls protect traffic between network segments

## Related concepts
[[Network Firewall]] [[Defense in Depth]] [[Endpoint Detection and Response]] [[Lateral Movement]] [[Port Filtering]]