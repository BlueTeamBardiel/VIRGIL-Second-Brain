# SaaS

## What it is
Like renting a fully furnished apartment instead of buying a house — you get immediate use without owning or maintaining the infrastructure. Software as a Service (SaaS) delivers applications over the internet where the vendor manages everything: infrastructure, platform, runtime, and the application itself. The customer only controls their data and user access configurations.

## Why it matters
In 2023, attackers compromised Microsoft 365 (a SaaS platform) by stealing OAuth tokens, bypassing MFA entirely and accessing email without touching a single on-premises system. This illustrates the core SaaS security challenge: your attack surface shifts from servers you control to identity credentials, API tokens, and third-party integrations you must govern carefully.

## Key facts
- **Shared responsibility model**: In SaaS, the vendor owns security *of* the platform; the customer owns security *in* the platform (user accounts, data classification, access controls)
- **Primary attack vectors**: Credential stuffing, OAuth token theft, misconfigured sharing settings, and malicious third-party app integrations
- **Data sovereignty risk**: Customer data resides on vendor infrastructure, creating compliance exposure under GDPR, HIPAA, or PCI-DSS if the vendor operates across jurisdictions
- **CASB (Cloud Access Security Broker)** is the primary defensive control for monitoring and enforcing policy on SaaS usage, including shadow IT discovery
- **Federated identity (SSO/SAML)** is the recommended authentication architecture for SaaS — centralizing access control reduces orphaned accounts and credential sprawl

## Related concepts
[[Cloud Service Models]] [[Shared Responsibility Model]] [[CASB]] [[OAuth]] [[Identity and Access Management]] [[Shadow IT]]