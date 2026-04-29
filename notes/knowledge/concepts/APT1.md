# APT1

## What it is
Think of APT1 like a professional burglary crew that doesn't smash windows — they copy your house key, move in quietly, and steal your blueprints over months. APT1 (also called "Comment Crew" or "Comment Panda") is a Chinese state-sponsored threat actor attributed to Unit 61398 of the People's Liberation Army, specializing in long-term espionage campaigns targeting intellectual property across 20+ industries.

## Why it matters
In 2013, Mandiant published a landmark report publicly attributing APT1 to the Chinese military — the first time a private firm named a nation-state actor with that level of specificity and evidence. APT1 had stolen hundreds of terabytes of data from at least 141 organizations, primarily U.S. defense contractors and technology firms, by maintaining persistent footholds for an average of **356 days** per victim.

## Key facts
- **Attribution**: Linked to PLA Unit 61398 in Shanghai; operates on China Standard Time with Chinese-language tool artifacts
- **TTPs**: Spear-phishing emails → custom malware (WEBC2, BISCUIT) → establish C2 channels using DNS and HTTP to blend with normal traffic
- **Persistence method**: Installed custom backdoors and used legitimate tools (RDP, RAR) to avoid detection — a classic "living off the land" precursor
- **Scale**: Stole data across aerospace, energy, telecom, and defense sectors; some intrusions lasted **4+ years**
- **Impact**: Forced U.S. policy changes including the 2015 Obama-Xi cyber agreement and DOJ indictments of five PLA officers

## Related concepts
[[Advanced Persistent Threat]] [[Spear Phishing]] [[Command and Control (C2)]] [[Threat Intelligence]] [[Nation-State Actors]]