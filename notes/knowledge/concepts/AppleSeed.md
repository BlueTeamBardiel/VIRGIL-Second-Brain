# AppleSeed

## What it is
Like a Swiss Army knife hidden in a piece of mail, AppleSeed is a modular backdoor that arrives disguised as a legitimate document and unfolds into a full surveillance toolkit. Precisely, it is a South Korean-targeted malware family attributed to the North Korean APT group Kimsuky, functioning as a backdoor with capabilities including keylogging, screenshot capture, file exfiltration, and command-and-control (C2) communication. It typically arrives via spear-phishing emails containing malicious attachments or links.

## Why it matters
In 2022, South Korean researchers documented Kimsuky campaigns using AppleSeed to target government officials, academics, and think-tank researchers by embedding it in documents appearing to come from trusted institutions. Once deployed, AppleSeed silently collected credentials and sensitive documents over extended dwell periods, demonstrating how nation-state actors use persistent, low-noise backdoors for long-term intelligence gathering rather than immediate disruption.

## Key facts
- **Attribution**: Linked to Kimsuky (also tracked as APT43/Velvet Chollima), a North Korean state-sponsored group focused primarily on espionage against South Korea and allied nations
- **Delivery vector**: Spear-phishing with malicious HWP (Hangul Word Processor) files or ZIP attachments — HWP targeting is a signature indicator for Korean-language victims
- **Capabilities**: Modular design supports keylogging, screenshot capture, file harvesting, and receiving/executing remote commands from C2 servers
- **Persistence mechanism**: Achieves persistence via Windows Registry run keys or scheduled tasks, allowing it to survive reboots
- **Detection challenge**: Uses legitimate cloud services (e.g., email platforms) as C2 channels to blend malicious traffic with normal business activity

## Related concepts
[[Kimsuky]] [[Spear Phishing]] [[Command and Control (C2)]] [[Persistence Mechanisms]] [[Advanced Persistent Threat (APT)]]