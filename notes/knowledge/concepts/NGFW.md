# NGFW

## What it is
Think of a traditional firewall as a nightclub bouncer who only checks what door you're trying to enter — a Next-Generation Firewall is the bouncer who also reads your ID, searches your bag, and cross-references you against a criminal database before letting you in. An NGFW is a stateful firewall that adds deep packet inspection (DPI), application-layer visibility, intrusion prevention (IPS), and identity-based policy enforcement beyond simple port/protocol filtering. Unlike legacy firewalls that only examine headers, NGFWs can identify and control specific applications regardless of port.

## Why it matters
In 2020, attackers commonly tunneled malware command-and-control traffic over port 443 (HTTPS) knowing traditional firewalls would pass it as "web traffic." An NGFW with SSL inspection and application identification would recognize that the traffic pattern doesn't match a known browser signature, triggering an alert or block before exfiltration begins. This application awareness is what makes NGFWs essential in modern perimeter and internal segmentation defense.

## Key facts
- NGFWs operate at **Layer 7 (Application Layer)** of the OSI model, compared to traditional firewalls which stop at Layer 3-4
- Core NGFW capabilities include: **DPI, TLS/SSL inspection, integrated IPS, application control, and user identity tracking**
- **SSL/TLS inspection** requires the NGFW to act as a man-in-the-middle, decrypting, inspecting, and re-encrypting traffic — this requires deploying a trusted certificate
- NGFWs can enforce policy based on **Active Directory user identity**, not just IP addresses (e.g., block social media for HR users only)
- Gartner coined the term "NGFW" in 2003; Palo Alto Networks popularized the architecture commercially — it appears on Security+ under **network security controls**

## Related concepts
[[Deep Packet Inspection]] [[Intrusion Prevention System]] [[Unified Threat Management]] [[Stateful Inspection]] [[SSL Inspection]]