# HotCroissant

## What it is
Like a Swiss Army knife disguised as a butter knife, HotCroissant is a remote access trojan (RAT) that hides sophisticated capabilities behind seemingly benign behavior. Specifically, it is a modular backdoor malware family attributed to the Lazarus Group (North Korean APT) that establishes persistent command-and-control (C2) communication with attacker infrastructure. It was first identified around 2020 and is notable for its use of named pipes for inter-process communication and its layered obfuscation techniques.

## Why it matters
In documented Lazarus Group campaigns, HotCroissant was delivered via spearphishing emails containing malicious documents that dropped the trojan onto victim systems in financial and critical infrastructure sectors. Once installed, it gave attackers persistent, stealthy access to exfiltrate data and pivot laterally — demonstrating how nation-state actors combine social engineering with custom malware to achieve long-term footholds.

## Key facts
- **Attribution:** Linked to Lazarus Group (DPRK), a North Korean state-sponsored APT known for financially motivated and espionage-driven attacks
- **Delivery mechanism:** Typically deployed via malicious document droppers attached to spearphishing emails (aligns with MITRE ATT&CK T1566.001)
- **C2 communication:** Uses HTTP/HTTPS for command-and-control beacon traffic, making it harder to distinguish from legitimate web traffic
- **Named pipes:** Leverages Windows named pipes for local inter-process communication, a technique used to evade endpoint detection
- **Persistence:** Achieves persistence via Windows Registry run keys or scheduled tasks (ATT&CK T1547.001 / T1053)
- **Detection signal:** Unusual outbound HTTP traffic patterns combined with unexpected scheduled task creation are key behavioral indicators

## Related concepts
[[Lazarus Group]] [[Remote Access Trojan]] [[Command and Control]] [[Spearphishing]] [[Named Pipes]]