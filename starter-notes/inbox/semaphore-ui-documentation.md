# Semaphore UI Documentation

Semaphore UI is a modern, open-source web UI and API for running automation with [[Ansible]], [[Terraform]]/[[OpenTofu]], [[PowerShell]], [[Shell]]/[[Bash]], and [[Python]]. Written in Go and supports Windows, macOS, and Linux with SQLite, MySQL, and PostgreSQL backends.

## Core Concepts

- **Project**: Main unit of separation (teams/infrastructures/applications)
- **Repository**: Source control for playbooks/modules/scripts
- **Inventory**: Hosts, groups, and connection settings for Ansible-style runs
- **Variable Group (Environment)**: Reusable variables and configuration per project
- **Key Store**: Encrypted credentials (SSH keys, tokens, passwords)
- **Task/Task Template**: Definition and execution of automation
- **Runner**: Execution environment (local or remote)

## Admin Setup Path

1. [[Installation]]
2. [[Configuration]] + initial admin user
3. [[Security]], [[LDAP and AD]], [[OpenID Connect]]
4. [[Runners]] for remote execution
5. [[High Availability]] for enterprise setups
6. [[Notifications]], [[Logs]]

## User Workflows

- Create [[Projects]] and manage [[Teams]]
- Connect [[Repositories]] for source code
- Configure [[Inventory]] for targets
- Set up [[Variable Groups]] for configuration
- Store secrets in [[Key Store]]
- Create and run [[Tasks]] and [[Task Templates]]
- Schedule automation with [[Schedules]]
- Integrate with external tools via [[Integrations]]

## Common Use Cases

- CI/CD pipelines (build, deploy, rollback)
- Distributed execution at scale
- Programmatic automation via [[API]]
- CLI management for setup and migrations

## Resources

- Community: Discord
- Issues: GitHub Issues
- Source: GitHub

## Tags

#automation #infrastructure #ansible #terraform #devops #documentation

---
_Ingested: [[2026-04-15]] 20:54 | Source: https://docs.semaphoreui.com/_
