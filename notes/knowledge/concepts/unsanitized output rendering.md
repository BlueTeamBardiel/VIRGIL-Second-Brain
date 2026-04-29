# unsanitized output rendering

## What it is
Like a printing press that stamps whatever text you feed it without checking if the words are commands instead of content, unsanitized output rendering occurs when an application takes data from an untrusted source and displays it directly to a user without encoding or escaping potentially dangerous characters. The application treats attacker-controlled input as trusted, executable content rather than inert text.

## Why it matters
The 2005 Samy worm on MySpace exploited unsanitized output rendering to inject JavaScript into profile pages; when any user viewed an infected profile, the script executed automatically, propagating the worm to over one million accounts in under 24 hours. Properly encoding `<` as `&lt;` before rendering would have neutralized the payload entirely, turning the script into visible text the browser would never execute.

## Key facts
- **XSS (Cross-Site Scripting)** is the primary attack class enabled by unsanitized output rendering; stored XSS persists in a database while reflected XSS bounces off a server response.
- Output encoding must be **context-specific**: HTML body encoding differs from JavaScript context, URL encoding, and CSS encoding — using the wrong encoder still leaves vulnerabilities.
- **Content Security Policy (CSP)** acts as a defensive second layer, restricting which scripts the browser will execute even if malicious markup renders.
- The fix is **output encoding at render time**, not just input validation on arrival — data can enter cleanly and become dangerous only when injected into a specific context.
- OWASP lists injection (which includes unsanitized rendering) as one of the **Top 10 Web Application Security Risks**, making it high-priority for CySA+ threat analysis scenarios.

## Related concepts
[[cross-site scripting (XSS)]] [[input validation]] [[content security policy]] [[injection attacks]] [[HTML encoding]]