# List Category Posts

## What it is
Like a library card catalog that reveals every book in the "Mystery" section without needing to browse the shelves, List Category Posts is a web application feature that enumerates and displays all content items grouped by a specific tag or category. It is a content retrieval function — typically exposed via URLs like `/category/admin` or `?cat=5` — that aggregates and presents grouped records from a backend database.

## Why it matters
Attackers probe category listing endpoints to perform information gathering and content enumeration — discovering hidden posts, draft articles, internal memos, or unpublished pages that administrators forgot to restrict. A misconfigured WordPress site, for example, may expose `/category/internal` revealing draft posts containing server credentials or network diagrams never intended for public consumption, directly feeding a reconnaissance phase before a targeted attack.

## Key facts
- Category listing endpoints are a common **IDOR (Insecure Direct Object Reference)** attack surface — changing a numeric category ID (e.g., `?cat=3` → `?cat=99`) may expose unauthorized content
- Unauthenticated category enumeration violates the **need-to-know** principle and can constitute a CWE-200 (Exposure of Sensitive Information to an Unauthorized Actor) vulnerability
- Web crawlers and automated scanners (Burp Suite, Nikto) routinely spider category URLs to build full site content maps during reconnaissance
- Proper mitigation includes **access controls at the object level**, not just at the page level — authentication must be enforced on the data query, not just the UI
- In CMS platforms like WordPress, the `?cat=` parameter is a well-known enumeration vector documented in OWASP's Testing Guide under **OTG-INFO-005 (Review Webpage Content for Information Leakage)**

## Related concepts
[[Insecure Direct Object Reference]] [[Information Disclosure]] [[Content Discovery and Enumeration]]