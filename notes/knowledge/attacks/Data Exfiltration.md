# Data Exfiltration

## What it is
Like a thief who spends weeks casing a museum, then walks out with paintings hidden inside a catering cart, data exfiltration is the unauthorized transfer of data *out* of an organization — often disguised within legitimate-looking traffic. It is the final payload delivery of most breaches: credentials, IP, or PII leaving the network to an attacker-controlled destination.

## Why it matters
In the 2020 SolarWinds attack, adversaries used the SUNBURST backdoor to exfiltrate data over DNS and HTTPS to attacker-controlled subdomains, blending perfectly with normal business traffic for months. DLP (Data Loss Prevention) tools and DNS monitoring would have been the primary detective controls capable of catching this behavior early.

## Key facts
- **Common channels:** DNS tunneling, HTTPS POST requests, ICMP covert channels, and steganography inside image uploads — all chosen to evade firewall rules that allow these protocols outbound
- **Indicators of compromise:** Unusually large outbound transfers, repeated connections to rare external IPs, and high-volume DNS queries to a single domain are red flags in CySA+ scenarios
- **DLP is the primary preventive control** — it can inspect content in motion and block transfers of data matching patterns like SSNs, credit card numbers, or classified keywords
- **Staged exfiltration:** Attackers often compress and encrypt data before exfiltration (using tools like 7-Zip or rar) to reduce size and evade content inspection
- **Security+ exam tip:** Exfiltration is categorized under the *impact* phase of the MITRE ATT&CK framework (TA0010), distinct from initial access or lateral movement

## Related concepts
[[DNS Tunneling]] [[Data Loss Prevention]] [[Covert Channels]] [[MITRE ATT&CK Framework]] [[Network Traffic Analysis]]