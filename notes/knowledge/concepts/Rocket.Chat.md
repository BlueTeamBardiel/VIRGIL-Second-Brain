# Rocket.Chat

## What it is
Think of it as Slack, but one you install in your own basement — you own the server, the data, and the risk. Rocket.Chat is an open-source, self-hosted team collaboration platform supporting messaging, video calls, and file sharing, deployable on-premises or in private cloud environments.

## Why it matters
In 2023, attackers exploited CVE-2023-2108, an unauthenticated remote code execution vulnerability in Rocket.Chat, allowing threat actors to execute arbitrary commands on unpatched servers without any credentials. Organizations running outdated self-hosted instances became entry points for ransomware deployment and lateral movement, illustrating the dangerous tradeoff between data sovereignty and patch management discipline.

## Key facts
- **CVE-2023-2108**: Critical RCE vulnerability (CVSS 9.8) affecting Rocket.Chat versions prior to 6.3.4, 6.2.10, and 5.4.10 — exploitable without authentication.
- Self-hosted deployment means **the organization is responsible for patching**, unlike SaaS platforms where the vendor manages updates automatically.
- Rocket.Chat uses **MongoDB** as its backend database — misconfigured or exposed MongoDB instances can lead to full data exfiltration.
- End-to-end encryption (E2EE) is available but **disabled by default** and must be explicitly configured per channel, creating false security assumptions.
- Commonly targeted in **supply chain and insider threat scenarios** due to message history containing sensitive credentials, API keys, and internal documents shared over chat.

## Related concepts
[[Remote Code Execution (RCE)]] [[Patch Management]] [[Self-Hosted Infrastructure Security]]