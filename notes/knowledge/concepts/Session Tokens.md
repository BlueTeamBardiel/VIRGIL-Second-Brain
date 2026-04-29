# session tokens

## What it is
Like a coat-check ticket at a restaurant — you hand over your credentials once, get a stub, and every subsequent interaction you just wave the stub instead of proving your identity from scratch. Precisely: a session token is a temporary, unique identifier issued by a server after successful authentication, stored client-side (cookie, localStorage, or URL parameter) and transmitted with each subsequent request to maintain stateful communication over the stateless HTTP protocol.

## Why it matters
In a session hijacking attack, an adversary on the same network captures a victim's unencrypted session token via packet sniffing, then replays it to impersonate that user without ever knowing their password. This is why HTTPS is non-negotiable — TLS encrypts the token in transit — and why the `Secure` and `HttpOnly` cookie flags exist: the first prevents transmission over plain HTTP, the second blocks JavaScript from reading the token and exfiltrating it via XSS.

## Key facts
- Session tokens should be **cryptographically random** and at least **128 bits** of entropy to resist brute-force guessing attacks
- **Session fixation** occurs when an attacker pre-sets a known session ID before login; the defense is to **regenerate the session token upon successful authentication**
- The `HttpOnly` flag prevents JavaScript access; `Secure` flag restricts transmission to HTTPS; `SameSite=Strict` mitigates CSRF attacks
- Session tokens should have a defined **expiration time** (idle timeout + absolute timeout) to limit the window of compromise
- OWASP classifies broken session management under **A07:2021 – Identification and Authentication Failures** in the Top 10

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Cross-Site Request Forgery (CSRF)]] [[session hijacking]] [[cookie security attributes]] [[HTTP statelessness]]