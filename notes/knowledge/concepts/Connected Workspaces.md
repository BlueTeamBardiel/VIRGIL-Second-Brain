# Connected Workspaces

## What it is
Think of a connected workspace like a power strip in a shared office — one outlet feeds everything, so if someone plugs in a bad device, the whole strip is at risk. A connected workspace is a collaborative digital environment where tools, users, cloud services, and endpoints are deeply integrated — platforms like Microsoft 365, Slack, or Notion where identity, data, and applications share persistent sessions and API trust relationships.

## Why it matters
In the 2022 Slack breach at Rockstar Games, threat actors leveraged stolen employee credentials to access a connected Slack workspace and exfiltrate GTA VI footage — the integration between Slack, internal repositories, and SSO made lateral movement trivially easy once one account was compromised. Connected workspaces collapse traditional network perimeters, meaning a single phished credential can unlock dozens of linked services simultaneously.

## Key facts
- Connected workspaces typically rely on **OAuth 2.0 and SAML-based SSO**, meaning one identity provider (IdP) compromise cascades across all integrated apps
- **Third-party app integrations** (bots, plugins, webhooks) are a major attack surface — each granted OAuth scope is a potential persistence mechanism
- **Data Loss Prevention (DLP)** controls must be configured at the workspace level, not just the endpoint, since sharing happens natively within the platform
- **Audit logging** of workspace activity (file access, sharing events, login locations) is critical for forensic investigation under CySA+ incident response objectives
- Zero Trust principles require **continuous session validation** rather than trusting persistent workspace sessions, mitigating token theft attacks

## Related concepts
[[Single Sign-On (SSO)]] [[OAuth 2.0]] [[Data Loss Prevention]] [[Third-Party Risk Management]] [[Zero Trust Architecture]]