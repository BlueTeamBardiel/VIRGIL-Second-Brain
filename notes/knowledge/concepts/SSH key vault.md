# SSH key vault

## What it is
Think of it like a bank's safe deposit box room — instead of everyone carrying their valuables around, keys are stored in a single secured, audited location managed by trained staff. An SSH key vault is a centralized secrets management system (such as HashiCorp Vault or CyberArk) that stores, rotates, and brokers SSH private keys so no individual or service ever holds a long-lived credential directly.

## Why it matters
In the 2020 SolarWinds attack, attackers moved laterally through networks partly by harvesting SSH keys found on compromised systems — static, unrotated keys with no audit trail. An SSH key vault prevents this by issuing short-lived, signed SSH certificates on demand, so there are no persistent private keys sitting on disk for an attacker to steal.

## Key facts
- SSH key vaults can issue **SSH certificates** (signed by a CA) instead of raw keys, allowing automatic expiration and revocation without touching `authorized_keys` files on every server
- **Just-in-time (JIT) access** is a core capability — credentials are issued only when needed and expire automatically, shrinking the window of opportunity for attackers
- All key requests and usage are **logged and auditable**, supporting NIST 800-53 AC-2 (Account Management) and AU-2 (Audit Events) controls
- Vaults enforce **separation of duties**: developers request access, security teams approve it, and the vault brokers it — no human ever sees the raw private key
- Rotation of SSH keys becomes automated and continuous, eliminating **SSH key sprawl** — a common finding in enterprise audits where thousands of untracked authorized keys exist across servers

## Related concepts
[[SSH Public Key Authentication]] [[Privileged Access Management]] [[Secrets Management]] [[Certificate Authority]] [[Just-In-Time Access]]