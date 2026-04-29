# directory brute-forcing

## What it is
Like a locksmith trying every key on a giant ring against a single door, directory brute-forcing systematically requests common filenames and folder paths against a web server to discover hidden or unlisted resources. It is an enumeration technique where automated tools cycle through wordlists of probable paths (e.g., `/admin`, `/backup`, `/config.php`) and interpret HTTP response codes to identify what actually exists on the server.

## Why it matters
During the 2012 Zappos breach investigation, responders found attackers had located an exposed administrative panel through directory enumeration that was never linked from the public site but remained fully accessible. This is the classic failure mode: developers assume "security through obscurity" means an unlisted path is a hidden path, but brute-forcing collapses that assumption in minutes.

## Key facts
- **Common tools**: Gobuster, DirBuster, ffuf, and dirsearch are the standard instruments; each uses wordlists like SecLists' `directory-medium.txt` (≈220,000 entries)
- **Response code interpretation**: 200 = found, 301/302 = redirect (still interesting), 403 = exists but forbidden, 404 = not found — attackers treat 403 as a confirmed target worth probing further
- **Wordlist quality determines success**: A targeted wordlist for WordPress (`wp-admin`, `wp-content`) outperforms a generic list against WordPress sites
- **Defense**: Web Application Firewalls (WAFs) can rate-limit or block sequential enumeration patterns; returning 404 for *all* unauthorized paths (including existing-but-forbidden ones) removes the 403 signal attackers rely on
- **Exam relevance**: Classified under **active reconnaissance** on Security+/CySA+; constitutes unauthorized access if performed without permission regardless of what is discovered

## Related concepts
[[web application enumeration]] [[HTTP response codes]] [[robots.txt exposure]] [[forced browsing]] [[reconnaissance]]