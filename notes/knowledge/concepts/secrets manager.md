# secrets manager

## What it is
Think of it like a bank vault with an automated teller — applications can request credentials on demand without ever knowing where they're stored or how they're rotated. A secrets manager is a dedicated system that stores, controls access to, and automatically rotates sensitive credentials (API keys, passwords, certificates, database strings) so they never appear hardcoded in source code or configuration files.

## Why it matters
In 2022, attackers routinely scanned public GitHub repositories for hardcoded AWS keys and database passwords — sometimes within minutes of accidental commits — and drained cloud accounts or exfiltrated databases before developers noticed. Organizations using a secrets manager like HashiCorp Vault or AWS Secrets Manager would have had no static credential to steal; the application fetches a short-lived token at runtime that expires before an attacker can weaponize it.

## Key facts
- **Secrets sprawl** is the risk that credentials exist in multiple uncontrolled locations (env files, CI/CD pipelines, chat logs) — secrets managers create a single authoritative source
- Automatic **rotation** breaks the assumption that a stolen credential remains valid indefinitely; rotation intervals can be as short as hours
- Access is governed by **least-privilege policies** — each application identity gets only the secrets it needs, auditable via logs
- Secrets managers provide a full **audit trail**: who requested which secret, when, and from where — critical for incident response and compliance (SOC 2, PCI-DSS)
- **Dynamic secrets** (a key feature of tools like Vault) generate unique, ephemeral credentials per request, meaning no two application instances share the same password

## Related concepts
[[principle of least privilege]] [[credential stuffing]] [[key management]] [[zero trust architecture]] [[certificate lifecycle management]]