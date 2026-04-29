# Online Attack

## What it is
Like a thief trying keys on a live lock — each attempt triggers the alarm system and leaves a trace — an online attack targets a *live, active system* in real time. Precisely, it is a password or credential attack conducted directly against a running service (login portal, SSH daemon, web app), meaning the attacker interacts with the target system for every single guess.

## Why it matters
In 2016, the Mirai botnet conducted massive online brute-force attacks against IoT devices using default credentials over Telnet, successfully compromising hundreds of thousands of devices. The attack was detectable and throttleable — but most devices had no lockout policy configured, making the live interaction trivially exploitable at scale.

## Key facts
- **Rate-limited by the target**: every guess requires a network round-trip, making online attacks orders of magnitude slower than offline attacks (thousands vs. billions of guesses per second)
- **Leaves evidence**: failed login attempts generate logs, trigger IDS alerts, and can activate account lockout policies — making stealth difficult
- **Account lockout is the primary defense**: policies that lock accounts after 3–5 failed attempts directly neutralize brute-force and password-spraying online attacks
- **Password spraying is a stealthy online variant**: one common password tested across many accounts avoids per-account lockout thresholds
- **Credential stuffing is also online**: attackers replay breached username/password pairs against live services like banking or email portals

## Related concepts
[[Offline Attack]] [[Password Spraying]] [[Credential Stuffing]] [[Account Lockout Policy]] [[Brute Force Attack]]