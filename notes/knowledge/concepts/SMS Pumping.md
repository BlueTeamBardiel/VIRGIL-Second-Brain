# SMS Pumping

## What it is
Imagine a toll-road scammer who owns the toll booths — every car you route through pays him a cut. SMS pumping works the same way: attackers control premium-rate phone numbers and abuse "send me a verification code" features on legitimate websites, routing thousands of automated SMS messages through those numbers to collect carrier revenue sharing payouts. Technically, it is a fraud scheme where bots trigger mass SMS sends to attacker-controlled numbers, monetizing the per-message fees that telecom carriers pay to number owners.

## Why it matters
In 2023, several major SaaS platforms reported six-figure losses when attackers discovered their phone verification endpoints had no rate limiting — bots hammered the API with thousands of requests per minute, each generating a chargeable SMS to premium numbers the attacker owned. The platform paid the SMS bill; the attacker collected the carrier payout. Defending against it requires combining rate limiting, CAPTCHA gating, and geographic blocking on SMS-sending endpoints.

## Key facts
- Attackers monetize through **revenue sharing agreements** with telecoms — they own or lease premium-rate numbers that earn fractions of a cent per received message, which scales massively with automation
- Target vector is almost always **unauthenticated or lightly authenticated API endpoints** that trigger SMS (OTP/2FA registration flows, password reset, login notifications)
- Losses are borne by the **victim organization**, not the end user — the business pays its SMS provider per message sent
- Effective mitigations include **rate limiting per IP/session, CAPTCHA, phone number allow/block lists, and anomaly detection** on SMS volume spikes
- Distinct from **smishing** — SMS pumping is financial fraud against businesses, not social engineering against individuals

## Related concepts
[[Smishing]] [[API Rate Limiting]] [[Toll Fraud]] [[Credential Stuffing]] [[Multi-Factor Authentication Abuse]]