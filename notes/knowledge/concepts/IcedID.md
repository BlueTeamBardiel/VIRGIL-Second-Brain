# IcedID

## What it is
Think of IcedID as a lockpick that lets a burglar into your house, then quietly calls their entire crew to ransack the place. IcedID (also known as BokBot) is a banking trojan and malware loader first identified in 2017 that establishes an initial foothold on a victim machine, steals financial credentials via browser injection, and then deploys secondary payloads — most notoriously ransomware like Conti or Quantum.

## Why it matters
In numerous enterprise incidents, IcedID arrived via a malicious Microsoft Office document attached to a phishing email. Once executed, it used process injection to hide inside legitimate Windows processes, harvested banking credentials silently, and then beacon'd out to command-and-control infrastructure — ultimately serving as the entry point for a full Conti ransomware deployment days or weeks later.

## Key facts
- **Delivery vector**: Primarily phishing emails with malicious Office documents containing macros (or later, ISO/LNK files to bypass macro restrictions)
- **Persistence mechanism**: Scheduled Tasks and registry Run keys to survive reboots
- **Credential theft**: Uses man-in-the-browser (MitB) attacks by injecting into browser processes to intercept banking sessions
- **Loader role**: Acts as an Initial Access Broker (IAB) tool — frequently drops Cobalt Strike beacons as a second stage, enabling hands-on-keyboard ransomware attacks
- **Detection evasion**: Leverages DLL sideloading and lives inside legitimate processes (e.g., `svchost.exe`) to avoid signature-based detection

## Related concepts
[[Banking Trojans]] [[Phishing]] [[Command and Control (C2)]] [[Man-in-the-Browser Attack]] [[Initial Access Brokers]]