# Sandworm

## What it is
Like a demolition crew that doesn't just rob a building but brings down the entire power grid to cover their escape, Sandworm is a Russian GRU-linked APT group (Unit 74455) that specializes in destructive cyberattacks targeting critical infrastructure rather than simple espionage. They are best known for deploying wiper malware and causing real-world physical consequences at a nation-state scale.

## Why it matters
In December 2015 and again in 2016, Sandworm executed attacks on Ukraine's power grid using BlackEnergy and Industroyer/Crashoverride malware, causing actual blackouts affecting hundreds of thousands of civilians — the first confirmed cyberattacks to physically disable power infrastructure. Defenders studying these incidents now use them as the canonical case study for ICS/SCADA threat modeling and why air-gapping industrial control systems matters.

## Key facts
- Attributed to Russia's GRU military intelligence Unit 74455; also tracked as IRIDIUM, Voodoo Bear, and TeleBots
- Responsible for NotPetya (2017), which caused an estimated $10 billion in global damages — the most destructive cyberattack in history — by masquerading as ransomware while functioning as a pure wiper
- Deployed Industroyer2 against Ukrainian high-voltage substations in April 2022, demonstrating continued targeting of OT/ICS environments
- Uses spearphishing for initial access, then leverages living-off-the-land techniques (legitimate Windows tools) to avoid detection before deploying destructive payloads
- Indicted by the U.S. DOJ in 2020 — six GRU officers charged under the Computer Fraud and Abuse Act (CFAA)

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Wiper Malware]] [[ICS/SCADA Security]] [[NotPetya]] [[Living Off the Land (LotL)]]