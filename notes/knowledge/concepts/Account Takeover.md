# Account Takeover

## What it is
Like a thief who steals your house key, makes a copy, and returns it before you notice — account takeover (ATO) is when an attacker gains unauthorized access to a legitimate user's account and operates *as that user*, often without immediately changing anything visible. It is the successful exploitation of credentials or session data to hijack an authenticated identity, distinct from simply cracking a password — the goal is persistent, stealthy control.

## Why it matters
In the 2022 Uber breach, an attacker used MFA fatigue (spamming push notifications until the user accepted) to take over an employee's VPN account, then pivoted laterally across internal systems. The account itself wasn't "broken into" — it was socially surrendered. This illustrates why ATO detection must focus on behavioral anomalies, not just failed logins.

## Key facts
- **Credential stuffing** is the most common ATO vector — automated tools test billions of username/password pairs leaked from other breaches against target sites
- **Session hijacking** achieves ATO without credentials by stealing a valid session token via XSS, network interception, or cookie theft
- **Indicators of ATO** include impossible travel (logins from two geographically distant locations within minutes), new device fingerprints, and sudden privilege escalation requests
- **MFA significantly reduces ATO risk** but is bypassed via SIM swapping, real-time phishing proxies (e.g., Evilginx2), and push notification fatigue attacks
- Under **NIST SP 800-63B**, re-authentication is required for sensitive actions even in active sessions — a direct countermeasure against session-based ATO

## Related concepts
[[Credential Stuffing]] [[Session Hijacking]] [[Multi-Factor Authentication]] [[MFA Fatigue]] [[Privilege Escalation]]