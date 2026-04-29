# Google Dorking

## What it is
Think of Google as an enormous filing clerk who has accidentally indexed confidential memos along with the public ones — Google Dorking is knowing exactly how to ask that clerk for the sensitive stuff. It is the practice of using advanced Google search operators (such as `filetype:`, `inurl:`, `intitle:`, and `site:`) to surface sensitive information that is publicly accessible but not intentionally advertised.

## Why it matters
A penetration tester reconnaissance phase might use `filetype:xls site:targetcorp.com` to find exposed spreadsheets containing employee credentials or financial data — information the organization never meant to be indexed. Attackers routinely run automated dork queries against entire industry sectors to harvest login portals, misconfigured admin panels, and exposed `.env` files before ever touching a target system directly.

## Key facts
- **Not hacking the search engine** — it exploits misconfigurations or accidental exposure in the *target*, not Google itself
- Common operators: `site:`, `inurl:`, `intitle:`, `filetype:`, `cache:`, and `"exact phrase"` — combinable for precision targeting
- The **Google Hacking Database (GHDB)** at Exploit-DB catalogs thousands of pre-built dork queries organized by vulnerability category
- Relevant to **OSINT (Open Source Intelligence)** gathering and appears in the Reconnaissance phase of the MITRE ATT&CK framework (Technique T1596)
- Defenders counter it with **robots.txt** exclusions, proper authentication gates, and periodic self-dorking audits to identify unintended exposures
- Viewing publicly indexed results is generally **legal**, but using discovered data to access systems without authorization is not

## Related concepts
[[OSINT]] [[Reconnaissance]] [[Attack Surface Management]]