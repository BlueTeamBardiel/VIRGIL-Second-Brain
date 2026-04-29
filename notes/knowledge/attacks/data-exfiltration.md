# data-exfiltration

## What it is
Like a thief who doesn't break the display case but instead photographs every item through the glass and walks out empty-handed, data exfiltration is the unauthorized transfer of data *out* of an organization without necessarily destroying or altering anything. Precisely: it is the deliberate, covert extraction of sensitive data from a target environment to an attacker-controlled destination, often designed to evade detection by blending with legitimate traffic.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors used the SUNBURST backdoor to exfiltrate data by encoding it inside DNS query strings — a technique called DNS tunneling — making the traffic look like routine name resolution. This bypassed perimeter firewalls that weren't inspecting DNS payloads, demonstrating why monitoring *all* protocol channels, not just HTTP/S, is critical for defense.

## Key facts
- **Common channels**: DNS tunneling, HTTPS to attacker-controlled cloud services (e.g., Google Drive, Dropbox), ICMP covert channels, and steganography embedded in image uploads.
- **DLP (Data Loss Prevention)** systems are the primary defensive control; they inspect content leaving the network and can block based on patterns like SSNs, credit card numbers, or classified keywords.
- **Indicators to watch**: Unusual outbound data volumes, connections to rare external IPs, large amounts of data compressed or encrypted before transmission, and off-hours transfers.
- **Staged exfiltration**: Attackers often *stage* data first — collecting and compressing files in a local directory — before exfiltrating in small chunks to avoid volume-based alerts.
- On Security+/CySA+, data exfiltration is frequently paired with **APT (Advanced Persistent Threat)** scenarios and tested alongside concepts like insider threats and data classification.

## Related concepts
[[dns-tunneling]] [[data-loss-prevention]] [[advanced-persistent-threat]] [[covert-channel]] [[insider-threat]]