# BRONZE BUTLER

## What it is
Like a patient corporate spy who infiltrates a company's mail room to intercept documents for years without being caught, BRONZE BUTLER is a long-running Chinese state-sponsored Advanced Persistent Threat (APT) group (also tracked as REDBALDKNIGHT and Tick). They specialize in stealthy, prolonged espionage campaigns targeting Japanese critical infrastructure and defense contractors.

## Why it matters
In one documented campaign, BRONZE BUTLER compromised Japanese defense and heavy industry firms by spear-phishing employees with weaponized documents that deployed custom malware (Daserf backdoor), allowing attackers to quietly exfiltrate intellectual property and sensitive defense data for months before detection. This illustrates why threat intelligence teams need behavioral analytics rather than relying solely on signature-based detection.

## Key facts
- **Attribution**: Assessed with high confidence as a Chinese nation-state threat actor, active since at least 2008, primarily targeting Japan
- **Primary targets**: Japanese critical infrastructure, defense contractors, manufacturing, and government entities — notably sectors tied to national security
- **Custom malware**: Uses proprietary tools including **Daserf** (stealthy backdoor), **DATPER**, and **xxmm** — custom tooling reduces signature-detection effectiveness
- **TTPs**: Relies heavily on spear-phishing with exploit-laden Office documents, watering hole attacks, and living-off-the-land techniques to blend into normal network traffic
- **Persistence mechanism**: Achieves long-term persistence using legitimate Windows tools and scheduled tasks, making forensic attribution harder and dwell time exceptionally long (months to years)

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Spear Phishing]] [[Living Off the Land (LotL)]] [[Threat Intelligence]] [[Command and Control (C2)]]