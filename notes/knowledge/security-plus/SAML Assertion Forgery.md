# SAML Assertion Forgery

## What it is
Imagine a bouncer accepting a VIP wristband that anyone can print at home because the ink is never checked. SAML assertion forgery occurs when an attacker crafts or manipulates a Security Assertion Markup Language (SAML) XML token to impersonate a legitimate user without valid credentials. The attack exploits weaknesses in how Identity Providers (IdPs) or Service Providers (SPs) validate the cryptographic signatures on these assertions.

## Why it matters
In 2018, researchers disclosed a widespread XML signature wrapping vulnerability affecting SAML implementations across multiple cloud platforms — including AWS, Google, and OneLogin — allowing attackers to authenticate as any user, including administrators, by injecting a forged comment node into a signed assertion. A single unauthenticated attacker could gain full administrative access to an organization's cloud environment simply by manipulating the XML structure, with the signature remaining technically "valid" on the original (now irrelevant) node.

## Key facts
- **XML Signature Wrapping (XSW)** is the most common SAML forgery technique — the signature is valid, but the IdP signs a different element than the SP evaluates
- SAML assertions must be validated for **integrity (signature), authenticity (issuer), and freshness (NotOnOrAfter timestamp)** — failing any one check enables forgery
- Attackers who compromise the **IdP's private signing key** can forge unlimited, fully valid assertions for any SP in the federation
- SAML responses should be validated against a **strict schema and XPath** to prevent injection of rogue assertion elements
- CVE-2017-11427 through CVE-2017-11430 document real-world XSW flaws in major SAML libraries (python-saml, ruby-saml)

## Related concepts
[[XML Signature Wrapping]] [[SAML Authentication Flow]] [[Single Sign-On (SSO)]] [[Identity Provider Compromise]] [[JWT Forgery]]