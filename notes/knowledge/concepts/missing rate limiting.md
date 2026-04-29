# missing rate limiting

## What it is
Imagine a bank teller with no rule against how many times you can guess a PIN — you could just stand there trying combinations all day. Missing rate limiting is the failure to restrict how frequently a user or system can perform an action (login attempts, API calls, password resets) within a given time window, leaving the door open for automated abuse.

## Why it matters
In 2022, attackers used credential stuffing tools against a streaming service's login API — because it had no rate limiting, bots hammered millions of username/password combinations at thousands of requests per second, successfully compromising accounts before any alert fired. A simple rule of "5 failed attempts triggers a 15-minute lockout" would have made the attack economically unfeasible.

## Key facts
- **Credential stuffing and brute force attacks** rely almost entirely on the absence of rate limiting to be practical at scale
- OWASP lists missing rate limiting under **API Security Top 10 (API4:2023)** and it contributes to **Broken Authentication** in the Web Top 10
- Effective mitigations include: **account lockout policies**, **CAPTCHA after N failures**, **exponential backoff**, and **IP-based throttling**
- Rate limiting should apply to **multiple layers**: authentication endpoints, password reset flows, OTP verification, and API endpoints — not just login pages
- **Distributed attacks** can bypass IP-based rate limiting by using botnets; combining rate limiting with **behavioral analytics** (velocity checks per account) is more robust

## Related concepts
[[credential stuffing]] [[brute force attack]] [[account lockout policy]] [[API security]] [[broken authentication]]