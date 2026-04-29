# Confused Deputy Attack

## What it is
Imagine a notary public who stamps any document you hand them — you can't stamp it yourself, but you can *trick the notary* into stamping a fraudulent contract on your behalf. A confused deputy attack occurs when a privileged program (the "deputy") is manipulated by a less-privileged party into performing actions that the attacker couldn't do directly. The deputy holds the authority; the attacker exploits the deputy's trust to weaponize it.

## Why it matters
Cross-Site Request Forgery (CSRF) is the most common real-world example: your browser (the deputy) automatically sends your session cookies to a malicious site's target request, making the server believe *you* authorized a funds transfer or account change. Defending against CSRF requires anti-forgery tokens that prove the request originated from a page *your server* actually served, not one the attacker crafted.

## Key facts
- The core problem is **ambient authority** — the deputy automatically carries credentials (cookies, tokens, API keys) without verifying the true origin of the instruction
- CSRF, clickjacking, and certain OAuth misconfigurations are all classified as confused deputy attacks
- The fix typically involves **explicit authorization checks**: CSRF tokens, `SameSite` cookie attributes, or `Origin` header validation
- In OS contexts, setuid programs (e.g., a SUID binary) can be confused deputies if they use attacker-controlled environment variables like `PATH`
- The term was coined by Norm Hardy in 1988 using a compiler/billing system anecdote — the concept predates the web

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[Privilege Escalation]] [[Ambient Authority]] [[Clickjacking]] [[OAuth Security]]