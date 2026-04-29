# RaaS

## What it is
Think of it like a McDonald's franchise model — instead of building a burger chain from scratch, you license the brand and infrastructure, then split the profits. Ransomware-as-a-Service (RaaS) works identically: criminal developers build and maintain ransomware toolkits, then lease them to "affiliates" who handle the actual attacks, splitting ransom payments typically 70/30 or 80/20 in the affiliate's favor.

## Why it matters
In 2021, the Colonial Pipeline attack was executed by a DarkSide RaaS affiliate — not DarkSide's core developers themselves. This distinction matters defensively: disrupting the RaaS platform (as happened when DarkSide shut down after the attack drew FBI scrutiny) can simultaneously neutralize dozens of active attack campaigns run by different affiliates sharing that infrastructure.

## Key facts
- RaaS platforms often include professional support portals, victim negotiation services, and even SLAs — mirroring legitimate SaaS business operations
- Affiliates typically receive 70-80% of ransom payments; the RaaS operators take the remainder as a licensing/platform fee
- Major RaaS groups include LockBit, BlackCat (ALPHV), Hive, and the now-defunct REvil and DarkSide
- RaaS lowers the technical barrier to entry — affiliates need social engineering or access-broker skills, not malware development expertise
- Double extortion is the current RaaS standard: encrypt files AND exfiltrate data, threatening public release to increase payment pressure

## Related concepts
[[Ransomware]] [[Malware-as-a-Service]] [[Double Extortion]] [[Threat Actor]] [[Initial Access Broker]]