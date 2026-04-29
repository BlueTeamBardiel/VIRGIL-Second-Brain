# boolean-based blind SQLi

## What it is
Like asking a locked-room suspect only yes/no questions to reconstruct a confession, boolean-based blind SQLi extracts database information one bit at a time without ever seeing direct output. The attacker injects conditions (e.g., `AND 1=1` vs `AND 1=2`) and infers data by observing whether the application returns a "true" response (normal page) or a "false" response (altered/empty page). No error messages or direct data echoes are required — just two distinguishable application states.

## Why it matters
In 2019, researchers demonstrated boolean-based blind SQLi against a major e-commerce platform where WAF rules blocked UNION-based attacks entirely. By crafting binary-search queries like `AND SUBSTRING(password,1,1)>'m'`, they reconstructed admin password hashes character by character within hours — proving that "no visible output" doesn't mean "no vulnerability." Defenders must sanitize inputs AND monitor for abnormal volumes of structurally similar requests.

## Key facts
- **Two observable states required**: attacker needs a reliable True/False distinction — page content, response length, or HTTP status code differences all work
- **Character extraction formula**: typically uses `SUBSTRING()`, `ASCII()`, and binary search logic to extract one character per ~7 requests (log₂ of 128 ASCII values)
- **Automated by SQLmap**: the `-technique=B` flag automates boolean-based extraction; defenders should watch for high-frequency, near-identical GET/POST requests
- **No UNION or error output needed**: bypasses defenses that suppress database errors or block UNION SELECT statements
- **Detection signature**: logs show repetitive queries differing only in a single conditional value — a pattern anomaly detection tools flag as exfiltration behavior

## Related concepts
[[SQL Injection]] [[Time-based Blind SQLi]] [[WAF Evasion]] [[Input Validation]] [[Error-based SQLi]]