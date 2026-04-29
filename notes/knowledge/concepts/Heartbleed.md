# Heartbleed

## What it is
Imagine asking a librarian "read me back 500 words" but only handing them a 5-word note — a malicious librarian could fill the rest with whatever was sitting on their desk. Heartbleed (CVE-2014-0160) is a critical buffer over-read vulnerability in OpenSSL's TLS heartbeat extension where a server fails to validate that the requested payload length matches the actual data sent, leaking up to 64KB of adjacent server memory per request. This memory could contain private keys, session tokens, passwords, or plaintext credentials.

## Why it matters
In 2014, attackers exploited Heartbleed against Yahoo servers, exfiltrating session cookies that allowed account hijacking without any credentials. More critically, the vulnerability could expose a server's **private TLS key**, meaning all past encrypted traffic captured by a passive attacker could be retroactively decrypted — perfect forward secrecy was the only defense against that specific consequence.

## Key facts
- Affected **OpenSSL versions 1.0.1 through 1.0.1f**; patched in 1.0.1g (April 7, 2014)
- Classified as a **buffer over-read**, not a buffer overflow — no code execution, just memory disclosure
- Required **no authentication** to exploit; a single malformed heartbeat request was sufficient
- Severity: **CVSS 7.5 (High)**; estimated 17–24% of all HTTPS servers were vulnerable at disclosure
- Remediation required: patching OpenSSL, **revoking and reissuing TLS certificates**, and invalidating all active sessions — patching alone was insufficient

## Related concepts
[[Buffer Over-Read]] [[OpenSSL]] [[TLS/SSL]] [[CVE Scoring]] [[Perfect Forward Secrecy]]