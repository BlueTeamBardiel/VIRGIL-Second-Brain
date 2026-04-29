# magic link

## What it is
Like a self-destructing hotel key slipped under your door — you click it once, it lets you in, then it expires forever. A magic link is a time-limited, single-use URL sent to a user's email (or SMS) that authenticates them without requiring a password, functioning as a form of possession-based authentication.

## Why it matters
An attacker who intercepts a magic link email — through a compromised mail server, a forwarding rule left by malware, or a man-in-the-middle on an unencrypted SMTP connection — can authenticate as the victim before the legitimate user even opens their inbox. This makes the security of magic links entirely dependent on the confidentiality of the delivery channel, which is why email-based authentication is only as strong as the email account protecting it.

## Key facts
- Magic links implement **something you have** (access to the email account), making them single-factor authentication despite appearing passwordless
- Tokens must be **cryptographically random** (minimum 128 bits of entropy) and **short-lived** (typically 15–30 minutes) to resist brute-force and replay attacks
- A consumed token must be **immediately invalidated** server-side; failure to do so creates a replay vulnerability
- Magic links are vulnerable to **link prefetching** — email security scanners and proxies may automatically GET the URL, consuming the token before the user clicks it
- Under NIST SP 800-63B, magic links delivered via email qualify as an **AAL1** authenticator, not suitable for high-assurance applications

## Related concepts
[[passwordless authentication]] [[token-based authentication]] [[replay attack]] [[email security]] [[multi-factor authentication]]