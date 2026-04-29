# APT37

## What it is
Think of APT37 as a state-sponsored locksmith hired exclusively to break into specific buildings — not for profit, but for political intelligence. APT37 (also known as Reaper, ScarCruft, or Group123) is a North Korean advanced persistent threat group attributed to the Reconnaissance General Bureau, primarily targeting South Korean government agencies, journalists, and defectors for espionage purposes.

## Why it matters
In 2017, APT37 deployed the ROKRAT cloud-based RAT through malicious Hangul Word Processor (HWP) documents — a clever choice since HWP is ubiquitous in South Korea but largely unknown outside it, making detection harder for Western security tools. Defenders responding to this campaign had to pivot quickly from standard Office macro analysis to understanding HWP exploit chains, illustrating how APT actors exploit region-specific software blind spots.

## Key facts
- **Attribution**: Linked to North Korea's Reconnaissance General Bureau (RGB); active since at least 2012
- **Primary targets**: South Korean entities — government, military, media, human rights organizations, and defectors
- **Signature tools**: ROKRAT (cloud-based RAT using Dropbox/Google Drive/pCloud for C2), DOGCALL, and POORWEB malware families
- **Initial access method**: Spear-phishing with weaponized HWP files exploiting CVE-2018-0802 and zero-days in Adobe Flash
- **Expanding scope**: Has targeted Japan, Vietnam, the Middle East, and Europe, signaling broader intelligence collection mandates beyond the Korean peninsula

## Related concepts
[[Advanced Persistent Threat]] [[Spear Phishing]] [[Command and Control (C2)]] [[Remote Access Trojan]] [[Nation-State Actors]]