# PSE

## What it is
Like a bank teller who hands over cash without verifying *why* the customer has authority — just that they're standing at the window — a Pre-Authentication Security Exception (PSE) is a condition where a system permits certain operations or data exposure before a user has proven their identity. More precisely, PSE refers to vulnerabilities or design choices that allow access to resources, services, or information prior to completing the authentication handshake.

## Why it matters
The 2021 Microsoft Exchange ProxyLogon vulnerability chain exploited a server-side request forgery flaw that was effectively a pre-authentication issue — attackers could reach internal Exchange components without valid credentials, then chain it with post-auth bugs to achieve RCE. This illustrates why pre-auth attack surfaces are high-severity: there's no credential barrier slowing the attacker down.

## Key facts
- Pre-authentication vulnerabilities are automatically classified as **Critical (CVSS 9.0+)** because they require no valid credentials to exploit
- Common pre-auth attack vectors include: **NTLM negotiation abuse**, **exposed login APIs**, and **unauthenticated SOAP/REST endpoints**
- PSE conditions are often introduced by **exception handling code** that bypasses auth middleware for error states or "guest" functionality
- Security controls like **network segmentation** and **WAF rules** act as compensating controls when pre-auth flaws can't be patched immediately
- CySA+ testing expects analysts to identify pre-auth issues during **vulnerability scanning** — they appear as services responding substantively to unauthenticated probes

## Related concepts
[[Authentication Bypass]] [[Zero-Day Vulnerability]] [[Attack Surface Reduction]] [[CVE Scoring (CVSS)]] [[Proxy Vulnerabilities]]