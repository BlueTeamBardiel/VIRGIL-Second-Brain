# Managing Trusts

## What it is
Like a bouncer who waves in guests from a partnered club without checking IDs, a trust relationship allows one domain or system to automatically accept authentication credentials from another. In Active Directory and PKI environments, a **trust** is a configured relationship that grants users or services in one domain access to resources in another without requiring separate credentials.

## Why it matters
In the infamous SolarWinds supply chain attack, attackers leveraged transitive trust relationships in federated identity systems to move laterally from compromised on-premises AD environments into Azure AD tenants — essentially using one trusted door to walk through many others. Misconfigured or forgotten trust relationships are a primary lateral movement vector in enterprise environments, because attackers who compromise a low-value trusted domain can pivot into high-value trusting domains.

## Key facts
- **Transitive trusts** extend automatically (A trusts B, B trusts C → A trusts C); **non-transitive trusts** are contained to exactly two domains
- **One-way trusts**: the trusting domain allows access to its resources; users originate from the trusted domain — direction matters for exam questions
- **Forest trusts** in AD connect entire forests; **external trusts** connect individual domains across forests without transitivity
- Regularly **auditing and pruning** stale trusts reduces attack surface — forgotten trusts are commonly exploited in penetration tests
- In PKI, certificate trust chains follow the same principle: a root CA that is trusted implicitly trusts all intermediate CAs it signs, making root CA compromise catastrophic

## Related concepts
[[Active Directory]] [[Federated Identity]] [[Lateral Movement]] [[Kerberos]] [[Certificate Authority]]