# Semaphore UI

## What it is
Think of it as a cockpit dashboard for an airline pilot — instead of manually flipping switches and reading raw gauges, everything critical is surfaced in one visual panel. Semaphore UI is an open-source web-based interface for Ansible, Terraform, and other infrastructure automation tools, allowing teams to manage, schedule, and audit playbook execution without touching the command line. It wraps automation backends in a browser-accessible control plane with role-based access and task history.

## Why it matters
In 2023, misconfigured automation dashboards became a recognized attack surface: an exposed Semaphore instance with default credentials or no authentication gives an attacker the ability to execute arbitrary Ansible playbooks across an entire infrastructure fleet — effectively handing them a remote code execution engine pointed at every managed host. A defender properly deploying Semaphore would enforce MFA, restrict it behind a VPN, and audit task execution logs to detect unauthorized playbook runs.

## Key facts
- Semaphore UI runs on port **3000** by default and requires explicit hardening to avoid internet exposure
- It supports **role-based access control (RBAC)** — separating who can view vs. execute vs. administer playbooks
- All task runs are logged with user attribution, supporting **audit trail requirements** under frameworks like PCI-DSS and SOC 2
- Credentials (SSH keys, API tokens, vault passwords) are stored in Semaphore's **Key Store** — a high-value target if the application is compromised
- Because Semaphore executes playbooks with the privileges of the service account, **privilege escalation** is a critical risk if the underlying account is over-permissioned

## Related concepts
[[Ansible Security Hardening]] [[Infrastructure as Code Security]] [[Privileged Access Management]] [[Credential Store Attacks]] [[RBAC]]