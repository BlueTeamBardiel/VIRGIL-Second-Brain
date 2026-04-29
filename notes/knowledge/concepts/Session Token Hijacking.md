# Session Token Hijacking

## What it is
Imagine someone steals your wristband at a concert — they didn't need your ticket or ID, just the wristband, and now they walk around as if they're you. Session token hijacking is exactly that: an attacker steals a valid session token (a temporary credential assigned after login) to impersonate an authenticated user without ever knowing their password.

## Why it matters
In 2010, the Firesheep browser extension made this devastatingly simple — anyone on an open Wi-Fi network could one-click capture Facebook and Twitter session cookies transmitted in plaintext over HTTP. This forced major platforms to adopt HTTPS site-wide and demonstrated that protecting login credentials means nothing if the session token is exposed post-authentication.

## Key facts
- Session tokens are typically stored as cookies, URL parameters, or hidden form fields; cookies with the `Secure` and `HttpOnly` flags are significantly harder to steal
- **Cross-Site Scripting (XSS)** is the most common vector for stealing session cookies client-side by injecting malicious JavaScript
- **Packet sniffing** on unencrypted HTTP traffic is the network-layer equivalent attack
- Session fixation is a related but distinct attack: the attacker *sets* the victim's session ID before login rather than stealing one after
- OWASP classifies broken session management under **A07:2021 – Identification and Authentication Failures**; regenerating session tokens after privilege escalation (e.g., post-login) is a critical countermeasure

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Session Fixation]] [[Cookie Security Attributes]]