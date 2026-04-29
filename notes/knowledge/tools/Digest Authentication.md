# Digest Authentication

## What it is
Like a bouncer who checks your ID by asking you to solve a math puzzle with a secret ingredient — so he never actually sees your password, only the answer. Digest Authentication is an HTTP authentication scheme where the client hashes the password together with a server-provided nonce (a one-time random value) before transmitting credentials, ensuring the plaintext password never crosses the wire.

## Why it matters
In a network where an attacker runs Wireshark, Basic Authentication exposes credentials in cleartext (just Base64-encoded), making credential theft trivial. Digest Authentication defeats this passive sniffing attack because intercepted traffic reveals only the hashed response — however, it remains vulnerable to man-in-the-middle attacks where an attacker downgrades the connection to Basic Auth, making HTTPS essential even when Digest is used.

## Key facts
- Uses MD5 hashing by default (defined in RFC 2617), which is cryptographically weak by modern standards — a significant exam-relevant limitation
- The server sends a **nonce** in the WWW-Authenticate header; the client computes `MD5(username:realm:password)` combined with that nonce to create the response
- Protects against **replay attacks** because each nonce is unique per session/request
- Does **not** protect against man-in-the-middle attacks — an attacker can intercept and substitute their own challenge
- Considered largely deprecated in favor of token-based schemes (OAuth, Bearer tokens) or simply using Basic Auth over enforced TLS; rarely implemented in modern APIs

## Related concepts
[[Basic Authentication]] [[Nonce]] [[Man-in-the-Middle Attack]] [[Challenge-Response Authentication]] [[HTTP Security Headers]]