# HTTPS Traffic Analysis

## What it is
Like reading the outside of a sealed envelope — you can't see the letter inside, but you can still learn who sent it, who received it, how heavy it is, and how often they write. HTTPS traffic analysis is the examination of encrypted web traffic metadata (packet sizes, timing, IP addresses, SNI headers, and certificate data) to extract intelligence without breaking the encryption itself. The content stays hidden, but the *patterns* speak volumes.

## Why it matters
Nation-state actors and network defenders alike use traffic analysis against HTTPS sessions to identify which services users are accessing, even without decrypting a single byte. In 2014, researchers demonstrated that Netflix viewing habits could be fingerprinted with over 99% accuracy from encrypted traffic alone — meaning an ISP or attacker on the network path could determine exactly what you're watching despite HTTPS protection.

## Key facts
- **SNI (Server Name Indication)** leaks the destination hostname in plaintext during the TLS handshake — even before the certificate is exchanged; ECH (Encrypted Client Hello) mitigates this
- **Certificate transparency logs** are public records of issued TLS certificates, enabling defenders to detect unauthorized certificates issued for their domains
- **Traffic flow analysis** uses packet size, timing intervals, and session duration as a fingerprint — VPNs reduce but rarely eliminate this exposure
- **TLS version and cipher suite negotiation** occurs in plaintext and can fingerprint client applications (JA3 hashing exploits this)
- **SSL/TLS inspection** (MITM proxy) is the only way to fully decrypt HTTPS traffic for DLP or IDS analysis; requires installing a trusted root CA on endpoints

## Related concepts
[[TLS Handshake]] [[Network Traffic Analysis]] [[SSL Inspection]] [[JA3 Fingerprinting]] [[Certificate Transparency]]