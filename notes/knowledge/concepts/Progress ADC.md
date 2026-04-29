# Progress ADC

## What it is
Like a bouncer at a club who checks IDs at the door but also watches for suspicious behavior *inside* — Progress Application Delivery Controller (ADC) is a network appliance that sits between clients and servers, handling load balancing, SSL termination, and application-layer traffic inspection. It is a hardware/software platform (formerly F5-adjacent, now under Progress Software) that optimizes and secures application delivery by acting as a reverse proxy with deep packet inspection capabilities.

## Why it matters
In 2023, Progress ADC (specifically MOVEit-adjacent Progress products) became a high-profile target when threat actors exploited SQL injection vulnerabilities in Progress Software products, leading to mass data exfiltration by the Cl0p ransomware group. ADC devices are attractive targets because they sit at the network perimeter, handle decrypted traffic, and often run with elevated privileges — compromising one device grants visibility into *all* traffic flowing through it.

## Key facts
- ADCs operate at Layer 4–7 of the OSI model, making them capable of SSL/TLS offloading, content switching, and WAF functionality
- Because ADCs terminate SSL sessions, a compromised ADC means an attacker sees plaintext traffic — a critical man-in-the-middle position
- Progress Software CVEs (e.g., CVE-2023-34362) demonstrated how unpatched ADC-adjacent infrastructure can become a supply-chain-style mass exploitation vector
- ADCs commonly integrate with AAA systems (RADIUS, LDAP) for authentication offloading, making them a high-value credential harvesting target
- Defense best practices include network segmentation, strict patch management, and monitoring ADC management interfaces — which should *never* be internet-facing

## Related concepts
[[Load Balancer Security]] [[SSL Termination]] [[Reverse Proxy]] [[Web Application Firewall]] [[CVE Exploitation]]