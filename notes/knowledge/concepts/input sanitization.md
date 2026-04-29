# input sanitization

## What it is
Think of a nightclub bouncer who checks every ID and turns away anyone carrying weapons before they enter — input sanitization is that bouncer for your application. It is the process of inspecting, cleaning, and transforming user-supplied data to remove or neutralize characters and patterns that could be interpreted as executable code or commands. Sanitization modifies the input itself, as opposed to validation, which simply rejects it.

## Why it matters
In 2017, Equifax suffered a breach exposing 147 million records partly because unsanitized input allowed attackers to exploit Apache Struts via a crafted HTTP header containing malicious commands. Proper sanitization of that header content — stripping or encoding characters like `${` before processing — would have broken the exploit chain entirely.

## Key facts
- **Sanitization vs. Validation**: Validation checks *if* input is acceptable (reject/allow); sanitization *transforms* input to make it safe — both layers together form defense-in-depth.
- **Context matters**: Sanitizing for SQL requires escaping single quotes and semicolons; sanitizing for HTML requires encoding `<`, `>`, and `&` — the same input needs different treatment in different contexts.
- **Allowlist over blocklist**: Blocking known-bad characters (blocklist) is weaker than only permitting known-good characters (allowlist), because attackers continuously find encoding tricks to bypass blocklists.
- **Output encoding is a companion control**: Sanitizing on input AND encoding on output (e.g., HTML-encoding before rendering) provides two separate barriers against XSS.
- **Stored vs. reflected attacks**: Unsanitized input stored in a database (stored XSS) is more dangerous than reflected XSS because it persists and can attack every subsequent user who views that data.

## Related concepts
[[SQL injection]] [[cross-site scripting (XSS)]] [[input validation]] [[output encoding]] [[allowlisting]]