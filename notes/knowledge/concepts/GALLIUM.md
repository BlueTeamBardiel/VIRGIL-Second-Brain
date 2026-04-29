# GALLIUM

## What it is
Like a master locksmith who works for whoever pays most, switching allegiance between criminal gangs and government contracts, GALLIUM is a Chinese state-sponsored threat actor (APT) that pivots fluidly between espionage targets across multiple sectors. Tracked by Microsoft and attributed to Chinese intelligence operations, GALLIUM is known for targeting telecommunications providers, financial institutions, and government entities primarily across Southeast Asia, Europe, and Africa.

## Why it matters
GALLIUM gained notoriety for exploiting unpatched internet-facing services — particularly WCF and IIS vulnerabilities — to establish footholds in telecom networks, then deploying the custom malware framework **PoisonIvy** and later **SoftCell** to intercept call records and identify high-value surveillance targets. This "hack the telco, surveil the person" approach means compromising one carrier can expose the communications metadata of thousands of individuals, including diplomats and dissidents, without ever touching their devices directly.

## Key facts
- GALLIUM is classified as a **Chinese APT** group, tracked by Microsoft Threat Intelligence; overlaps with groups Mandiant calls **APT41** in TTPs
- Signature tool is **PoisonIvy RAT** alongside custom backdoors; later campaigns used **Quarian** and **SoftCell** malware targeting Active Directory
- Primary initial access vector: **exploitation of public-facing applications** (T1190 in MITRE ATT&CK), especially legacy telecom infrastructure
- Targets **telecommunications providers** specifically to harvest **CDRs (Call Detail Records)** — a classic signals-intelligence collection technique
- Observed using **living-off-the-land** techniques (PsExec, Mimikatz, nbtscan) to blend with legitimate admin activity post-compromise

## Related concepts
[[APT41]] [[PoisonIvy RAT]] [[Living off the Land (LotL)]] [[Call Detail Records (CDR)]] [[MITRE ATT&CK T1190]]