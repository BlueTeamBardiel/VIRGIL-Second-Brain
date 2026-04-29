# Data in transit

## What it is
Like a postcard traveling through the mail system — anyone who handles it can read it — data in transit is information actively moving across a network between two endpoints. Precisely: data in transit refers to any data traversing a network medium (wired, wireless, or internet), as opposed to data at rest (stored) or data in use (being processed).

## Why it matters
In 2017, the KRACK (Key Reinstallation Attack) vulnerability demonstrated that even WPA2-protected Wi-Fi traffic could be decrypted by forcing nonce reuse in the handshake — exposing data in transit on networks millions believed were secure. This attack underscores why end-to-end encryption (e.g., TLS) must layer on top of transport-level encryption: never rely on a single protocol to protect moving data.

## Key facts
- **TLS 1.3** is the current standard for encrypting data in transit; TLS 1.0 and 1.1 are deprecated and considered insecure for exam purposes
- **Man-in-the-Middle (MitM) attacks** are the primary threat vector — an adversary intercepts traffic between two parties without either knowing
- **IPsec** operates at Layer 3 (Network) and secures data in transit at the IP level; commonly used in VPN tunnels (IKEv2 + IPsec)
- **SSL stripping** attacks downgrade HTTPS connections to HTTP, exposing data in transit — mitigated by HSTS (HTTP Strict Transport Security)
- Data in transit protection is a core requirement under **PCI-DSS (Requirement 4)** — prohibiting unencrypted transmission of cardholder data across open/public networks

## Related concepts
[[TLS]] [[Man-in-the-Middle Attack]] [[IPsec]] [[Data at Rest]] [[VPN]]