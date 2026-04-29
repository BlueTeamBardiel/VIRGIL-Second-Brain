# Conti

## What it is
Think of Conti like a criminal franchise with corporate HR policies — it operated as a full Ransomware-as-a-Service (RaaS) business complete with salary structures, employee reviews, and an internal help desk for victims. Precisely defined: Conti was a sophisticated Russian-linked ransomware group and malware strain active from 2020–2022, known for double extortion tactics (encrypting data *and* threatening to publish it) and targeting critical infrastructure.

## Why it matters
In May 2021, Conti attacked Ireland's Health Service Executive (HSE), encrypting systems across the entire national healthcare network and forcing hospitals to cancel thousands of appointments. The attackers initially gained access via a phishing email containing a TrickBot loader — a textbook case of how a single click cascades into a nation-level incident. The HSE eventually received a free decryption key, but recovery costs still exceeded €100 million.

## Key facts
- Conti operated as a RaaS affiliate model, paying operators a percentage (typically 70/30 split favoring affiliates) of ransom proceeds
- Used **double extortion**: exfiltrated data before encryption and published it on "Conti News" leak site if ransom was unpaid
- In 2022, an anonymous Ukrainian researcher leaked ~60,000 internal Conti chat logs ("ContiLeaks"), exposing tactics, tools, and personnel after Conti publicly backed Russia's invasion of Ukraine
- Initial access vectors included **Spearphishing**, TrickBot, BazarLoader, and exploitation of vulnerable public-facing services
- Conti officially disbanded in May 2022 but splintered into successor groups including **Black Basta**, **BlackByte**, and **Karakurt**

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[TrickBot]] [[Lateral Movement]] [[Incident Response]]