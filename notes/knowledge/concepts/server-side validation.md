# server-side validation

## What it is
Like a nightclub bouncer who checks IDs at the door *and* has a second guard inside who checks again — because the first guard could be bribed. Server-side validation is the process of verifying and sanitizing all user-supplied input on the server, independent of any checks performed on the client. It is the authoritative last line of defense because client-side code (JavaScript, HTML attributes) runs in an environment the attacker fully controls.

## Why it matters
In 2008, attackers exploited missing server-side validation in Heartland Payment Systems by submitting malicious SQL through web forms — the client-side checks were bypassed trivially, and the server accepted the poisoned input directly. Any application that relies *only* on JavaScript form validation is assuming the attacker is using a normal browser, which they are not. Tools like Burp Suite make it trivial to intercept and modify HTTP requests after client-side validation has already fired.

## Key facts
- Client-side validation can **always** be bypassed — attackers use proxies (Burp Suite, OWASP ZAP) to modify requests after the browser's checks run
- Server-side validation is the **required** control; client-side validation is a UX convenience only
- Missing server-side validation is the root cause of **SQLi, XSS, command injection**, and many OWASP Top 10 vulnerabilities
- Proper server-side validation includes: **type checking, length limits, allowlisting acceptable values**, and rejecting unexpected input rather than sanitizing it
- On the Security+/CySA+ exam, "input validation" as a control maps directly to server-side validation — it is classified under **application hardening** and **secure coding practices**

## Related concepts
[[input validation]] [[SQL injection]] [[cross-site scripting]] [[allowlisting]] [[OWASP Top 10]]