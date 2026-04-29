# WhatCMS

## What it is
Like reading the brand name off a storefront sign before you even walk in, WhatCMS lets you identify what content management system powers a website before touching a single line of code. It is a web-based fingerprinting tool and API service that detects CMS platforms (WordPress, Joomla, Drupal, etc.) by analyzing HTTP headers, HTML source patterns, file paths, and cookies. It essentially performs passive reconnaissance against a target's web stack.

## Why it matters
During the reconnaissance phase of a penetration test, an attacker who identifies that a site runs WordPress 5.8 can immediately pivot to known CVEs for that version rather than performing broad, noisy vulnerability scanning. Defenders use the same intelligence to audit their own external attack surface — if WhatCMS reveals an outdated Joomla instance the team forgot existed, that's a patch priority before an adversary finds it first.

## Key facts
- WhatCMS checks over 400 CMS signatures, including niche platforms rarely detected by general scanners
- It operates via a REST API, making it easy to integrate into automated OSINT pipelines and red team toolchains
- Detection relies on **passive indicators**: meta generator tags, `/wp-content/` path structures, specific cookie names, and HTTP response headers
- Because it queries a target from WhatCMS's own infrastructure, the reconnaissance activity may not appear in the target's web server logs under the attacker's IP — a form of proxy-based OSINT
- CMS identification is a critical sub-step of the OSINT/reconnaissance phase mapped to **MITRE ATT&CK T1592** (Gather Victim Host Information)

## Related concepts
[[CMS Fingerprinting]] [[Passive Reconnaissance]] [[OSINT]] [[MITRE ATT&CK]] [[Web Application Enumeration]]