# feroxbuster

## What it is
Like a postal worker who tries every address on a street to see which doors actually open, feroxbuster is a fast, recursive web content discovery tool written in Rust. It brute-forces URLs against a running web server using wordlists to enumerate hidden files, directories, and endpoints that aren't linked from any visible page.

## Why it matters
During a penetration test, an assessor points feroxbuster at a client's web application and discovers an unlinked `/admin/backup/db_dump.sql` endpoint returning HTTP 200 — a database backup exposed to anyone who knows to ask. This exact scenario represents a broken access control finding (OWASP A01), where security through obscurity was the only protection for a critical asset.

## Key facts
- Feroxbuster performs **recursive directory busting by default**, meaning it automatically dives into every discovered directory and re-runs enumeration — dramatically expanding attack surface coverage compared to tools like dirb or gobuster.
- It is written in **Rust**, giving it high concurrency and speed; it can handle hundreds of simultaneous requests with low resource overhead.
- Uses **wordlists** (commonly SecLists) to generate candidate paths; response filtering by HTTP status code (200, 301, 403) separates hits from misses.
- A **403 Forbidden** response still reveals directory existence — useful intel even without direct access, and a finding in its own right if sensitive paths are confirmed.
- Detected on the defensive side via **anomalous HTTP request volume** from a single IP, sequential path requests matching known wordlists, and WAF or IDS signatures tuned to directory-brute-force patterns.

## Related concepts
[[Directory Traversal]] [[Web Application Enumeration]] [[Broken Access Control]] [[Gobuster]] [[SecLists]]