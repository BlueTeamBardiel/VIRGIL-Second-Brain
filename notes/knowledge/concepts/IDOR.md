# IDOR

## What it is
Imagine a hotel where room keys are just numbered stickers — if you have key #204, you simply peel off the sticker and write #205 to walk into someone else's room. Insecure Direct Object Reference (IDOR) is an access control vulnerability where an application exposes internal object identifiers (database IDs, filenames, account numbers) in URLs or parameters without verifying the requesting user actually has permission to access that object. It is classified under the OWASP Broken Access Control category.

## Why it matters
In 2021, a researcher discovered an IDOR in a major healthcare portal: changing a numeric patient ID in the URL from `?patient_id=10042` to `?patient_id=10043` exposed another patient's full medical records — no authentication bypass required, just incrementing an integer. This class of vulnerability is responsible for significant data breaches because it requires no special tooling, only curiosity and a browser.

## Key facts
- IDOR falls under **Broken Access Control**, the #1 vulnerability category in the OWASP Top 10 (2021)
- The root cause is missing **server-side authorization checks**, not client-side validation failures
- Common attack surfaces: URL parameters (`?id=`), API endpoints (`/api/users/1337`), hidden form fields, and file paths
- Detection method: use two separate authenticated accounts and test whether Account A can access Account B's resources by swapping identifiers
- Mitigation requires **indirect reference maps** (random UUIDs instead of sequential integers) AND server-side authorization checks — obscurity alone is insufficient

## Related concepts
[[Broken Access Control]] [[Privilege Escalation]] [[API Security]] [[Authorization vs Authentication]] [[Mass Assignment]]