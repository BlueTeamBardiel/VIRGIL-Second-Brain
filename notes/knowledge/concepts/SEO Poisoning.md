# SEO Poisoning

## What it is
Imagine a counterfeiter paying a city's billboard company to plaster fake pharmacy signs above every real drugstore in town — customers follow the signs and end up somewhere dangerous. SEO poisoning works the same way: attackers manipulate search engine ranking algorithms to push malicious websites to the top of results for high-traffic search terms. Victims believe they're clicking a legitimate result but instead land on pages serving malware, credential harvesters, or fake software downloads.

## Why it matters
In 2022, attackers used SEO poisoning to rank malicious sites above the official downloads for tools like 7-Zip and VLC, delivering malware-laced installers to thousands of users who simply searched "download 7-Zip." Security teams countered by adding these domains to DNS sinkholes and updating endpoint detection signatures to catch the dropped payloads before execution. This attack bypasses email security controls entirely, making it particularly dangerous in organizations with strong phishing defenses.

## Key facts
- SEO poisoning exploits **keyword stuffing, backlink farming, and cloaking** — showing search engines benign content while serving malicious pages to human visitors
- It is classified under **initial access** in the MITRE ATT&CK framework (T1608.006 — Stage Capabilities: SEO Poisoning)
- Commonly weaponized during **trending news events** (e.g., tax season, major software releases) when search volume spikes predictably
- Delivered payloads frequently include **info-stealers** (Gootloader, SolarMarker) rather than ransomware directly — to establish persistent footholds first
- Defense controls include **DNS filtering, web proxies with category blocking**, and user awareness training about verifying URLs before downloading software

## Related concepts
[[Watering Hole Attack]] [[Drive-By Download]] [[Malvertising]] [[Initial Access Techniques]] [[DNS Filtering]]