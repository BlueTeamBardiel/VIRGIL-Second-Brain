# synchronizer token pattern

## What it is
Like a concert ticket stub that must match the box office record before you're let backstage, a synchronizer token is a secret value embedded in a web form that the server issues and later validates. It is a CSRF defense mechanism where the server generates a unique, unpredictable token per session (or per request), embeds it in HTML forms as a hidden field, and rejects any state-changing request that fails to return a matching token.

## Why it matters
Without it, a malicious site can silently submit a forged form to your bank on your behalf — you're already authenticated, so the browser helpfully sends your cookies along. Because the attacker's site cannot read the token from your bank's HTML (blocked by same-origin policy), they can't forge a valid request. This pattern is the primary technical control that stops Cross-Site Request Forgery (CSRF) attacks cold.

## Key facts
- Tokens must be **cryptographically random** (at least 128 bits of entropy) — sequential or guessable tokens defeat the purpose entirely
- Tokens are typically stored **server-side in session state** and compared against the value submitted in the form's hidden field
- **Double-submit cookie** is an alternative variant that stores the token in both a cookie and a form field, avoiding server-side state storage
- Tokens should be **per-session at minimum**, with per-request tokens offering stronger but more complex protection
- The defense relies on the **same-origin policy** preventing attacker scripts from reading the token value from target-site responses

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[same-origin policy]] [[session management]] [[double-submit cookie]] [[anti-CSRF headers]]