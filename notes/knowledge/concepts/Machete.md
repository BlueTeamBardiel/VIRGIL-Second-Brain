# Machete

## What it is
Like a Swiss Army knife handed to a spy who's been watching Latin American governments for years, Machete is a long-running cyberespionage toolkit purpose-built for targeted intelligence collection. It is a modular malware platform attributed to a Spanish-speaking threat actor, primarily targeting military, government, and critical infrastructure organizations across Venezuela, Ecuador, Colombia, and neighboring countries since at least 2010.

## Why it matters
In 2019, ESET researchers documented Machete campaigns actively exfiltrating gigabytes of classified military documents from Venezuelan armed forces, with the malware silently copying files to USB drives and uploading them to attacker-controlled servers. This case illustrates how long-lived APT tools can persist undetected for nearly a decade through disciplined operational security and targeted spear-phishing delivery.

## Key facts
- **Delivery method:** Spear-phishing emails with weaponized Office documents or self-extracting archives, often using geopolitical lures relevant to Latin American targets
- **Capabilities:** Keylogging, screenshot capture, clipboard theft, geolocation tracking, USB file exfiltration, and microphone recording — a full espionage suite
- **Attribution:** Linked to a Spanish-speaking threat actor (sometimes called "El Machete"); consistent with nation-state or state-sponsored activity based on targeting patterns and resources
- **Persistence:** Uses scheduled tasks and registry run keys for persistence; communicates via encrypted C2 channels to avoid detection
- **Longevity:** Active since approximately 2010 — one of the longest continuously operated APT campaigns focused specifically on Latin American targets, demonstrating that regional actors are not less sophisticated than global players

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Spear Phishing]] [[Command and Control (C2)]] [[Keylogger]] [[Lateral Movement]]