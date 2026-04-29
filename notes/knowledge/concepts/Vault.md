# Vault

## What it is
Think of a bank vault with time-locked doors, individual safety deposit boxes, and a detailed log of every person who touched anything — HashiCorp Vault works exactly like that, but for secrets in software systems. It is a secrets management tool that centrally stores, controls access to, and dynamically generates sensitive data such as API keys, passwords, TLS certificates, and database credentials. Unlike static credential files scattered across servers, Vault enforces identity-based access and produces short-lived, auto-expiring secrets.

## Why it matters
In the 2019 Capital One breach, an attacker exploited a misconfigured WAF to access an AWS IAM role, then harvested static credentials stored in environment variables and config files — exactly the kind of sprawl Vault is designed to eliminate. Had dynamic secrets been used, credentials would have expired within minutes, dramatically limiting the blast radius. Vault's audit log would also have generated forensic evidence of the unauthorized access in real time.

## Key facts
- **Dynamic secrets**: Vault generates on-demand, time-limited credentials (e.g., a database login that auto-revokes after 1 hour), eliminating long-lived static passwords
- **Secret leases**: Every secret has a TTL (Time To Live); clients must renew or the secret is automatically revoked
- **Seal/Unseal mechanism**: Vault starts "sealed" and requires a quorum of key shares (Shamir's Secret Sharing) to unseal — no single admin holds the master key
- **Auth backends**: Vault integrates with LDAP, AWS IAM, Kubernetes service accounts, and certificates to verify identity before issuing secrets
- **Audit devices**: Every request and response is logged to an audit backend, supporting non-repudiation and compliance requirements like PCI-DSS and SOC 2

## Related concepts
[[Secrets Management]] [[Privileged Access Management]] [[Zero Trust Architecture]] [[Key Management Service]] [[Least Privilege]]