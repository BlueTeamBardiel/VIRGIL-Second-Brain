# Spearphishing Attachment

## What it is
Like a poisoned gift delivered to a specific person by name — the wrapping is familiar, the sender looks trusted — spearphishing attachment is a targeted phishing technique where a crafted email carries a malicious file designed for a specific individual or organization. Unlike broad phishing campaigns, the attacker researches the victim first, making the lure highly convincing and personalized.

## Why it matters
In the 2016 Democratic National Committee breach, attackers sent targeted emails with malicious attachments to specific staffers — the payload installed malware that enabled long-term network access and data exfiltration. Defenders counter this by implementing attachment sandboxing (detonating files in an isolated environment before delivery) and enforcing email filtering rules that block macro-enabled Office documents from external senders.

## Key facts
- Mapped to **MITRE ATT&CK T1566.001** — a sub-technique under Phishing, specifically the Initial Access tactic
- Common payload formats include **macro-enabled Office documents (.docm, .xlsm), PDFs, .iso files, and LNK shortcuts** — each chosen to bypass specific filters
- Attackers use **OSINT** (LinkedIn, corporate websites, social media) to craft pretexts that reference real projects, colleagues, or events the victim recognizes
- A key defense control is **disabling macros by default via Group Policy** (Microsoft's recommended baseline), which eliminates one of the most common execution vectors
- Security awareness training measurably reduces click rates — organizations with regular phishing simulations see **up to 60-70% reduction** in successful attachment opens over 12 months

## Related concepts
[[Phishing]] [[Malicious Macro]] [[Initial Access]] [[Sandboxing]] [[Social Engineering]]