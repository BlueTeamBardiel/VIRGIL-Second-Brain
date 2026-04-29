# Connected Workspaces API

## What it is
Think of it like a master key ring where every SaaS app in your office — Slack, GitHub, Jira, Notion — hangs on the same ring, and one stolen key opens all doors. A Connected Workspaces API is an integration layer that allows multiple productivity and collaboration platforms to share data, authenticate users, and trigger actions across services using a unified API surface. It typically leverages OAuth tokens, webhooks, and shared identity providers to orchestrate workflows between otherwise siloed applications.

## Why it matters
In 2023, attackers compromised a single OAuth token issued via a connected workspace integration to pivot from a project management tool into a code repository, exfiltrating source code without ever touching the primary codebase directly. This is the classic "living off trusted integrations" attack — the API itself becomes the lateral movement corridor because security teams monitor apps but rarely audit the API bridges between them.

## Key facts
- Connected workspace APIs commonly use **OAuth 2.0** with overly broad scopes (e.g., `repo:write`, `files:read`) — scope creep is a primary misconfiguration risk
- **Third-party app integrations** granted via these APIs often persist long after the originating user leaves an organization, creating orphaned access tokens
- Webhooks in these ecosystems can be weaponized for **data exfiltration** by routing sensitive event payloads to attacker-controlled endpoints
- **Least privilege principle violations** are endemic — integrations frequently request admin-level permissions when read-only access suffices
- From a CySA+ perspective, auditing connected app inventories and **revoking unused OAuth grants** is a critical hardening control in SaaS environments

## Related concepts
[[OAuth 2.0]] [[Third-Party Risk Management]] [[API Security]] [[Lateral Movement]] [[Scope Creep]]