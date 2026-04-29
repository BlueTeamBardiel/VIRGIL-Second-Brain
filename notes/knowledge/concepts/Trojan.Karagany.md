# Trojan.Karagany

## What it is
Like a master thief who picks your lock, photographs your valuables, and leaves a hidden back door for a return visit — Karagany is a modular remote access Trojan (RAT) designed for credential theft, file exfiltration, and persistent backdoor access. First identified around 2010 and notably deployed by the Dragonfly/Energetic Bear APT group, it targets Windows systems and can download additional malware payloads on command.

## Why it matters
In the 2014 Dragonfly campaign against Western energy sector companies, Karagany was used to compromise industrial control system (ICS) operators by stealing credentials and capturing screenshots, giving adversaries reconnaissance-level access to critical infrastructure. Defenders who monitored for unusual outbound connections to C2 infrastructure and abnormal LSASS memory access were able to detect the intrusion before operational damage occurred.

## Key facts
- **Attribution**: Linked to Dragonfly (also called Energetic Bear), a Russian-nexus APT group targeting energy, aviation, and defense sectors
- **Capabilities**: Credential harvesting, screenshot capture, file collection/exfiltration, and downloading secondary payloads — making it a full-featured espionage toolkit
- **Persistence mechanism**: Achieves persistence via Windows Registry run keys and scheduled tasks, standard techniques mapped to MITRE ATT&CK T1547 and T1053
- **Distribution vector**: Historically delivered via spear-phishing emails and watering hole attacks against sector-specific websites
- **Detection indicator**: Creates a mutex on infected systems; network traffic analysis revealing periodic C2 beacon patterns is a key IOC for detection

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Remote Access Trojan (RAT)]] [[Watering Hole Attack]] [[MITRE ATT&CK Framework]] [[Industrial Control System (ICS) Security]]