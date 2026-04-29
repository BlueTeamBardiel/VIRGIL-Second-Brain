# SSL Inspection

## What it is
Like a customs officer opening sealed packages to check contents before resealing them with an official stamp, SSL inspection breaks open encrypted HTTPS traffic, examines it, then re-encrypts it before forwarding. Formally, it's a man-in-the-middle technique used by security appliances (firewalls, proxies) to decrypt, inspect, and re-encrypt TLS traffic for threat detection and policy enforcement. The device presents its own certificate to the client while maintaining a separate TLS session with the destination server.

## Why it matters
Attackers increasingly tunnel malware command-and-control traffic over HTTPS precisely because organizations historically left encrypted traffic uninspected. In 2019, security researchers noted that over 70% of malware used encrypted channels — without SSL inspection, a next-gen firewall is effectively blind to these threats. SSL inspection allows DLP tools to catch sensitive data exfiltration that would otherwise ride invisibly inside an encrypted tunnel.

## Key facts
- SSL inspection is also called **TLS inspection**, **HTTPS inspection**, or **SSL/TLS forward proxy decryption**
- Requires deploying the inspection device's **root CA certificate** to all client machines (typically via GPO) so clients trust the re-signed certificates
- Creates a **privacy concern** — the inspecting device can read all encrypted content, including credentials and banking data; must be scoped carefully
- **Certificate pinning** in applications (like mobile apps) will break when SSL inspection is active, causing connection failures
- Organizations must maintain **certificate revocation checking** on both legs of the inspection — failure to do so introduces vulnerability to revoked server certificates

## Related concepts
[[TLS (Transport Layer Security)]] [[Man-in-the-Middle Attack]] [[Deep Packet Inspection]] [[Forward Proxy]] [[Data Loss Prevention]]