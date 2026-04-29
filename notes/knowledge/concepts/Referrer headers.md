# Referrer headers

## What it is
Like a polite guest who tells the host "I came from the party at 42 Oak Street," your browser automatically tells each website which URL you just came from. Precisely: the HTTP `Referer` header (intentionally misspelled in the original RFC) is a request header that browsers attach to outbound requests, revealing the originating URL of the page that triggered the request.

## Why it matters
Sensitive data frequently leaks through referrer headers without anyone noticing. Imagine a healthcare portal whose password-reset URL includes a token: `https://hospital.com/reset?token=abc123`. When a user on that page clicks an external advertisement, the browser sends that full URL — including the secret token — to the advertiser's server in the `Referer` header, allowing account takeover without any active hacking.

## Key facts
- The header is spelled `Referer` (one 'r') due to a typo in RFC 1945 that became permanent; the correct policy attribute is spelled `Referrer-Policy`
- The `Referrer-Policy` response header controls leakage: `no-referrer` sends nothing, `same-origin` sends the full URL only to same-origin requests, and `strict-origin-when-cross-origin` is the modern secure default
- Referrer headers enable **CSRF token harvesting**, **session token leakage**, and **PII disclosure** through query string parameters
- Browsers suppress the `Referer` header when navigating from HTTPS to HTTP (protocol downgrade), but not from HTTPS to HTTPS cross-origin by default
- Web Application Firewalls (WAFs) can use referrer validation as a CSRF defense layer, rejecting requests whose referrer doesn't match the expected origin

## Related concepts
[[Cross-Site Request Forgery]] [[HTTP Security Headers]] [[Information Disclosure]] [[Same-Origin Policy]] [[CSRF Tokens]]