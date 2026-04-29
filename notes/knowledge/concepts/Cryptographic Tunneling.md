# Cryptographic Tunneling

## What it is
Like stuffing a sealed, addressed letter inside another envelope so the postal carrier only sees the outer address — cryptographic tunneling wraps one network protocol inside another, encrypting the payload to protect it in transit. Specifically, it encapsulates packets from a source protocol within a carrier protocol, applying encryption so that intermediate nodes cannot read or tamper with the inner traffic.

## Why it matters
A remote employee on a hotel Wi-Fi uses an IPsec VPN tunnel to connect to corporate resources — the hotel network sees only encrypted UDP packets destined for the VPN gateway, not the internal SMB shares or Active Directory traffic inside. Conversely, attackers exploit this same principle with DNS tunneling: encoding command-and-control traffic inside legitimate-looking DNS queries to exfiltrate data through firewalls that blindly permit port 53.

## Key facts
- **IPsec operates at Layer 3** and can run in *tunnel mode* (encrypts entire original packet including headers) or *transport mode* (encrypts payload only) — tunnel mode is used for VPNs between gateways.
- **TLS/SSL** creates application-layer tunnels; HTTPS is HTTP traffic tunneled through TLS on port 443.
- **SSH tunneling** (port forwarding) can proxy arbitrary TCP traffic through an encrypted SSH session — a common firewall bypass technique.
- **DNS tunneling** tools like `iodine` and `dnscat2` encode data in DNS query/response records; detection relies on monitoring query frequency, unusual record types (TXT, NULL), and abnormal payload sizes.
- **GRE (Generic Routing Encapsulation)** is a tunneling protocol *without* native encryption — it must be paired with IPsec to be secure, a common exam trick.

## Related concepts
[[VPN Protocols]] [[IPsec]] [[DNS Tunneling]] [[TLS Handshake]] [[SSH Port Forwarding]]