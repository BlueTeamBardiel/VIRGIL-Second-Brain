# SAML

## What it is
Think of SAML like a notarized letter from your university that a bank accepts as proof of your identity — you never hand the bank your university password, just a signed document they trust. Security Assertion Markup Language (SAML) is an XML-based open standard that enables Single Sign-On (SSO) by allowing an **Identity Provider (IdP)** to pass authentication assertions to a **Service Provider (SP)**. The SP trusts the IdP's signed XML token instead of managing credentials itself.

## Why it matters
In 2017, researchers discovered a SAML vulnerability called the "XML Signature Wrapping" attack, where an attacker could manipulate the XML structure so the signature validation passed while the actual authenticated username was swapped to an admin account. This allowed full account takeover on services like GitHub Enterprise and Duo without knowing any credentials — a devastating flaw that highlights why XML parsing logic, not just cryptography, must be hardened.

## Key facts
- SAML has three roles: **Principal** (user), **Identity Provider** (authenticates the user), and **Service Provider** (the application granting access)
- Assertions are XML documents signed with **XML Digital Signatures** using the IdP's private key; the SP validates using the IdP's public certificate
- SAML is commonly used in **enterprise federated identity** scenarios (e.g., logging into Salesforce using your corporate Active Directory credentials)
- SAML 2.0 (2005) is the current standard — exam questions almost always mean SAML 2.0
- The **HTTP POST binding** is the most common SAML flow: the browser carries the base64-encoded assertion between IdP and SP, making the user's browser an untrusted relay

## Related concepts
[[Single Sign-On]] [[OAuth]] [[OpenID Connect]] [[Federation]] [[XML Digital Signatures]]