# T1102 Web Service

## What it is
Like a spy using a public bulletin board at a train station to pass messages — hiding in plain sight among thousands of legitimate notes — attackers use trusted web services (Twitter, GitHub, Pastebin, Discord) as command-and-control (C2) infrastructure. This technique involves leveraging legitimate, widely-trusted online platforms to host malicious payloads, relay commands, or exfiltrate data, making malicious traffic blend seamlessly with normal business traffic.

## Why it matters
The APT group APT41 used Google Docs and GitHub as C2 channels, issuing commands through document edits and repository commits. Because corporate firewalls and proxies almost never block Google or GitHub, defenders couldn't simply firewall the C2 traffic without disrupting legitimate operations — forcing analysts to instead look for anomalous behavioral patterns in how their endpoints were communicating with these services.

## Key facts
- **Sub-techniques include**: T1102.001 (Dead Drop Resolver), T1102.002 (Bidirectional Communication), T1102.003 (One-Way Communication)
- **Detection challenge**: Traffic uses HTTPS to trusted domains, bypassing URL reputation filters and SSL inspection policies that whitelist major cloud providers
- **Common platforms abused**: GitHub, Twitter/X, Pastebin, Slack, Discord, Google Drive, OneDrive, Dropbox
- **Dead Drop Resolver** is the most common variant: malware retrieves the *real* C2 IP/domain from a public post, making the actual C2 server easily rotatable without recompiling malware
- **Defense approach**: Monitor for high-frequency, scheduled, or unusually structured API calls to cloud platforms; use User-Agent analysis and DNS query volume baselining to detect beaconing behavior

## Related concepts
[[C2 Infrastructure]] [[T1071 Application Layer Protocol]] [[T1568 Dynamic Resolution]] [[Traffic Analysis]] [[Defense Evasion]]