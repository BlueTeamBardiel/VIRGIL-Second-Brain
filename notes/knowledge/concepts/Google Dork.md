# Google Dork

## What it is
Like a metal detector that finds buried coins others walk right over, a Google Dork uses advanced search operators to surface sensitive information that is publicly indexed but not meant to be easily found. Specifically, it is a crafted search query using operators like `site:`, `filetype:`, `intitle:`, and `inurl:` to filter Google results and expose misconfigured servers, leaked credentials, or sensitive documents.

## Why it matters
During a penetration test reconnaissance phase, an attacker runs `filetype:xls site:targetcorp.com "password"` and discovers an HR spreadsheet containing employee credentials accidentally uploaded to a public web directory — without ever touching the target's systems. This is a passive reconnaissance technique, meaning it generates no alerts or logs on the victim's infrastructure, making it particularly dangerous and difficult to detect.

## Key facts
- Google Dorking is part of **OSINT (Open Source Intelligence)** gathering and falls under passive reconnaissance in the **kill chain** and **PTES** frameworks
- The **Google Hacking Database (GHDB)**, maintained by Exploit-DB, catalogs thousands of known dork queries organized by category (passwords, sensitive files, vulnerable servers)
- Common operators: `cache:`, `intitle:`, `inurl:`, `filetype:`, `site:`, and `"exact phrase"` — combinations multiply their power
- Defenders can use **Google Search Console** to identify and remove indexed sensitive pages, and `robots.txt` to discourage crawling of restricted directories
- Dorking itself is **legal** (querying a public search engine), but *accessing* an exposed resource without authorization can violate the **Computer Fraud and Abuse Act (CFAA)**

## Related concepts
[[OSINT]] [[Passive Reconnaissance]] [[Robots.txt]] [[Shodan]] [[Attack Surface Management]]