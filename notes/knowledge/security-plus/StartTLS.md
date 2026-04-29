# StartTLS

## What it is
Like a handshake at a party where two people agree to switch from speaking loudly in public to whispering privately — StartTLS is an opportunistic upgrade mechanism that takes an already-open plaintext connection and elevates it to TLS encryption mid-conversation. Precisely, it is a protocol command used in SMTP, IMAP, POP3, and LDAP that instructs both parties to negotiate a TLS session on the same port, rather than opening a separate encrypted port from the start.

## Why it matters
In a **STARTTLS stripping attack**, a man-in-the-middle intercepts the server's advertisement that it supports StartTLS and silently removes it from the response before the client sees it. The client, believing encryption is unavailable, proceeds in plaintext — exposing credentials and email content — while the attacker logs everything transparently. This is why SMTP STS (MTA-STS) and DANE were developed: to enforce that encryption *must* be used, not merely offered.

## Key facts
- StartTLS operates on **standard plaintext ports** (SMTP 25/587, IMAP 143, POP3 110, LDAP 389), upgrading to TLS in-band — distinct from implicit TLS which uses dedicated encrypted ports (465, 993, 995, 636).
- It is **opportunistic by default**, meaning if the upgrade fails or is stripped, many clients silently fall back to plaintext rather than aborting.
- The `STARTTLS` command in SMTP is issued *after* the initial EHLO greeting but *before* any AUTH or mail transfer commands.
- **STARTTLS stripping** is a well-documented downgrade attack; MTA-STS and SMTP DANE mitigate it by publishing enforceable encryption policies via DNS.
- Unlike end-to-end encryption (PGP/S-MIME), StartTLS only encrypts the **transport hop** between mail servers — the receiving server sees plaintext content.

## Related concepts
[[TLS Handshake]] [[Downgrade Attack]] [[SMTP Security]] [[MTA-STS]] [[LDAP Security]]