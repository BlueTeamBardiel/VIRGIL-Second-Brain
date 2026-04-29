# ZIRCONIUM

## What it is
Like a ghost that speaks fluent corporate — blending into normal business traffic while stealing everything — ZIRCONIUM is a Chinese state-sponsored Advanced Persistent Threat (APT) group, also tracked as APT31, linked to China's Ministry of State Security. They specialize in long-term espionage campaigns targeting governments, political figures, and high-value organizations using sophisticated, low-and-slow intrusion techniques.

## Why it matters
During the 2020 U.S. presidential election cycle, ZIRCONIUM conducted spear-phishing campaigns against campaign staffers and foreign policy officials, deploying web bugs (tracking pixels) embedded in emails to fingerprint targets before launching deeper attacks. This allowed them to confirm active email addresses, gather IP addresses, and map out victim infrastructure — all before a single malicious attachment was opened. It demonstrates how reconnaissance can be weaponized passively, leaving almost no traditional IOCs.

## Key facts
- **Also known as APT31**, officially attributed to China's Hubei State Security Department by the U.S. DOJ in 2024 indictments
- **Web bug technique**: Embedded 0x0 pixel images in emails to silently collect IP addresses, device info, and email open times without any user interaction
- **Common TTPs**: Spear-phishing, watering hole attacks, credential harvesting via fake login portals, and abuse of legitimate cloud services (GitHub, Dropbox) for C2
- **Target profile**: Political dissidents, journalists, defense contractors, and government officials — classic intelligence-gathering objectives
- **Persistence mechanism**: Frequently uses scheduled tasks and registry run keys to maintain footholds on compromised Windows systems

## Related concepts
[[APT (Advanced Persistent Threat)]] [[Spear Phishing]] [[Web Bug]] [[Command and Control (C2)]] [[Threat Attribution]]