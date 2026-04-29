# Internal Defacement

## What it is
Like a disgruntled employee replacing the company cafeteria menu with an offensive flyer — but on internal systems — internal defacement is the unauthorized modification of internal-facing web pages, intranet portals, or internal applications. Unlike public defacement, the target audience is employees or internal systems rather than the general public.

## Why it matters
In a 2020-era insider threat scenario, a terminated employee retaining Active Directory credentials could alter the corporate intranet homepage to display threatening messages or disinformation to staff — sowing confusion and undermining trust before the account is disabled. Defenders must monitor internal web servers with the same integrity-checking rigor applied to public-facing assets, since internal defacement often signals deeper compromise or escalating insider activity.

## Key facts
- Internal defacement is classified as an **integrity attack** — it violates the "I" in the CIA triad by corrupting authorized content.
- It can serve as a **distraction technique**: attackers deface internal pages to divert security teams while exfiltrating data elsewhere.
- Common vectors include **compromised CMS credentials**, misconfigured write permissions on intranet shares, and exploited web application vulnerabilities on internal servers.
- File integrity monitoring (FIM) tools like Tripwire can detect unauthorized changes to internal web content by hashing files and alerting on delta changes.
- On Security+/CySA+ exams, internal defacement is often paired with **insider threat** scenarios and used to test understanding of **least privilege** and **access control** countermeasures.

## Related concepts
[[Insider Threat]] [[File Integrity Monitoring]] [[Intranet Security]] [[Privilege Escalation]] [[Indicators of Compromise]]