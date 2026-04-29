# APT3

## What it is
Think of APT3 as a professional espionage firm on retainer — not smash-and-grab criminals, but patient contractors who pick the lock, copy the files, and leave without disturbing the furniture. APT3 (also tracked as Gothic Panda, UPS Team, or TG-0110) is a Chinese state-sponsored threat group assessed to operate on behalf of China's Ministry of State Security (MSS), specializing in cyber espionage targeting defense, aerospace, and telecommunications sectors.

## Why it matters
APT3 was responsible for Operation Clandestine Fox (2014), which exploited a zero-day in Internet Explorer (CVE-2014-1776) to compromise defense contractors and government agencies via spear-phishing emails. Defenders responding to this campaign learned a critical lesson: even fully patched systems can be compromised if a zero-day is in play, making behavioral detection and network segmentation essential layers of defense.

## Key facts
- **Attribution**: Linked to the MSS Guangdong State Security Department; one of the first APTs publicly tied to a specific Chinese intelligence bureau
- **TTPs**: Known for spear-phishing with malicious attachments, browser zero-day exploitation, and custom backdoors (Shotput/Cookiecutter, PLUGX)
- **Lateral Movement**: Uses credential harvesting tools (Mimikatz-style) and legitimate admin tools (PsExec) to blend into normal traffic — a classic "living off the land" technique
- **Target sectors**: U.S. defense contractors, aerospace, telecommunications, and technology companies — classic strategic intelligence targets
- **MITRE ATT&CK**: Extensively documented under ATT&CK Group G0022; useful reference for building detection rules against their known TTPs

## Related concepts
[[Advanced Persistent Threat]] [[Spear Phishing]] [[Zero-Day Exploit]] [[Living Off the Land]] [[MITRE ATT&CK]]