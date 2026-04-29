# authorization code interception attacks

## What it is
Like stealing a valet ticket mid-air as it's tossed across a parking lot — the thief never needed your keys, just the slip of paper that grants access. In OAuth 2.0, an authorization code is a short-lived token exchanged between a client app and an authorization server; if an attacker intercepts it before the legitimate client can swap it for an access token, they can complete the exchange themselves and hijack the session.

## Why it matters
A malicious app registered on the same mobile device can register a custom URI scheme identical to a legitimate app's redirect URI. When the authorization server redirects the code to `myapp://callback`, the OS may deliver it to the attacker's app instead — a real attack pattern documented against native mobile OAuth implementations. This is precisely why RFC 7636 introduced PKCE (Proof Key for Code Exchange) as a mandatory countermeasure.

## Key facts
- **PKCE mitigates this attack** by requiring the client to send a hashed `code_challenge` upfront and the plaintext `code_verifier` at exchange time — an interceptor without the verifier cannot redeem the code.
- Authorization codes are **single-use and short-lived** (typically 60 seconds or less) to limit the interception window.
- The attack exploits **open or ambiguous redirect URIs**; strict redirect URI validation is a primary server-side defense.
- On mobile platforms, **claimed HTTPS redirect URIs** (verified via App Links/Universal Links) are preferred over custom URI schemes to prevent URI hijacking.
- PKCE is now recommended for **all OAuth 2.0 clients** (public and confidential) per OAuth 2.1 draft standards, not just mobile/native apps.

## Related concepts
[[OAuth 2.0]] [[PKCE]] [[redirect URI manipulation]] [[open redirect vulnerabilities]] [[access token theft]]