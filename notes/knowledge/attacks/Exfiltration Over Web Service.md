# Exfiltration Over Web Service

## What it is
Like a smuggler hiding contraband inside ordinary shipping containers, attackers hide stolen data inside normal-looking HTTPS traffic to legitimate cloud services. Exfiltration Over Web Service (MITRE ATT&CK T1567) is the technique of using trusted platforms—Google Drive, GitHub, Slack, Dropbox, Twitter—as covert channels to move stolen data out of a network, blending malicious traffic with legitimate business activity.

## Why it matters
During the SolarWinds SUNBURST attack, the malware exfiltrated victim environment data encoded within DNS and HTTP requests to actor-controlled infrastructure mimicking legitimate services—demonstrating how defenders relying solely on blocking unknown IPs will miss this technique entirely. Blue teams must inspect outbound data *content and volume patterns*, not just destinations, because blocking GitHub or OneDrive is operationally impossible in most enterprises.

## Key facts
- **Sub-techniques include:** exfiltration to cloud storage (T1567.002), code repositories (T1567.001), and over webhook services (T1567.004)
- **Why it evades detection:** traffic goes to domains with valid certificates and high reputation scores, often whitelisted by default in corporate proxies and firewalls
- **Detection signal:** unusual spikes in upload volume to cloud services, especially during off-hours or from non-user processes (e.g., a server process uploading to Dropbox)
- **DLP controls** inspecting HTTPS content (via TLS inspection/SSL decryption) are the primary technical countermeasure; behavioral baselines help identify anomalous outbound transfers
- **MITRE mapping:** falls under Tactic TA0010 (Exfiltration); often paired with **Automated Exfiltration (T1020)** to reduce dwell time

## Related concepts
[[Data Loss Prevention]] [[Command and Control]] [[SSL/TLS Inspection]] [[MITRE ATT&CK Framework]] [[DNS Exfiltration]]