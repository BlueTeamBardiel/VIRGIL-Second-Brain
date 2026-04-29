# Tropic Trooper

## What it is
Like a persistent street vendor who memorizes every shopkeeper's schedule and finds new alleyways each time they're kicked out, Tropic Trooper is a long-running Advanced Persistent Threat (APT) group that continuously adapts its intrusion methods to maintain access. Also tracked as KeyBoy and Earth Centaur, this Chinese-speaking threat actor has operated since at least 2011, targeting government, military, healthcare, and transportation sectors primarily in Taiwan, Hong Kong, and the Philippines.

## Why it matters
In 2021, researchers discovered Tropic Trooper deploying a variant of their custom USBferry malware to target air-gapped military networks in Taiwan and the Philippines by using infected USB drives as a bridging mechanism — demonstrating how nation-state actors specifically engineer solutions to bypass network isolation. Defenders monitoring these environments learned to treat removable media as a high-priority attack vector requiring strict device control policies and USB activity logging.

## Key facts
- **USBferry** is their signature malware, designed specifically to exfiltrate data from air-gapped networks by propagating via USB and staging stolen data for later retrieval
- Tropic Trooper uses **living-off-the-land (LotL) techniques**, abusing legitimate Windows tools like BITSAdmin and PowerShell to evade endpoint detection
- The group employs **spear-phishing with weaponized documents** (often exploiting older Microsoft Office vulnerabilities like CVE-2012-0158) as the primary initial access vector
- They maintain **long-term persistence** using custom backdoors (e.g., YAHOYAH, TClient) that blend C2 traffic with legitimate-looking HTTP/HTTPS communications
- Classified as **APT23** in some threat intelligence frameworks and attributed to suspected Chinese state sponsorship based on targeting patterns and tooling overlap

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Air-Gap Attack]] [[Spear Phishing]] [[Living off the Land (LotL)]] [[USB-Based Malware]]