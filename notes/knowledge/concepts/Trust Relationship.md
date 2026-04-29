# Trust Relationship

## What it is
Like a bouncer who lets anyone in wearing a VIP wristband from a partner club — no questions asked — a trust relationship is a configuration where one system automatically grants access or authentication to users/processes validated by another system. Formally, it's a security model that allows principals authenticated in one domain to access resources in another domain without re-authenticating, based on a pre-established agreement between the domains.

## Why it matters
In the 2020 SolarWinds attack, adversaries exploited federated trust relationships between on-premises Active Directory and Azure AD — once inside the on-prem environment, they forged SAML tokens to pivot laterally into cloud resources that trusted the on-prem identity provider. This demonstrates how a single compromised trusted anchor can cascade across every system that inherits that trust.

## Key facts
- **Transitive trust**: If Domain A trusts Domain B, and Domain B trusts Domain C, then Domain A may implicitly trust Domain C — a critical attack surface in Active Directory forests.
- **One-way vs. two-way trust**: One-way trust means only one domain accepts authentication from the other; two-way (bidirectional) trust allows both domains to authenticate each other's users.
- **Kerberoasting and Golden Ticket attacks** specifically exploit trust relationships within AD to move laterally across domain boundaries.
- **Federated identity** (SAML, OAuth) extends trust relationships across organizational boundaries — third-party IdP compromise inherits trust from every relying party.
- **Principle of least privilege** applies to trust: trust should be scoped to the minimum necessary resources, not granted domain-wide by default.

## Related concepts
[[Active Directory]] [[Kerberos Authentication]] [[Federated Identity]] [[Lateral Movement]] [[SAML]]