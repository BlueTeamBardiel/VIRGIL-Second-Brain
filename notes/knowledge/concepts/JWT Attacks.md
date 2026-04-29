# JWT Attacks

## What it is
Imagine a wax seal on a royal letter — if the seal can be forged or removed without detection, anyone can impersonate the king. A JSON Web Token (JWT) is a Base64-encoded, digitally signed credential used to prove identity in web apps, and JWT attacks exploit weaknesses in how the token is generated, validated, or trusted to forge authentication or escalate privileges.

## Why it matters
In 2022, researchers demonstrated that misconfigured JWTs using the `alg: none` bypass allowed attackers to craft admin tokens with no signature at all — simply by stripping the cryptographic signature and changing the payload to `"role": "admin"`. Any server accepting unsigned tokens without validation would grant full administrative access without a password.

## Key facts
- **`alg: none` attack**: Setting the algorithm field to `none` causes vulnerable servers to skip signature verification entirely, accepting forged tokens.
- **Algorithm confusion (RS256 → HS256)**: If a server uses RS256 (asymmetric), an attacker can change the algorithm to HS256 and sign the token with the *server's public key*, tricking it into accepting a self-forged token.
- **JWTs are NOT encrypted by default** — they are only Base64-encoded, meaning anyone can read the payload; never store sensitive data in them.
- **JWT secret cracking**: Weak HMAC secrets can be brute-forced offline using tools like `hashcat` against captured tokens.
- **Kid (Key ID) injection**: Manipulating the `kid` header parameter can redirect key lookup to a SQL database or file system, enabling SQL injection or path traversal attacks.

## Related concepts
[[Authentication Bypass]] [[OAuth 2.0 Attacks]] [[Broken Access Control]] [[Session Hijacking]] [[API Security]]