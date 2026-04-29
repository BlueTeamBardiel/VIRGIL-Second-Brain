# RegexMatching

## What it is
Like a metal detector at an airport that beeps only when specific patterns of metal are present, regex (regular expression) matching scans text for sequences that fit a defined structural pattern. It is a method of searching, validating, or filtering strings using a formal pattern language made of special characters, wildcards, and quantifiers. Security tools use regex to identify malicious strings, extract indicators, or enforce input validation rules.

## Why it matters
Poorly written regex in a web application input validator can be bypassed by attackers to inject malicious payloads — for example, a regex checking for SQL injection that only looks for `SELECT` in uppercase will miss `SeLeCt`. Conversely, overly complex or "catastrophic backtracking" regex patterns can be weaponized in a **ReDoS (Regular Expression Denial of Service)** attack, where a crafted input causes exponential processing time and crashes the service.

## Key facts
- **ReDoS** is a real DoS attack class — nested quantifiers like `(a+)+` against a long non-matching string can cause exponential backtracking and exhaust CPU
- SIEM tools (Splunk, Elastic) rely heavily on regex for log parsing and alert rules — a misconfigured pattern means missed detections
- Input validation using regex should be **allowlist-based** (match only known-good patterns) rather than denylist-based (block known-bad) to reduce bypass risk
- Anchors (`^` and `$`) are critical for security regex — omitting them allows partial matches, enabling injection bypasses
- Common IDS/IPS signature engines (Snort, Suricata) use PCRE (Perl Compatible Regular Expressions) for payload pattern matching in rules

## Related concepts
[[InputValidation]] [[ReDoS]] [[IntrusionDetectionSystem]] [[LogAnalysis]] [[SQLInjection]]