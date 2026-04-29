# Cross-Border Data Transfer

## What it is
Think of it like shipping a package internationally — the moment it crosses a border, different customs laws apply, and some destinations are outright embargoed. Cross-border data transfer is the movement of personal or sensitive data across national or jurisdictional boundaries, where the receiving country may have different (often weaker) legal protections than the originating country. Regulations govern *where* data can go, *how* it must be protected in transit, and *what agreements* must be in place before it leaves.

## Why it matters
In 2020, the EU Court of Justice invalidated the EU-US Privacy Shield framework (*Schrems II*), instantly making thousands of companies' data transfers to US cloud providers legally non-compliant overnight. Organizations relying on that framework had to scramble to implement Standard Contractual Clauses (SCCs) or face GDPR fines of up to 4% of global annual revenue. This shows that legal adequacy decisions are a *live attack surface* — geopolitical shifts can suddenly expose your data practices.

## Key facts
- **GDPR Article 46** requires appropriate safeguards (SCCs, Binding Corporate Rules, or adequacy decisions) for transfers outside the EU/EEA
- **Adequacy decisions** are formal EU rulings that a third country provides equivalent data protection (e.g., Japan, UK post-Brexit); the US uses the **EU-US Data Privacy Framework** (2023 replacement for Privacy Shield)
- **Standard Contractual Clauses (SCCs)** are pre-approved legal contracts between data exporter and importer that satisfy GDPR transfer requirements
- **CLOUD Act (US)** allows US law enforcement to compel US companies to produce data stored abroad — creating a direct conflict with GDPR obligations
- Data sovereignty laws (e.g., China's PIPL, Russia's Federal Law 242-FZ) may *require* data to remain on domestic servers, blocking lawful outbound transfers

## Related concepts
[[GDPR Compliance]] [[Data Sovereignty]] [[Privacy Shield Framework]] [[Standard Contractual Clauses]] [[Data Classification]]