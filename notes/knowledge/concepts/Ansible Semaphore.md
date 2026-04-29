# Ansible Semaphore

## What it is
Think of it as a cockpit dashboard for a pilot who previously had to flip switches blindfolded from a terminal — Ansible Semaphore is an open-source web UI that wraps Ansible automation, giving teams a visual interface to schedule playbooks, manage inventories, and control access without touching the command line. It acts as a self-hosted alternative to Ansible Tower/AWX, exposing Ansible's infrastructure automation through role-based access and an audit-friendly GUI.

## Why it matters
In a 2023-style supply chain attack scenario, an adversary who compromises a Semaphore instance gains the ability to execute arbitrary Ansible playbooks across an entire infrastructure — potentially deploying backdoors or exfiltrating secrets stored in vaults. Because Semaphore centralizes privileged automation credentials (SSH keys, API tokens), it becomes a high-value lateral movement pivot point if left unpatched or exposed to the internet without authentication hardening.

## Key facts
- Semaphore stores sensitive data including SSH private keys and vault passwords; compromise of the Semaphore database equals compromise of managed infrastructure
- Default deployments may expose the web UI on port **3000** without TLS — a common misconfiguration found during penetration tests
- Role-based access control (RBAC) in Semaphore separates Admin, Manager, and Runner roles, limiting blast radius if a low-privilege account is hijacked
- Semaphore integrates with **LDAP** and can use external authentication, making it subject to the same credential-stuffing risks as any enterprise web app
- All task executions are logged, making Semaphore a useful forensic artifact source during incident response to reconstruct what automation ran and when

## Related concepts
[[Ansible Playbooks]] [[Privilege Escalation]] [[Secrets Management]] [[Role-Based Access Control]] [[Infrastructure as Code Security]]