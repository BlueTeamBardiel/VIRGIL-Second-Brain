# Integrations

## What it is
Like a highway interchange connecting separate roads into a unified traffic system, integrations are the connections between distinct software platforms, APIs, and security tools that allow them to share data and coordinate actions. Precisely, integrations are interoperability mechanisms that link security systems — such as SIEMs, EDR platforms, ticketing tools, and threat feeds — so they can exchange telemetry, trigger automated responses, and present unified visibility across an environment.

## Why it matters
In the 2020 SolarWinds supply chain attack, adversaries exploited trusted integrations between SolarWinds Orion and downstream tools like Azure Active Directory and Microsoft 365 — legitimate API connections became the attack highway. Defenders who had mapped and monitored their integration trust relationships were faster to detect anomalous lateral movement traversing those authenticated channels. This illustrates that integrations expand both capability and attack surface simultaneously.

## Key facts
- **API keys and OAuth tokens** used by integrations are high-value credential targets; compromising one can grant access to multiple interconnected platforms
- **SOAR platforms** (Security Orchestration, Automation, and Response) depend entirely on integrations to pull alerts from SIEMs and push actions to firewalls, EDR, and ticketing systems
- **Third-party risk** applies here: a vendor integration may introduce vulnerabilities or excessive permissions into your environment even if your own code is clean
- **Least privilege** must be enforced on integration service accounts — many breaches escalate through over-permissioned API connections
- Integration failures (broken feeds, misconfigured webhooks) create **detection blind spots**, making availability of integrations a security — not just operational — concern

## Related concepts
[[API Security]] [[SOAR]] [[Supply Chain Attacks]] [[Third-Party Risk]] [[SIEM]]