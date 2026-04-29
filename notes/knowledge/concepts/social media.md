# social media

## What it is
Think of social media as a massive, always-on bulletin board where people voluntarily pin their daily schedule, home address, employer, relationships, and opinions for anyone to read — including adversaries. Precisely defined, social media platforms are internet-based services that enable users to create, share, and interact with user-generated content, forming interconnected networks of personal and professional information. From a security standpoint, they are primary attack surfaces for reconnaissance, manipulation, and credential harvesting.

## Why it matters
In Operation Aurora and countless targeted attacks, threat actors used LinkedIn and Facebook to map out an organization's IT staff, identify sysadmins by job title, then crafted spear-phishing emails referencing real colleagues and internal project names. The attacker never touched a firewall — they just read public profiles. Defenders counter this with OSINT audits, where security teams periodically search their own organization's footprint to discover what attackers would find first.

## Key facts
- **OSINT goldmine**: Tools like Maltego, theHarvester, and Sherlock aggregate social media data to build target profiles used in reconnaissance (MITRE ATT&CK T1593.001).
- **Credential stuffing fuel**: Breached social media credentials (e.g., LinkedIn 2012: 117M accounts) are reused in attacks because users recycle passwords across work and personal accounts.
- **Pretexting enabler**: Social media provides the personal details — pet names, anniversaries, coworkers — that make vishing and phishing pretext stories believable and effective.
- **Insider threat indicator**: Unusual social media activity (e.g., employees posting frustration or job-hunting) is a recognized behavioral indicator monitored by UBA/UEBA tools.
- **Policy control**: Acceptable Use Policies (AUPs) and security awareness training are primary administrative controls for reducing social media risk; technical controls include DLP and web content filtering.

## Related concepts
[[OSINT]] [[spear phishing]] [[pretexting]] [[credential stuffing]] [[social engineering]]