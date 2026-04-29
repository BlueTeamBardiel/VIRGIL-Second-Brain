# Action RAT

## What it is
Like a sleeper agent who moves in quietly, follows orders over encrypted radio, and reports back without raising suspicion, Action RAT is a Remote Access Trojan that establishes a covert command-and-control (C2) channel to give attackers persistent, stealthy control over a victim's machine. First documented around 2021, it is written in Delphi and primarily targets Pakistani government and defense entities, attributed to the SideCopy APT group.

## Why it matters
In documented SideCopy campaigns, Action RAT was delivered via spear-phishing emails with malicious attachments masquerading as official Pakistani government documents. Once installed, it allowed attackers to silently exfiltrate files, capture keystrokes, and deploy additional payloads — all while blending into normal network traffic through its encrypted C2 communications, making it a clear example of an advanced persistent threat operating below the radar of basic defenses.

## Key facts
- **Attribution**: Linked to SideCopy APT, a Pakistani-origin threat group believed to be a sub-cluster of Transparent Tribe (APT36), targeting South Asian government and military organizations.
- **Written in Delphi**: This older language choice helps evade modern AV signatures tuned primarily for C/C++ or .NET malware.
- **Core capabilities**: File enumeration/exfiltration, keylogging, screenshot capture, execution of additional payloads, and remote shell access.
- **Delivery vector**: Primarily spear-phishing with lure documents (often ZIP archives containing LNK or malicious Office files exploiting older CVEs).
- **C2 communication**: Uses encrypted HTTP-based C2 channels, making traffic analysis harder without SSL/TLS inspection or behavioral anomaly detection.

## Related concepts
[[Remote Access Trojan (RAT)]] [[SideCopy APT]] [[Spear Phishing]] [[Command and Control (C2)]] [[Advanced Persistent Threat (APT)]]