# MTA-STS

## What it is
Like a bouncer with a laminated list at the door — if your name isn't on it, you're not getting in — MTA-STS is a policy mechanism that tells sending mail servers "only deliver to me over authenticated, encrypted TLS, or drop the message entirely." It's an SMTP security standard that prevents mail servers from silently downgrading to plaintext connections by publishing a policy via HTTPS and DNS that receiving servers must honor.

## Why it matters
Without MTA-STS, an attacker performing a STARTTLS downgrade attack can intercept traffic between two mail servers by stripping the STARTTLS command, forcing email to transit in plaintext — and neither sender nor recipient knows it happened. MTA-STS closes this gap by requiring sending MTAs to validate the receiving server's TLS certificate against a policy fetched over HTTPS (making the policy itself tamper-resistant), and reject delivery if validation fails.

## Key facts
- MTA-STS policy is published as a text file at `https://mta-sts.[domain]/.well-known/mta-sts.txt` and signaled via a DNS TXT record (`_mta-sts.[domain]`).
- Policies can be set to `enforce` (reject on failure), `testing` (report only), or `none` (disabled) — making staged rollout possible.
- Works alongside **DANE/TLSA** but doesn't require DNSSEC, lowering the barrier to adoption.
- Pairs with **SMTP TLS Reporting (TLS-RPT)** — a separate DNS TXT record (`_smtp._tls.[domain]`) that enables daily failure reports to a specified address.
- Does NOT encrypt email content; it only secures the *transport channel* between mail servers (MTA-to-MTA).

## Related concepts
[[STARTTLS]] [[DANE]] [[DMARC]]