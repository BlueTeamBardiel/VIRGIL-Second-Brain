# MITRE ATT&CK Technique T1071.004: Application Layer Protocol: Web Service

## What it is
Imagine a spy sending coded messages through a legitimate postal service — the envelope looks ordinary, but the contents are espionage. T1071.004 describes exactly this: adversaries using legitimate external web services (GitHub, Twitter, Slack, Google Drive, Pastebin) as command-and-control (C2) channels, blending malicious traffic into trusted, whitelisted application traffic.

## Why it matters
The APT group APT41 has used Google Drive and Dropbox as C2 infrastructure, issuing commands via documents stored in cloud storage. Because enterprise firewalls rarely block traffic to Google, the malicious beaconing traffic is nearly invisible — it looks like a user syncing files, not a compromised machine receiving orders.

## Key facts
- **Defense evasion by design**: Traffic goes over HTTPS to trusted domains, bypassing URL reputation filters and many DLP tools that whitelist major cloud providers.
- **Bidirectional abuse**: Attackers can both receive commands (reading posts/files) and exfiltrate data (uploading files/posting updates) through the same service.
- **Common platforms abused**: GitHub (gists for commands), Twitter/X (encoded tweets), Slack webhooks, Pastebin, OneDrive, and Google Docs are frequently documented examples.
- **Detection pivot**: Look for unusual API call volumes, odd user-agent strings, or processes making web service connections that have no business justification (e.g., `svchost.exe` polling GitHub).
- **Sub-technique context**: T1071.004 sits under T1071 (Application Layer Protocol), alongside DNS (T1071.004's sibling T1071.004), HTTP (T1071.001), and SMTP (T1071.003) — examiners test knowing the hierarchy.

## Related concepts
[[Command and Control (TA0011)]] [[T1102 Web Service]] [[Domain Fronting]] [[HTTPS Traffic Analysis]] [[Indicator of Compromise Detection]]