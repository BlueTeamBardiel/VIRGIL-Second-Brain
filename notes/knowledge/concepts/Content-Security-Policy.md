# Content-Security-Policy

## What it is
Think of it as a bouncer with a guest list for your browser — only scripts, styles, and resources from pre-approved sources are allowed inside. Content-Security-Policy (CSP) is an HTTP response header that instructs browsers to restrict which origins can load executable content on a webpage, effectively defining a whitelist of trusted resource sources.

## Why it matters
In 2018, the British Airways breach involved attackers injecting malicious JavaScript that skimmed payment card data from the checkout page — a classic XSS attack that a strict CSP could have blocked by preventing execution of unauthorized inline scripts. A policy like `script-src 'self'` would have stopped the injected third-party skimmer from running, protecting roughly 500,000 customers' data.

## Key facts
- CSP is delivered via the `Content-Security-Policy` HTTP header or a `<meta>` tag, though the header is preferred and more secure
- The `default-src` directive acts as a fallback for all resource types not explicitly defined by other directives
- `'unsafe-inline'` and `'unsafe-eval'` are dangerous directive values that largely defeat CSP's XSS protection — their presence is a red flag in assessments
- **Report-Only mode** (`Content-Security-Policy-Report-Only`) allows logging violations without enforcing them, enabling safe policy testing before deployment
- CSP does **not** prevent all XSS — if a trusted origin itself serves attacker-controlled content (JSONP endpoints, CDN script injection), CSP can be bypassed

## Related concepts
[[Cross-Site Scripting (XSS)]] [[HTTP Security Headers]] [[Same-Origin Policy]] [[Clickjacking]] [[Subresource Integrity]]