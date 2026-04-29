# output encoding

## What it is
Like a diplomat who translates your blunt demands into polite protocol before they reach foreign ears, output encoding transforms data into a safe format appropriate for its destination context before rendering it. Precisely: output encoding converts potentially dangerous characters (like `<`, `>`, `&`, `"`) into their harmless representation (e.g., `&lt;`, `&gt;`) so a browser or interpreter treats them as literal text rather than executable code. It is a *context-aware* defense applied at the point of output, not input.

## Why it matters
Without output encoding, an attacker who stored `<script>document.cookie</script>` in a user profile field can execute JavaScript in every victim's browser that views that profile — a stored XSS attack. Proper HTML encoding converts that payload to `&lt;script&gt;`, which renders visibly on screen as text and never executes. This is why OWASP lists output encoding as the *primary* defense against Cross-Site Scripting, not input validation alone.

## Key facts
- **Context determines encoding scheme**: HTML body → HTML entity encoding; URL parameters → percent-encoding; JavaScript strings → Unicode/hex escaping. Wrong context = broken defense.
- Output encoding differs from **input validation**: validation rejects bad input *on the way in*; encoding neutralizes data *on the way out*. Both layers are needed.
- **Stored XSS bypasses** often succeed specifically because encoding was applied at input storage but not at render time — the safe moment is always output.
- OWASP's **ESAPI (Enterprise Security API)** provides context-aware encoding libraries to avoid manual, error-prone implementations.
- Output encoding does **not** protect against SQL injection — that requires parameterized queries/prepared statements, a separate control.

## Related concepts
[[cross-site scripting (XSS)]] [[input validation]] [[injection attacks]] [[Content Security Policy]] [[OWASP Top 10]]