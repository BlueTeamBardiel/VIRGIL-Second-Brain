# Mattermost

## What it is
Think of Mattermost as Slack but with the server living in *your* data center instead of someone else's cloud. It is an open-source, self-hosted team messaging and collaboration platform that organizations deploy internally to maintain full control over their communication data, supporting channels, direct messages, and file sharing.

## Why it matters
In 2022, misconfigured Mattermost instances exposed to the public internet allowed unauthenticated API access, enabling attackers to enumerate users, read channel messages, and exfiltrate sensitive internal communications without any credentials. This highlights a recurring theme: self-hosted collaboration tools shift security responsibility entirely to the organization, and a forgotten `/api/v4/users` endpoint left open is as dangerous as a leaked SaaS credential.

## Key facts
- Mattermost is frequently deployed in high-security environments (government, defense contractors) precisely because it avoids third-party data custody — but misconfiguration risks replace vendor-trust risks
- Default installations may expose REST API endpoints that allow user enumeration if not properly firewalled or authenticated
- Supports SAML 2.0 and LDAP/AD integration, making it a target for credential-based attacks if SSO is misconfigured
- Webhook integrations (incoming/outgoing) are a common attack surface — compromised webhook tokens can allow message injection or data exfiltration from automated pipelines
- CVE-2022-21724 and related vulnerabilities demonstrated that plugin systems in Mattermost can be abused for remote code execution if admin credentials are compromised

## Related concepts
[[Self-Hosted Infrastructure Security]] [[API Security]] [[SAML Authentication]] [[Webhook Security]] [[Insider Threat]]