# redirect URL

## What it is
Like a postal forwarding service that silently reroutes your mail to a different address, a redirect URL is a web mechanism that automatically sends users from one URL to another — often transparently. Technically, it's an HTTP response (301, 302, 307, or 308 status codes) or a meta-tag/JavaScript instruction that navigates the browser to a new destination without requiring user action.

## Why it matters
Attackers exploit **open redirects** — legitimate sites that accept a destination URL as a parameter (e.g., `https://bank.com/login?next=https://evil.com`) — to craft phishing links that appear trustworthy because they begin with a real domain. A victim sees `bank.com` in the URL, clicks it confidently, and lands on a credential-harvesting page; the bank's own server did the forwarding.

## Key facts
- An **open redirect** occurs when a web app redirects users to an arbitrary URL supplied in a parameter without validating the destination — listed in OWASP's historical Top 10 (A10:2013).
- HTTP **301** = permanent redirect; **302/307** = temporary redirect — attackers prefer parameters controlling 302 redirects because caching is less likely to expose the manipulation.
- Open redirects are frequently chained with **OAuth flows** to steal authorization tokens by redirecting the token callback to an attacker-controlled URI.
- Defense requires **allowlist validation** of redirect destinations — blocklists and relative-URL checks alone are bypassable via URL encoding tricks (e.g., `//evil.com`, `%2F%2Fevil.com`).
- Security scanners flag open redirects as **CWE-601** (URL Redirection to Untrusted Site); it's a moderate-severity finding that elevates to critical when combined with OAuth or SSO systems.

## Related concepts
[[open redirect]] [[phishing]] [[OAuth]] [[URL encoding]] [[input validation]]