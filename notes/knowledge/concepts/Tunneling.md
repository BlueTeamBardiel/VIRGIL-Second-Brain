# Tunneling

## What it is
Like hiding a letter inside another letter to sneak it past a mail inspector, tunneling wraps one network protocol inside another to carry it across a network that wouldn't normally allow it. Precisely: tunneling encapsulates packets of one protocol within packets of a different protocol, creating a logical "tube" through an intermediate network. The outer protocol handles transport; the inner protocol carries the actual payload invisibly to intermediate devices.

## Why it matters
Attackers use DNS tunneling to exfiltrate data from networks that block most outbound traffic but leave port 53 open — encoding stolen files as Base64 strings inside DNS queries to a controlled external server. Defenders watching for unusually large DNS query volumes, high entropy domain names, or abnormal TXT record usage can detect this covert channel before significant data loss occurs.

## Key facts
- **Common tunneling protocols**: GRE, SSH, IPsec, SSL/TLS, and L2TP are legitimate examples; DNS and ICMP tunneling are frequent attacker abuses
- **VPNs rely on tunneling** — IPsec tunnel mode encrypts the entire original IP packet and wraps it in a new IP header
- **Split tunneling** sends only corporate-bound traffic through the VPN while internet traffic exits locally, creating a potential bypass for security controls
- **ICMP tunneling** hides data in the payload field of ping packets — tools like `ptunnel` automate this technique
- **Detection indicators**: anomalous protocol behavior (oversized ICMP packets, high DNS query frequency), unexpected protocol on a standard port (e.g., SSH over port 443 to evade firewalls)

## Related concepts
[[VPN]] [[DNS Poisoning]] [[Covert Channels]] [[Protocol Encapsulation]] [[Firewall Evasion]]