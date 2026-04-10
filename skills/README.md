# skills/

> [[VIRGIL]] skill context files — JSON snapshots loaded into [[Claude]] sessions to provide deep [[your-lab]] context without re-deriving it from scratch

Each `.json` file is a structured knowledge dump that can be loaded via [[LOGOS]] or passed directly to a Claude Code session. They encode the state of a specific system, playbook, or procedure at a point in time so that future sessions start with full context.

---

## Master Context Files

### lab_master.json
**What it loads:** Full [[your-lab]] fleet snapshot — network topology, all devices with IPs and roles, [[Ansible]] inventory, project status, session history, and snapshot metadata.
**When to use:** Opening a new session that will touch multiple hosts or needs the full lab picture. The broadest context file.

### lab_master_context.json
**What it loads:** Ansible/[[Semaphore]] infrastructure context — control node config, git setup, Semaphore settings, fleet roles, all deployed playbooks, fleet status as of 2026-04-02, and troubleshooting notes.
**When to use:** Sessions focused on [[Ansible]] playbook development, Semaphore UI operations, or fleet-wide changes.

---

## Procedure Files

### lab_vnc_procedure.json
**What it loads:** Step-by-step procedure for making [[your-control-node]] a stable headless Linux Mint jump host with SSH + persistent GUI via x11vnc. Includes networking config, successful steps, known pitfalls, and recommended next steps.
**When to use:** Setting up VNC on YOUR-CONTROL-NODE again, troubleshooting headless GUI issues, or replicating the setup on another host.

### lab_ansible_semaphore_setup.json
**What it loads:** Full Ansible + [[Semaphore]] setup procedure — lessons learned, prerequisites, git integration, inventory config, repository setup, playbook list, cron schedule setup, and troubleshooting.
**When to use:** Re-setting up Semaphore, onboarding a new control node, or debugging Semaphore–Ansible integration.

### lab_fastfetch_deployment.json
**What it loads:** Fastfetch fleet deployment — meta, per-host config files, playbook structure, template variables, aarch64 support notes, ASCII art, and the procedure for adding a new host.
**When to use:** Adding a new host to the fastfetch fleet, modifying the color scheme, or re-deploying after a system rebuild.

---

## Playbook Files

Each playbook file contains `instructions_for_claude`, the playbook YAML, Semaphore job config, notes, git workflow, and fleet status. Load before working on or running that playbook.

| File | Playbook | Purpose |
|------|----------|---------|
| `lab_playbook_apt_upgrade.json` | apt-upgrade | Fleet-wide `apt upgrade` via [[Ansible]] |
| `lab_playbook_config_backup.json` | config-backup | Back up host configs to git |
| `lab_playbook_fail2ban.json` | fail2ban | Deploy and configure [[fail2ban]] fleet-wide |
| `lab_playbook_new_host_bootstrap.json` | new-host-bootstrap | Full onboarding: user, SSH, [[UFW]], fail2ban, fastfetch |
| `lab_playbook_port_scan.json` | port-scan | Nmap scan all fleet hosts, record results |
| `lab_playbook_ufw.json` | ufw | Deploy and configure [[UFW]] fleet-wide |

---

## How to Load a Skill File

**Via [[LOGOS]]** (recommended): LOGOS will load the appropriate JSON into your next Claude session based on your task description.

**Manually:** Reference the file path at the start of a session:
```
Load skills/lab_master.json before we start — working on your lab fleet.
```

**Direct API:** Pass the JSON content as a system prompt or initial user message when calling the [[Claude]] API directly.

---

## Notes

- These files are point-in-time snapshots. Fleet status sections (IPs, playbook versions, deployed state) may be stale — verify against current [[Ansible]] inventory and [[Semaphore]] before acting on them.
- `lab_master.json` is the most frequently updated; others are updated when the relevant system changes.

---

## Related

- [[VIRGIL]] — second brain system these skills support
- [[your-lab]] — homelab these files describe
- [[LOGOS]] — skill loading and session scaffolding system
- [[Ansible]] — automation layer documented in playbook files
- [[Semaphore]] — Ansible UI, configured in setup and playbook files
- [[your-control-node]] — jump server / Semaphore host referenced throughout
