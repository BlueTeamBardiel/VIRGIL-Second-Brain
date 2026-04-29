# rate limiting

## What it is
Think of a bouncer at a nightclub who lets in one person every 30 seconds no matter how big the crowd gets — that's rate limiting. It is a control mechanism that restricts how many requests a user, IP address, or service can make within a defined time window, preventing any single source from overwhelming a system.

## Why it matters
Without rate limiting, attackers can run credential stuffing attacks — automatically trying millions of username/password combinations stolen from breached databases — at full machine speed. Rate limiting forces attackers to slow down dramatically, making brute-force and enumeration attacks computationally expensive enough to become impractical, or loud enough to trigger alerting before success.

## Key facts
- Rate limiting is a primary defense against **brute-force**, **credential stuffing**, and **enumeration attacks** on login endpoints
- Implementations can throttle by **IP address**, **user account**, **API key**, or **geolocation** — IP-only limiting is bypassable via distributed botnets
- HTTP **429 Too Many Requests** is the standard response code returned when a client exceeds its limit
- **Token bucket** and **leaky bucket** are the two dominant algorithms used to implement rate limiting — token bucket allows controlled bursting; leaky bucket enforces a strict constant rate
- Rate limiting is distinct from **blocking** — it slows or queues traffic rather than permanently denying it, reducing false-positive impact on legitimate users
- NIST SP 800-63B recommends rate limiting as a required control for online authentication attempts

## Related concepts
[[brute force attack]] [[credential stuffing]] [[API security]] [[denial of service]] [[account lockout policy]]