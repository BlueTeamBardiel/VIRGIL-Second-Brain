# Authentication Protocols

## What it is
Think of authentication protocols as the secret handshake rituals between speakeasies and their patrons — both sides must prove they know the right sequence before the door opens. Formally, authentication protocols are standardized communication procedures that verify the identity of users, devices, or systems by exchanging credentials or cryptographic proofs. They define *how* trust is established, not just *what* the credentials are.

## Why it matters
In 2017, attackers exploited weak NTLM authentication in corporate networks using **Pass-the-Hash** attacks — instead of cracking a password, they captured the hashed credential from memory and replayed it to authenticate as the victim. This attack works precisely because NTLM doesn't require knowledge of the plaintext password, only its hash, exposing a fundamental weakness in how that protocol was designed.

## Key facts
- **Kerberos** uses a ticket-granting system with a trusted third party (KDC); it's the default authentication protocol in Active Directory environments and is vulnerable to **Golden Ticket** and **Kerberoasting** attacks
- **RADIUS** centralizes authentication for network access (VPNs, Wi-Fi) and uses UDP; **TACACS+** encrypts the entire payload and is preferred for device administration
- **LDAP** (port 389) transmits credentials in cleartext; **LDAPS** (port 636) adds TLS encryption — a common misconfiguration finding
- **OAuth 2.0** is an *authorization* framework, not authentication; **OpenID Connect (OIDC)** layers identity verification on top of OAuth to provide actual authentication
- **Multi-factor authentication (MFA)** defeats credential stuffing and phishing but not session hijacking after a valid token is issued

## Related concepts
[[Kerberos]] [[Multi-Factor Authentication]] [[Identity and Access Management]] [[Pass-the-Hash Attack]] [[Zero Trust Architecture]]