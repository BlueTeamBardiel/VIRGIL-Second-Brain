# Single Sign-On

## What it is
Like a theme park wristband — you prove your identity once at the gate, and every ride lets you in without re-checking your ticket. Technically, SSO is an authentication scheme where a central Identity Provider (IdP) issues a token after one successful login, and multiple Service Providers (SPs) trust that token to grant access without requiring separate credentials.

## Why it matters
In 2020, attackers compromised SolarWinds' build pipeline and, once inside, leveraged forged SAML tokens (a "Golden SAML" attack) to authenticate to cloud services as any user — no passwords needed. This illustrates the critical risk of SSO: the IdP becomes a single point of catastrophic failure. If an attacker forges or steals the trust token, they inherit access to *every* connected service simultaneously.

## Key facts
- **Common protocols**: SAML 2.0 (XML-based, enterprise-heavy), OAuth 2.0 (authorization delegation), and OpenID Connect (OIDC, identity layer on top of OAuth) are the three dominant SSO frameworks
- **Federation vs. SSO**: Federation extends SSO *across organizational boundaries* (e.g., logging into a partner company's portal with your own company's credentials)
- **Attack surface**: Credential theft is amplified — one compromised account grants access to all federated services; session token theft (pass-the-ticket) is a primary attack vector
- **SAML assertion**: The signed XML document the IdP sends to the SP; if the signing certificate is compromised, attackers can forge assertions (Golden SAML)
- **Security tradeoff**: SSO reduces password fatigue and enables centralized MFA enforcement, but eliminates defense-in-depth across individual service logins

## Related concepts
[[SAML]] [[OAuth]] [[Identity Provider]] [[Kerberos]] [[Federation]]