# XSS

## What it is
Imagine a bulletin board where anyone can post notes — and someone pins a note that says "read this!" but when you touch it, it pickpockets your wallet. Cross-Site Scripting (XSS) works the same way: an attacker injects malicious JavaScript into a trusted website, and that script executes in the victim's browser with the full trust of that site's origin.

## Why it matters
In 2005, the Samy worm exploited a stored XSS vulnerability in MySpace, spreading to over one million profiles in under 24 hours — at the time, the fastest-spreading malware in history. The injected script silently added Samy as a friend and copied itself to each victim's profile, demonstrating how XSS can achieve worm-like propagation without any server compromise.

## Key facts
- **Three types**: Stored (persisted in database), Reflected (bounced off server in response), and DOM-based (entirely client-side, never touches server)
- **Primary payload**: Stealing session cookies via `document.cookie`, enabling session hijacking without knowing the user's password
- **Root cause**: Failure to encode user-supplied output before rendering it as HTML — input validation alone is insufficient
- **Primary defense**: Output encoding (e.g., HTML entity encoding `<` as `&lt;`) and Content Security Policy (CSP) headers that whitelist trusted script sources
- **HTTPOnly cookie flag** prevents JavaScript from reading session cookies, neutralizing the most common XSS exploit goal even when XSS exists

## Related concepts
[[Content Security Policy]] [[Session Hijacking]] [[Input Validation]] [[CSRF]] [[Injection Attacks]]