# Azure Key Vault

## What it is
Think of it as a bank vault with a strict no-touch policy — the vault staff retrieve your valuables *for you*, but you never hold the master keys yourself. Azure Key Vault is a cloud-based Hardware Security Module (HSM)-backed service that centrally stores and manages secrets (passwords, API keys), cryptographic keys, and TLS/SSL certificates, ensuring applications never hardcode sensitive material into source code.

## Why it matters
In 2021, researchers discovered thousands of GitHub repositories leaking Azure storage keys and connection strings baked directly into application code — exactly the credential exposure Key Vault is designed to prevent. By granting an application a Managed Identity with Key Vault access, the app retrieves secrets at runtime without any credential ever appearing in code, configuration files, or environment variables, eliminating an entire class of secrets-sprawl attacks.

## Key facts
- **Three object types**: Secrets (arbitrary strings), Keys (RSA/EC cryptographic keys), and Certificates (managed PKI lifecycle) — each controlled independently via RBAC or access policies
- **HSM-backed tiers**: Standard tier uses software protection; Premium tier uses FIPS 140-2 Level 2 validated HSMs, meaning keys never leave hardware unencrypted
- **Managed Identity integration**: Azure resources (VMs, Functions, App Services) can authenticate to Key Vault without storing any credentials using system-assigned or user-assigned Managed Identities
- **Soft-delete and purge protection**: Deleted secrets enter a retention period (7–90 days) before permanent removal, defending against accidental or malicious deletion
- **Audit logging via Azure Monitor/Diagnostic Logs**: Every access attempt is logged, supporting least-privilege reviews and compliance requirements (PCI-DSS, HIPAA)

## Related concepts
[[Secrets Management]] [[Hardware Security Module (HSM)]] [[Managed Identity]] [[Role-Based Access Control (RBAC)]] [[Certificate Lifecycle Management]]