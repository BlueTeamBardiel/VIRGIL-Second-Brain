# user enumeration

## What it is
Like a hotel front desk that says "that room doesn't exist" versus "that room is occupied" — an attacker can map out valid guests just by listening to the difference. User enumeration is the process of identifying valid usernames or accounts on a system by analyzing subtle differences in application responses to valid versus invalid login attempts.

## Why it matters
During the 2012 LinkedIn breach investigation, researchers demonstrated that LinkedIn's login page returned distinct error messages for "wrong password" versus "account not found," allowing attackers to pre-validate millions of email addresses before cracking password hashes. Defenders mitigate this by enforcing generic error messages like "invalid username or password" regardless of which field is wrong.

## Key facts
- **Timing attacks** can enable enumeration even when error messages are identical — a valid username that triggers password hashing takes measurably longer to respond than an invalid one that fails immediately
- **HTTP response differences** that leak enumeration data include: status codes, response body length, redirect behavior, and cookie assignment
- **SMTP VRFY and EXPN commands** are classic server-side enumeration vectors that allow direct user account confirmation if not disabled
- **Registration forms** are often overlooked enumeration surfaces — "that email is already taken" confirms an account exists
- Mitigations include: uniform error messages, **rate limiting**, **account lockout**, CAPTCHA, and constant-time authentication responses

## Related concepts
[[credential stuffing]] [[brute force attack]] [[OSINT]] [[authentication bypass]] [[password spraying]]