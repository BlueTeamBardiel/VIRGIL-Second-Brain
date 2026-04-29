# IMAP

## What it is
Think of IMAP like a library where your emails live on the shelf permanently — you browse and read them in place, but the books stay put. Internet Message Access Protocol (IMAP) is an email retrieval protocol that allows clients to access and manage messages stored on a remote mail server without downloading and deleting them. Unlike POP3, IMAP maintains server-side storage and synchronizes state across multiple devices.

## Why it matters
Attackers frequently target exposed IMAP services (port 143/993) through credential stuffing attacks — automated tools like SNIPR and Sentry MBA hammer IMAP endpoints because many organizations bypass MFA for legacy mail protocols. Microsoft's 2019 breach of high-profile Office 365 accounts exploited exactly this: threat actors used IMAP to authenticate with stolen credentials even when MFA was enforced on the web portal, because IMAP clients used basic authentication that MFA policies didn't cover.

## Key facts
- **Ports:** 143 (plaintext) and 993 (IMAP over SSL/TLS — IMAPS); port 143 in cleartext is a confidentiality risk
- **Authentication weakness:** Legacy IMAP supports Basic Auth, which transmits credentials in Base64 (not encryption — easily decoded); modern deployments should enforce OAuth 2.0
- **Four message states:** Seen, Answered, Flagged, Deleted — IMAP tracks these flags server-side, enabling multi-device sync
- **MFA bypass vector:** Many cloud providers historically exempted IMAP/POP3 from MFA enforcement, making it a favorite lateral movement pivot point post-credential-theft
- **Enumeration risk:** IMAP banner grabbing can reveal mail server software and version (e.g., Dovecot, Cyrus), aiding reconnaissance

## Related concepts
[[POP3]] [[SMTP]] [[Credential Stuffing]] [[Multi-Factor Authentication]] [[Email Security]]