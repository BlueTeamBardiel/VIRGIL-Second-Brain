# Browser

## What it is
Like a universal translator that speaks every web language (HTML, CSS, JavaScript) and renders it into something humans can see and click, a browser is a client-side application that fetches, interprets, and displays web content while managing sessions, cookies, and local storage. It is simultaneously the most-used software on most devices and one of the largest attack surfaces in existence.

## Why it matters
In a drive-by download attack, a user visits a compromised website and the browser silently executes malicious JavaScript that exploits an unpatched rendering engine vulnerability — no user interaction beyond the page load is required. This is why organizations enforce browser patching policies and deploy content security policies (CSP) to restrict what scripts can execute.

## Key facts
- **Same-Origin Policy (SOP)** is the browser's core security boundary — scripts from `evil.com` cannot read responses from `bank.com` without explicit CORS headers permitting it.
- **Cookies** can be flagged `HttpOnly` (blocks JavaScript access) and `Secure` (HTTPS-only transmission) — missing these flags are common exam findings in web assessments.
- **Browser sandboxing** isolates tab processes from the OS; a renderer exploit alone is insufficient — attackers need a sandbox escape for full system compromise.
- **HSTS (HTTP Strict Transport Security)** instructs browsers to refuse plaintext HTTP connections to a domain, preventing SSL stripping attacks.
- **Cross-Site Scripting (XSS)** exploits the browser's trust in server-delivered content; stored XSS persists in a database and attacks every subsequent visitor automatically.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Same-Origin Policy]] [[Cross-Site Request Forgery (CSRF)]] [[Content Security Policy]] [[HTTP Cookies]]