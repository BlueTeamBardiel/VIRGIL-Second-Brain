# HashiCorp Vault

## What it is
Think of it as a bank vault where the vault itself issues temporary visitor badges instead of handing out permanent keys — access is time-limited and automatically revoked. HashiCorp Vault is an open-source secrets management tool that centrally stores, controls, and audits access to sensitive data like API keys, passwords, certificates, and encryption keys. It enforces dynamic secrets, meaning credentials are generated on-demand and expire automatically rather than sitting static in config files.

## Why it matters
In the 2019 Capital One breach, an SSRF vulnerability allowed an attacker to query AWS metadata and steal long-lived IAM credentials hardcoded in the environment — exactly the pattern Vault is designed to eliminate. If Vault had been managing those credentials with dynamic secrets and short TTLs, the stolen token would have expired before significant damage could occur. Organizations using Vault enforce least-privilege at the infrastructure level, not just on paper.

## Key facts
- **Dynamic Secrets**: Vault generates short-lived credentials per request (e.g., temporary AWS IAM tokens, database passwords) rather than storing static ones
- **Seal/Unseal mechanism**: Vault uses Shamir's Secret Sharing to split the master key — requiring a quorum of key holders (e.g., 3 of 5) to unseal the vault after restart
- **Auth methods**: Supports multiple authentication backends including LDAP, GitHub, AWS IAM, Kubernetes service accounts, and AppRole for machine-to-machine auth
- **Audit logging**: Every secret access is logged with identity, timestamp, and path — providing non-repudiation critical for CySA+ incident response
- **Transit secrets engine**: Acts as "encryption-as-a-service" — applications encrypt/decrypt data without ever seeing the encryption keys themselves

## Related concepts
[[Secrets Management]] [[Principle of Least Privilege]] [[Key Management Service]] [[Dynamic Credentials]] [[Zero Trust Architecture]]