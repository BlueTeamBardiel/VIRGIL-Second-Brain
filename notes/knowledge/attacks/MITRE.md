# MITRE

## What it is
Think of MITRE as the Smithsonian Institution of cybersecurity — a federally funded nonprofit that catalogs, preserves, and organizes the world's knowledge about attacks and defenses. Precisely, MITRE Corporation is a US government-sponsored research organization that develops and maintains critical cybersecurity frameworks, most notably ATT&CK, CVE, and CAR, used globally by defenders and red teams alike.

## Why it matters
During the 2020 SolarWinds supply chain attack, incident responders used the MITRE ATT&CK framework to map adversary behavior — identifying techniques like T1195 (Supply Chain Compromise) and T1078 (Valid Accounts) — giving analysts a shared language to coordinate detection and response across dozens of affected agencies. Without this common taxonomy, each team would have described the same attacker behaviors using completely different terminology, slowing containment dramatically.

## Key facts
- **MITRE ATT&CK** (Adversarial Tactics, Techniques & Common Knowledge) organizes adversary behavior into 14 tactics (columns) with hundreds of sub-techniques, covering Enterprise, Mobile, and ICS environments
- **CVE** (Common Vulnerabilities and Exposures) is maintained by MITRE and assigns standardized IDs (e.g., CVE-2021-44228 for Log4Shell) to publicly known vulnerabilities
- **MITRE D3FEND** is the defensive counterpart to ATT&CK, mapping defensive techniques against offensive ones — newer and less tested but appearing in CySA+ objectives
- **CAR** (Cyber Analytics Repository) provides analytics — specific detection rules and pseudocode — tied directly to ATT&CK techniques
- MITRE ATT&CK is **not a compliance framework** — it is a knowledge base used for threat modeling, purple teaming, and SOC detection coverage gap analysis

## Related concepts
[[MITRE ATT&CK]] [[CVE]] [[Threat Intelligence]] [[Purple Teaming]] [[NIST Cybersecurity Framework]]