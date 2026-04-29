# improper authentication

## What it is
Imagine a bouncer who checks that you *have* a wristband, but never looks at whether it's from *tonight's* event — anyone with any old wristband walks in. Improper authentication occurs when a system fails to adequately verify the identity of a user or process before granting access, either by skipping steps, accepting weak proof, or trusting unverified claims. It's classified under CWE-287 and is distinct from authorization failures, which happen *after* identity is confirmed.

## Why it matters
In 2022, attackers exploited improper authentication in Cisco's RADIUS implementation by replaying captured authentication tokens, gaining network access without valid credentials. Defenders countered by enforcing mutual authentication (both sides verify each other) and implementing short-lived session tokens — demonstrating that *how* you verify identity is as important as *whether* you do.

## Key facts
- **CWE-287** is the formal classification; frequently appears in OWASP Top 10 under "Broken Authentication"
- Common failure modes include: missing authentication on sensitive endpoints, accepting expired tokens, trusting client-supplied identity claims (e.g., a `userId` in a cookie without cryptographic signing)
- **Multi-factor authentication (MFA)** directly mitigates many improper authentication weaknesses by requiring proof from multiple independent categories
- Session tokens issued after authentication must be sufficiently random (≥128 bits entropy) and expire; predictable tokens enable session hijacking even without stealing credentials
- APIs are a high-risk surface — unauthenticated REST endpoints exposing admin functions are a classic improper authentication finding in penetration tests

## Related concepts
[[broken access control]] [[session hijacking]] [[credential stuffing]] [[multi-factor authentication]] [[insecure direct object reference]]