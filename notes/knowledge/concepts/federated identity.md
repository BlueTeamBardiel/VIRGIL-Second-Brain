# federated identity

## What it is
Think of it like a passport: one document issued by your home country (identity provider) that dozens of foreign countries (service providers) agree to honor without making you apply for local citizenship each time. Federated identity is a system where a trusted Identity Provider (IdP) authenticates a user once, and multiple independent Service Providers (SPs) accept that assertion to grant access — without each SP managing its own credentials.

## Why it matters
In 2020, the SolarWinds attackers forged SAML tokens after compromising an on-premises Active Directory Federation Services (ADFS) server — a technique called "Golden SAML." Because federated trust was established between the on-prem IdP and Microsoft 365 cloud services, the forged tokens granted persistent, stealthy access to cloud resources without any password being stolen, demonstrating that compromising the IdP breaks the entire trust chain simultaneously.

## Key facts
- **Core protocols**: SAML 2.0 (XML-based, common in enterprise SSO), OAuth 2.0 (authorization delegation), and OpenID Connect (identity layer on top of OAuth) are the dominant standards
- **Trust anchor risk**: The IdP is a single point of catastrophic failure — if it's compromised, every federated SP is exposed
- **Assertions vs. credentials**: The SP never sees the user's password; it receives a signed XML/JWT *assertion* from the IdP confirming identity and attributes
- **Cross-domain SSO**: Federated identity enables SSO *across organizational boundaries* (e.g., a partner company's employees accessing your portal), distinguishing it from internal SSO alone
- **Security+ relevance**: Expect questions pairing federation with SAML, IdP/SP roles, and the concept of transitive trust between organizations

## Related concepts
[[SAML]] [[single sign-on]] [[OAuth]] [[OpenID Connect]] [[trust relationship]]