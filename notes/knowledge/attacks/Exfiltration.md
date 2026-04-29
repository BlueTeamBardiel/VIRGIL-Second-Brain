# Exfiltration

## What it is
Like a thief who spends weeks inside a museum memorizing paintings before sneaking out with photos hidden in their coat lining, exfiltration is the *outbound* phase of an attack — the moment stolen data actually leaves the victim's environment. Precisely: exfiltration is the unauthorized transmission of data from a compromised system to an attacker-controlled destination, typically after access and collection phases are complete.

## Why it matters
During the 2020 SolarWinds attack, threat actors used a technique called DNS tunneling to exfiltrate data by encoding stolen information inside seemingly normal DNS queries — traffic that most firewalls never block because DNS is considered essential. This illustrates why monitoring *outbound* traffic is just as critical as hardening inbound defenses; most organizations are far better at stopping intrusion than detecting extraction.

## Key facts
- **MITRE ATT&CK TA0010** is the dedicated Exfiltration tactic, with sub-techniques including exfiltration over C2 channel, web services, and physical media
- Common exfiltration channels: DNS tunneling, HTTPS to cloud storage (Google Drive, Dropbox), ICMP covert channels, and steganography in image uploads
- **DLP (Data Loss Prevention)** tools are the primary defensive control — they inspect outbound traffic for sensitive content like SSNs, PII, or credit card patterns
- Exfiltration is often *slow and low* — attackers throttle data transfers to stay under anomaly detection thresholds (e.g., 1 MB/hour instead of a bulk transfer)
- On Security+/CySA+: exfiltration is distinct from **lateral movement** (internal spreading) and **C2** (command and control) — know where each fits in the kill chain

## Related concepts
[[Data Loss Prevention]] [[DNS Tunneling]] [[MITRE ATT&CK Framework]] [[Command and Control]] [[Network Traffic Analysis]]