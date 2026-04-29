# AS-REP Roasting

## What it is
Think of AS‑REP Roasting like a “hot‑dish” where a server’s response to a challenge is served unencrypted, letting an eavesdropper grab the sauce and later cook it. Technically, it is a credential‑cracking technique that exploits Kerberos AS‑REP messages sent to users with the “cannot pre‑authentiate” flag, allowing attackers to obtain a session ticket and the encrypted timestamp without any password guess.

## Why it matters
In many corporate forests, a handful of service accounts are set to “disable pre‑authentication.” An attacker who obtains a user’s network traffic can replay the AS‑REP, recover the encrypted timestamp, and brute‑force the password offline. This has enabled attackers to compromise privileged accounts without ever interacting with the domain controller, bypassing typical logging.

## Key facts
- AS‑REP is sent in cleartext to users who are pre‑auth disabled; the response contains a ticket‑granting ticket (TGT) and an encrypted timestamp.
- The attacker records the AS‑REP, extracts the ticket and the encrypted timestamp, then performs offline dictionary or brute‑force attacks against the password.
- Compromise success rate is high if the password is weak; strong passwords reduce the risk but do not eliminate it.
- Mitigation: enforce “Require strong passwords” and “Do not allow users to disable pre‑authentication” on all accounts, especially service accounts.
- Detection: monitor for unusually high numbers of AS‑REP requests or failed Kerberos authentication attempts against accounts with the pre‑auth disabled flag.

## Related concepts
[[Kerberos]] [[Pre‑authentication]] [[Password cracking]]