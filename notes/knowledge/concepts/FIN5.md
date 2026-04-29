# FIN5

## What it is
Think of FIN5 like a crew of professional casino heist specialists — they don't spray-and-pray, they case the joint meticulously before touching a single chip. FIN5 is a financially motivated threat actor group first identified around 2013, known for highly targeted attacks against payment card processors, hospitality, and retail sectors. Unlike opportunistic cybercriminals, they conduct extensive reconnaissance and use legitimate administrative tools to blend into normal network traffic.

## Why it matters
FIN5 pioneered the use of tools like FLIPSIDE and PUNCHTRACK — custom malware designed specifically to scrape payment card data from point-of-sale (POS) memory processes. In documented breaches against casino and hotel chains, they maintained persistent access for months by leveraging valid remote access credentials (often stolen VPN credentials), making detection extraordinarily difficult for defenders relying on perimeter-based controls.

## Key facts
- **Active since ~2013**, primarily targeting POS environments in hospitality, retail, and gaming industries across North America
- **Favors "living off the land"** techniques — heavy use of legitimate tools like RDP, WMIC, and Windows Task Scheduler to avoid triggering AV signatures
- **Custom toolset includes** FLIPSIDE (creates backdoor access), PUNCHTRACK (POS RAM scraper harvesting Track 1/Track 2 card data), and DRIFTPIN
- **Initial access vector** commonly involves stolen remote access credentials and VPN abuse rather than phishing — making user behavior analytics (UBA) critical for detection
- **Attribution confidence** is moderate; FireEye/Mandiant research linked the group to Eastern European operators based on TTPs and operational timing patterns

## Related concepts
[[Point-of-Sale Malware]] [[RAM Scraping]] [[Living off the Land (LotL)]] [[Threat Actor Attribution]] [[Lateral Movement]]