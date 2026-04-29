# re.search

## What it is
Like a bloodhound that sniffs anywhere along a trail — not just at the starting point — `re.search` scans an entire string for the first location where a regex pattern matches. Unlike `re.match` (which only checks the beginning of a string), `re.search` will find a pattern buried anywhere in the input, returning a match object or `None`.

## Why it matters
Security tools like SIEM parsers and log analyzers use `re.search` to detect malicious patterns in raw log data — for example, hunting for SQL injection signatures (`UNION SELECT`, `OR 1=1`) anywhere within an HTTP request string. A poorly written filter that uses `re.match` instead of `re.search` might miss an injection payload buried mid-request, creating a blind spot an attacker can exploit to bypass detection.

## Key facts
- Returns the **first match object** found anywhere in the string; returns `None` if no match exists — always check for `None` before accessing group data or you'll raise an `AttributeError`
- Case-sensitive by default; use the `re.IGNORECASE` flag (`re.I`) to catch mixed-case evasion techniques like `SeLeCt` in SQL injection
- Attackers use **regex evasion** (padding, encoding, fragmentation) specifically to defeat pattern-matching defenses built on tools like `re.search`
- The match object's `.group()` method returns the actual matched string; `.span()` returns the start/end indices — critical for pinpointing where in a payload the hit occurred
- Catastrophic backtracking in poorly written regex patterns passed to `re.search` can cause **ReDoS (Regular Expression Denial of Service)**, a real CVE class affecting web frameworks and WAFs

## Related concepts
[[Regular Expressions]] [[Input Validation]] [[Log Analysis]] [[ReDoS]] [[SIEM]]