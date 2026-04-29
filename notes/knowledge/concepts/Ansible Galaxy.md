# Ansible Galaxy

## What it is
Think of it like npm or PyPI, but for IT automation roles — a public marketplace where sysadmins share pre-built Ansible "roles" (reusable configuration packages) that others can download and run against their infrastructure. Ansible Galaxy is Red Hat's official hub for discovering, sharing, and downloading Ansible content collections and roles to automate configuration management, application deployment, and security hardening tasks.

## Why it matters
A defender can pull a pre-built CIS benchmark hardening role from Ansible Galaxy and deploy it across hundreds of Linux servers in minutes — enforcing STIG compliance, disabling unnecessary services, and configuring auditd without writing a single line of code from scratch. However, this same convenience is a supply chain attack surface: a malicious actor can publish a role with a trusted-sounding name (typosquatting "geerlingguy.security" vs the legitimate package), and an administrator who runs it with elevated privileges has effectively handed over root access to every managed node.

## Key facts
- Roles are downloaded via `ansible-galaxy install <namespace.role_name>` and stored in `~/.ansible/roles/` by default
- Galaxy content runs with the same privilege level as the Ansible playbook — if using `become: yes`, that's full root on all managed nodes
- Supply chain risk: Galaxy roles are community-contributed and not cryptographically signed by default; always audit `tasks/main.yml` before execution
- Ansible Collections (the modern format replacing standalone roles) bundle roles, modules, and plugins together — Galaxy hosts both formats
- Organizations should mirror trusted Galaxy content to a private Automation Hub (Red Hat) to prevent dependency confusion attacks in production environments

## Related concepts
[[Supply Chain Attack]] [[Configuration Management]] [[Privilege Escalation]] [[Infrastructure as Code]] [[Dependency Confusion]]