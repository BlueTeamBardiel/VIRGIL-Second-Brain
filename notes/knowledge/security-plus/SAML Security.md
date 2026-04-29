# SAML Security

## What it is
Think of SAML like a notarized letter from your employer that you hand to a hotel front desk — the hotel trusts the employer's stamp without ever calling HR themselves. Security Assertion Markup Language (SAML) is an XML-based open standard that enables Single Sign-On (SSO) by allowing an Identity Provider (IdP) to pass cryptographically signed authentication assertions to a Service Provider (SP). The SP trusts the IdP's signature rather than re-authenticating the user directly.

## Why it matters
In 2017, researchers discovered the **XML Signature Wrapping (XSW)** attack, where an attacker intercepts a legitimate SAML assertion and injects a malicious one into the XML structure — exploiting the fact that some parsers validate the signature on a *different* node than the one they actually process. This allowed attackers to authenticate as arbitrary users, including administrators, without ever knowing their passwords. Proper XSW mitigation requires validating that the signed element is exactly the element being consumed.

## Key facts
- SAML uses three roles: **Principal** (user), **Identity Provider** (IdP), and **Service Provider** (SP)
- Assertions are XML documents signed with **XML DSig**; if signature validation is misconfigured, replay or wrapping attacks succeed
- **Replay attacks** are mitigated using assertion IDs, short expiration windows (`NotOnOrAfter`), and one-time-use enforcement
- SAML assertions should be transmitted over **TLS only** — the XML signature protects integrity, not confidentiality
- Unlike OAuth/OIDC (designed for authorization), SAML is primarily an **authentication** protocol, commonly used in enterprise SSO federations

## Related concepts
[[Single Sign-On (SSO)]] [[XML Injection]] [[Federated Identity Management]] [[OAuth 2.0]] [[Man-in-the-Middle Attacks]]