# WhatWeb

## What it is
Like a sommelier identifying a wine's vineyard, grape, and vintage from a single sip, WhatWeb identifies a website's underlying technology stack from a single HTTP response. It is an open-source web reconnaissance tool that fingerprints web technologies including CMS platforms (WordPress, Joomla), web frameworks, server software, JavaScript libraries, and analytics tools by analyzing headers, cookies, HTML patterns, and scripts.

## Why it matters
During a penetration test pre-engagement phase, an attacker runs WhatWeb against a target and discovers the site runs WordPress 5.4.2 with an outdated plugin — immediately narrowing the attack surface to known CVEs before touching the application directly. Defenders use the same output to audit their own exposure, ensuring that version numbers and technology signatures aren't being leaked to casual reconnaissance.

## Key facts
- WhatWeb uses **plugins** (1,800+) to match signatures; each plugin targets a specific technology or vendor fingerprint
- Operates in **stealth to aggressive modes** — stealth sends one request per target; aggressive sends many follow-up requests for deeper fingerprinting, increasing detection risk
- Outputs results in multiple formats: **JSON, XML, CSV, and human-readable** — useful for piping into automated reporting pipelines
- Commonly used in the **reconnaissance phase** of the PTES (Penetration Testing Execution Standard) and maps to MITRE ATT&CK **T1592** (Gather Victim Host Information)
- Can be combined with **masscan or Nmap** output to perform bulk fingerprinting across large IP ranges, making it effective for large-scale attack surface mapping

## Related concepts
[[Web Application Fingerprinting]] [[Passive Reconnaissance]] [[Banner Grabbing]] [[OSINT]] [[Nmap]]