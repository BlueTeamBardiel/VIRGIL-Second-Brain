# IdP

## What it is
Think of an IdP like the bouncer at a club who checks your ID once at the door and gives you a wristband — every bar inside the venue just checks the wristband, not your ID. An Identity Provider (IdP) is a trusted system that authenticates users and issues identity assertions (tokens or assertions) to other applications, so those apps never have to manage credentials themselves. It is the centralized authority in federated identity systems like SAML, OAuth, and OIDC.

## Why it matters
In 2023, attackers targeting Okta (a major IdP) were able to compromise support tooling and access customer tenant data — because a breach of the IdP is a breach of *every* service that trusts it. This is the critical attack surface: compromise one IdP, and an attacker inherits valid authentication across dozens or hundreds of downstream Service Providers. Defenders must treat the IdP as crown-jewel infrastructure with MFA, privileged access controls, and rigorous audit logging.

## Key facts
- An IdP issues **SAML Assertions**, **OIDC ID Tokens**, or **OAuth Access Tokens** depending on the federation protocol in use
- The **Service Provider (SP)** trusts the IdP — it never sees or stores the user's actual password
- Common IdP examples: **Okta, Azure AD (Entra ID), PingFederate, Google Workspace**
- IdP-initiated vs. **SP-initiated SSO** matters for security: SP-initiated is generally safer because it includes a requestID that prevents replay attacks
- A compromised IdP enables **Golden SAML attacks**, where attackers forge authentication assertions without needing user credentials at all

## Related concepts
[[SAML]] [[Single Sign-On (SSO)]] [[OAuth]] [[OpenID Connect]] [[Golden SAML Attack]] [[Federation]]