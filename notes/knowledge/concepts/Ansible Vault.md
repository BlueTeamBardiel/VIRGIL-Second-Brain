# Ansible Vault

## What it is
Think of it as a combination safe built directly into your automation toolbelt — you can lock sensitive data inside your playbooks without pulling them out of version control. Ansible Vault is a built-in encryption feature of the Ansible automation platform that uses AES-256 to encrypt sensitive files, variables, or strings (passwords, API keys, certificates) so they can be safely stored alongside code in repositories like Git.

## Why it matters
In 2021, security researchers routinely found AWS secret keys and database passwords committed in plaintext to public GitHub repositories — a leading cause of cloud breaches. Ansible Vault directly addresses this by allowing DevOps teams to encrypt secrets at rest while still executing automated infrastructure deployments, meaning a leaked Git repository no longer automatically means compromised credentials.

## Key facts
- Uses **AES-256** symmetric encryption; the vault password itself is the key derivation seed
- Entire files **or** individual variable values can be encrypted using `ansible-vault encrypt` and `ansible-vault encrypt_string` respectively
- Vault passwords can be supplied via a **password file**, an **environment variable**, or an interactive prompt — enabling CI/CD pipeline integration
- Multiple vault IDs allow **different passwords for different sensitivity tiers** (e.g., dev vs. production secrets) within the same project
- Encrypted content is **Base64-encoded** and tagged with a header (`$ANSIBLE_VAULT;1.1;AES256`) making vault files identifiable but not directly readable

## Related concepts
[[Secrets Management]] [[AES-256 Encryption]] [[Infrastructure as Code Security]] [[Principle of Least Privilege]] [[Key Management]]