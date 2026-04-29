# Exfiltration Over Web Service T1567

## What it is
Like a thief smuggling diamonds out of a museum by hiding them in a tourist's gift shop bag, attackers blend stolen data into normal HTTPS traffic to legitimate cloud services. Precisely, T1567 describes adversaries using existing web services — such as GitHub, Google Drive, Dropbox, or Slack — to exfiltrate data, exploiting the trust organizations place in these platforms to bypass DLP controls and firewalls.

## Why it matters
During the SolarWinds supply chain attack, threat actors used Azure Blob Storage and other legitimate cloud infrastructure to stage and exfiltrate reconnaissance data, making detection nearly impossible via traditional IP blocklisting. Defenders must implement CASB (Cloud Access Security Broker) solutions and behavioral analytics to detect abnormal upload volumes to sanctioned services, rather than relying solely on destination-based blocking.

## Key facts
- **Sub-techniques include:** Exfiltration to Code Repository (T1567.001), Exfiltration to Cloud Storage (T1567.002), and Exfiltration to Text Storage Sites (T1567.003) — each targeting a specific trusted platform category
- Traffic rides on **port 443/HTTPS**, making payload inspection nearly impossible without SSL inspection capabilities
- Attackers frequently **encode or encrypt** data before upload (Base64, AES) to defeat content inspection even when SSL decryption is deployed
- Detection relies on **behavioral baselines** — unusual spikes in upload volume, off-hours API calls, or access to cloud services from service accounts are key indicators
- Mitigation includes **application-layer firewalls**, restricting OAuth token permissions, and monitoring DNS queries for known exfiltration-friendly platforms

## Related concepts
[[Data Loss Prevention (DLP)]] [[Command and Control via Web Service T1102]] [[Cloud Storage as Attack Infrastructure]] [[SSL/TLS Inspection]] [[CASB Solutions]]