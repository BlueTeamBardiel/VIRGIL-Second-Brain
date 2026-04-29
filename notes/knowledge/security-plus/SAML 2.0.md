# SAML 2.0

## What it is
Think of SAML like a notarized letter from your employer: your company's HR system stamps and signs a document proving who you are, and the bank accepts it without ever calling HR directly. Security Assertion Markup Language (SAML) 2.0 is an XML-based open standard that enables Single Sign-On (SSO) by allowing an Identity Provider (IdP) to issue cryptographically signed authentication assertions that Service Providers (SPs) trust and consume.

## Why it matters
In 2017, researchers demonstrated the "XML Signature Wrapping" (XSW) attack against SAML implementations, where an attacker intercepts a valid SAML assertion, duplicates the signed element, and injects a malicious unsigned assertion that the SP processes instead — effectively logging in as any user, including administrators. This attack has appeared in real breaches against cloud platforms and remains a critical validation flaw to understand for both offense and defense.

## Key facts
- SAML 2.0 defines three roles: the **Principal** (user), the **Identity Provider** (authenticates the user, e.g., Okta, ADFS), and the **Service Provider** (the application being accessed, e.g., Salesforce)
- Assertions are signed with **XML Digital Signatures** (typically RSA + SHA-256), but the SP must validate the signature on the correct element — failure to do so enables XSW attacks
- SAML uses **POST and Redirect bindings** to transmit assertions via the user's browser, meaning credentials never travel directly between IdP and SP
- A **SAML assertion** contains three statement types: Authentication, Attribute, and Authorization Decision statements
- SAML 2.0 is older and XML-heavy compared to **OAuth 2.0/OIDC**, making it more common in enterprise/legacy environments than modern web/mobile apps

## Related concepts
[[Single Sign-On (SSO)]] [[XML Injection]] [[OAuth 2.0]] [[Identity Provider (IdP)]] [[Federation]]