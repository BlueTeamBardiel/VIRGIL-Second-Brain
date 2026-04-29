# Operation Wocao

## What it is
Like a burglar who steals a master key from a locksmith, then uses it to quietly enter dozens of buildings over months — Operation Wocao was a Chinese state-sponsored espionage campaign that leveraged stolen hacking tools and legitimate credentials to silently infiltrate organizations across ten countries. Discovered and named by Fox-IT in 2019, it targeted high-value sectors including government, oil & gas, technology, and healthcare.

## Why it matters
During this operation, attackers used a custom implant called "Hysbreck" alongside publicly available tools like Mimikatz to harvest credentials and maintain persistent access — often blending into normal network traffic for months undetected. This illustrates why behavioral analytics and privileged access monitoring matter more than signature-based detection alone: the attackers looked like legitimate administrators.

## Key facts
- Named "Wocao" (我操, a Chinese expletive) after a string found in the malware code
- Attributed to a Chinese threat actor overlapping with APT20 activity
- Attackers specifically targeted and bypassed RSA SecurID two-factor authentication by patching the software token on compromised hosts
- Used webshells for initial persistence, then pivoted laterally using stolen VPN credentials and RDP
- Operated across at least 10 countries, hitting government agencies, managed service providers (MSPs), and energy companies
- Fox-IT published technical indicators in December 2019, enabling defenders to hunt for the campaign retroactively

## Related concepts
[[APT20]] [[Living off the Land Attacks]] [[Credential Harvesting]] [[Lateral Movement]] [[Webshell]]