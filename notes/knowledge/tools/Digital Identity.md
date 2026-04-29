# Digital Identity

## What it is
Think of digital identity like a passport plus your entire travel history — it's not just who you claim to be, but the accumulated proof that validates the claim. Precisely, digital identity is the collection of attributes, credentials, and behavioral data that uniquely represent an entity (person, device, or service) within a digital system. It encompasses usernames, certificates, biometrics, tokens, and contextual signals used to authenticate and authorize access.

## Why it matters
In the 2020 SolarWinds breach, attackers forged SAML tokens to impersonate legitimate user identities within federated authentication systems — bypassing passwords entirely because the identity itself was counterfeited. This illustrates why digital identity is the real attack surface: compromise the identity layer and credentials become irrelevant. Defenders now deploy continuous identity verification and anomaly detection rather than relying solely on initial login checks.

## Key facts
- Digital identity is governed by three pillars: **something you know, have, or are** — mapped to passwords, tokens, and biometrics respectively
- **Federated identity** (SAML, OAuth, OpenID Connect) allows one identity provider to assert identity across multiple services — one compromised IdP affects all relying parties
- **Non-repudiation** is a core property of strong digital identity — cryptographic signatures ensure an entity cannot deny performing an action
- The **Identity Assurance Level (IAL)** framework (NIST SP 800-63) classifies how rigorously an identity was verified at enrollment: IAL1 (self-asserted) through IAL3 (in-person proofing)
- **Privilege creep** — accumulated permissions over time — is a direct consequence of poor digital identity lifecycle management and a top audit finding

## Related concepts
[[Multi-Factor Authentication]] [[Federated Identity Management]] [[Privileged Access Management]] [[Zero Trust Architecture]] [[Certificate Authority]]