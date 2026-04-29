# Darkhotel

## What it is
Imagine a pickpocket who only works five-star hotels — waiting in the lobby for wealthy guests to arrive before striking. Darkhotel is a sophisticated APT (Advanced Persistent Threat) group, active since at least 2007, that specifically targets business executives staying at luxury hotels by compromising the hotel's Wi-Fi or wired networks to deliver targeted malware.

## Why it matters
In documented attacks, Darkhotel operators would wait for a specific executive to check in, then push a fake software update (e.g., Adobe Flash or Windows) through the hotel network directly to that guest's room. The precision of targeting — attacking *named individuals* hours after check-in — demonstrates how physical location data can be weaponized to time and focus a cyberattack.

## Key facts
- **Attack vector:** Hotel Wi-Fi/wired networks used to intercept sessions and serve trojanized software updates to pre-identified targets
- **Targeting method:** Group cross-referenced hotel reservation systems to identify high-value guests (C-suite executives, government officials) before deploying payloads
- **Toolset:** Used spear-phishing emails, zero-day exploits, and keyloggers; malware included "Darkhotel RAT" for persistent access and credential harvesting
- **Attribution:** Linked to South Korean threat actors based on code artifacts and victim profile patterns; primarily targeted victims traveling in Asia-Pacific regions
- **Operational security risk:** Demonstrates that trusted networks (hotel infrastructure) cannot be assumed safe — reinforces the need for VPN use on all untrusted networks

## Related concepts
[[Advanced Persistent Threat]] [[Spear Phishing]] [[Man-in-the-Middle Attack]] [[Remote Access Trojan]] [[VPN]]