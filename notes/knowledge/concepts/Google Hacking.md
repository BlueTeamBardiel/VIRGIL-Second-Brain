# Google Hacking

## What it is
Think of Google's index as a massive filing cabinet where a careless employee misfiled sensitive documents alongside public ones — Google Hacking is knowing exactly which drawer labels to pull. It is the technique of using advanced Google search operators (called "dorks") to discover sensitive information that is publicly indexed but never intended to be found, such as exposed credentials, misconfigured servers, or vulnerable web applications.

## Why it matters
An attacker targeting a company can use the dork `site:target.com filetype:xls "password"` to locate accidentally uploaded spreadsheets containing employee credentials — no exploitation required, just reconnaissance. This passive attack leaves no logs on the victim's systems, making it a favorite first step in OSINT-driven intrusions. Defenders use the same technique proactively to audit their own external exposure before attackers do.

## Key facts
- The **Google Hacking Database (GHDB)**, maintained by Exploit-DB, catalogs thousands of pre-built dorks organized by category (files containing passwords, vulnerable servers, exposed login portals, etc.)
- Common operators include: `site:`, `filetype:`, `intitle:`, `inurl:`, `cache:`, and `"exact phrase"` — combinations dramatically narrow results
- Google Hacking is classified as **passive reconnaissance** because it queries Google's cache, not the target directly
- The dork `intitle:"index of" passwd` is a classic example that locates directory-listed password files
- On Security+/CySA+, Google Hacking falls under **OSINT (Open Source Intelligence)** techniques within the reconnaissance phase of penetration testing and threat intelligence workflows

## Related concepts
[[OSINT]] [[Passive Reconnaissance]] [[Shodan]] [[Footprinting]] [[Information Disclosure]]