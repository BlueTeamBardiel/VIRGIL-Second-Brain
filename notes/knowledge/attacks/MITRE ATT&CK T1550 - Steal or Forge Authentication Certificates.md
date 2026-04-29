# MITRE ATT&CK T1550 - Steal or Forge Authentication Certificates

## What it is
Imagine stealing a master key mold from a locksmith and casting your own keys — they open every lock because they're indistinguishable from legitimate ones. Stealing or forging authentication certificates (T1550) means an adversary either exfiltrates existing digital certificates or crafts fraudulent ones to impersonate trusted identities, bypass authentication, and move laterally without triggering password-based defenses.

## Why it matters
In the 2020 SolarWinds breach, attackers forged SAML authentication tokens by compromising ADFS signing certificates — allowing them to authenticate to Microsoft 365 and Azure environments as any user without knowing actual passwords. This technique is particularly dangerous because certificate-based authentication is often treated as a gold standard, meaning SOC analysts may not flag certificate-based logins as suspicious even when originating from unusual locations.

## Key facts
- **Sub-techniques include:** Stealing web session cookies (T1550.004), Pass-the-Hash (T1550.002), Pass-the-Ticket (T1550.003), and forging Kerberos tickets like Golden Tickets (T1550.001)
- **Golden Ticket attacks** require the KRBTGT account hash, granting unlimited Kerberos ticket-granting tickets valid for 10 years by default
- **ADFS certificate theft** enables "Golden SAML" attacks, which persist even after password resets because the signing certificate is unchanged
- Detection relies on **audit logs for certificate exports**, ADFS token anomalies, and monitoring for Kerberos tickets with abnormal lifetimes or encryption types
- Mitigation includes **protecting certificate private keys** with HSMs, enabling MFA even for certificate-authenticated services, and regularly rotating ADFS signing certificates

## Related concepts
[[Kerberos Authentication]] [[Golden Ticket Attack]] [[Pass-the-Hash]] [[SAML Assertion Forgery]] [[Active Directory Certificate Services (AD CS)]]