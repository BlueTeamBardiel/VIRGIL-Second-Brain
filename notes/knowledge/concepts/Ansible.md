# Ansible

## What it is
Think of Ansible like a conductor sending sheet music to an entire orchestra simultaneously — every instrument plays the same notes, in the same order, without the conductor touching a single instrument. Precisely: Ansible is an agentless, open-source IT automation tool that uses SSH to push configuration states (written in YAML "playbooks") to managed nodes, enforcing consistency across infrastructure without requiring software installed on targets.

## Why it matters
In 2021, misconfigured Ansible playbooks exposed AWS credentials and API keys in public GitHub repositories, allowing attackers to harvest secrets and pivot into cloud environments. Defensively, Ansible is critical for rapid incident response — security teams can push firewall rule updates, revoke compromised SSH keys, or patch a CVE across 10,000 servers in minutes using a single playbook execution.

## Key facts
- **Agentless architecture**: Uses SSH (Linux) or WinRM (Windows) — no persistent agent means reduced attack surface compared to tools like Puppet or Chef
- **Idempotent by design**: Running the same playbook multiple times produces identical results — critical for maintaining known-good configuration baselines (CIS Benchmarks)
- **Inventory files**: Define which hosts Ansible manages; a compromised or misconfigured inventory file can expose entire network topology
- **Ansible Vault**: Built-in encryption feature for storing secrets (passwords, API keys) in playbooks — failure to use it is a common finding in security audits
- **Privilege escalation**: Playbooks often run with `become: yes` (sudo) — if the Ansible control node is compromised, an attacker inherits elevated access on every managed host

## Related concepts
[[Configuration Management]] [[Infrastructure as Code]] [[Privileged Access Management]] [[SSH Security]] [[Secrets Management]]