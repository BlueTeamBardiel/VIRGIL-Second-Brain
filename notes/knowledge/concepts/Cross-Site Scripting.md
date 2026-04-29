# cross-site scripting

## What it is
Imagine a bulletin board where anyone can post notes — and someone pins a note that says "read this, then call my phone number and repeat everything in your wallet." XSS is exactly that: an attacker injects malicious JavaScript into a trusted web page, which then executes in the victim's browser as if the site itself wrote it. The browser can't distinguish the injected script from legitimate code, so it runs it with full trust.

## Why it matters
In 2005, the Samy worm exploited a stored XSS vulnerability in MySpace, spreading to over one million profiles in under 24 hours — the fastest-spreading malware in internet history at that time. Attackers used it to steal session cookies, hijack accounts, and propagate automatically without any user action beyond viewing a page.

## Key facts
- **Three types**: Stored (persisted in the database), Reflected (bounced off the server in a response), and DOM-based (client-side script manipulates the DOM without server involvement)
- **Primary defense**: Output encoding — convert `<`, `>`, `"`, `'`, and `&` into HTML entities before rendering user-supplied input
- **Content Security Policy (CSP)** is the key HTTP header defense; it restricts which scripts the browser is permitted to execute
- **Cookie theft** via `document.cookie` is the classic payload — attacker exfiltrates the session token to hijack authenticated sessions
- **HTTPOnly cookie flag** mitigates session theft by blocking JavaScript from accessing the cookie, even when XSS occurs

## Related concepts
[[injection attacks]] [[content security policy]] [[session hijacking]]