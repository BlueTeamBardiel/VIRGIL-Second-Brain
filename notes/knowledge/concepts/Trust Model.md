# Trust Model

## What it is
Like a medieval castle with a drawbridge — once you're inside the walls, you were historically trusted to roam freely — a trust model defines *who* or *what* gets believed, and *how much*, within a system or network. Formally, it is the framework that determines how entities (users, devices, certificates, systems) establish and extend trust to one another, including the rules, authorities, and verification mechanisms that govern those relationships.

## Why it matters
The 2020 SolarWinds attack exposed the danger of implicit trust models: because the Orion software update process was inherently trusted by thousands of networks, malicious code rode that trust straight past perimeter defenses into sensitive government and corporate systems. Adopting a Zero Trust model — where no entity is trusted by default, even inside the network — would have forced continuous verification and dramatically limited lateral movement.

## Key facts
- **Three common models**: Hierarchical (PKI with a root CA), Web of Trust (PGP, peers vouch for each other), and Zero Trust (verify every request, every time, assume breach)
- **Transitive trust** means if A trusts B and B trusts C, A may implicitly trust C — a dangerous property exploited in domain and forest trust attacks in Active Directory
- **Certificate Authorities (CAs)** are the anchors of hierarchical trust; a compromised CA (e.g., DigiNotar, 2011) can collapse trust across the entire model
- **Zero Trust** is formalized in NIST SP 800-207 and relies on identity verification, least privilege, and microsegmentation rather than network location
- Trust models underpin **federated identity** systems (SAML, OAuth) — misconfigured trust between identity providers is a common exploitation vector

## Related concepts
[[Zero Trust Architecture]] [[Public Key Infrastructure]] [[Certificate Authority]] [[Federated Identity]] [[Lateral Movement]]