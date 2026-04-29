# Active Directory Federation Services

## What it is
Think of ADFS like a diplomatic passport — it lets you cross organizational borders without needing a separate visa (account) for each country. Precisely, ADFS is a Microsoft identity federation solution that enables Single Sign-On (SSO) across organizational boundaries by issuing claims-based tokens using SAML, OAuth, or WS-Federation protocols. It acts as a Security Token Service (STS), vouching for a user's identity to external applications without sharing credentials directly.

## Why it matters
In the 2020 SolarWinds breach, attackers forged SAML tokens by stealing the ADFS token-signing certificate — a technique called a Golden SAML attack. Because ADFS-issued tokens are inherently trusted by downstream services like Microsoft 365, the attackers moved laterally across cloud environments without ever touching Active Directory credentials. Defenders must monitor for unauthorized certificate exports and unexpected token-signing certificate changes as a critical detection control.

## Key facts
- ADFS uses **claims-based authentication** — a token containing attributes (claims) about a user is issued rather than passing a password
- The **token-signing certificate** is the crown jewel of ADFS; compromise = ability to forge authentication for any federated user
- **Golden SAML** attack: forging SAML assertions using a stolen signing certificate, analogous to a Kerberos Golden Ticket attack
- ADFS relies on a **trust relationship** between Identity Provider (IdP) and Service Provider (SP); the IdP asserts identity, the SP consumes it
- ADFS logs are stored in the **Windows Event Log** under `AD FS/Admin` — key forensic source for detecting anomalous token issuance

## Related concepts
[[SAML]] [[Single Sign-On]] [[Golden Ticket Attack]] [[OAuth]] [[Security Token Service]]