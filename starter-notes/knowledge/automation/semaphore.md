# Semaphore — Ansible Web UI for Fleet Automation
> "Run Ansible playbooks from a browser. Schedule them. Never forget what you ran or when."

## What Semaphore Is
- Web UI for [[Ansible]] — replaces running `ansible-playbook` from the command line
- Stores inventory, SSH keys, repositories, and task templates in one place
- Schedules playbooks via cron
- Logs every run with full output — audit trail of every change made to the fleet
- Self-hosted, free, SQLite or MySQL backend
- Runs as a systemd service on the control node

## [YOUR-LAB] Setup
- Runs on [[[YOUR-HOST]]] at http://192.168.x.x:3000
- Version: 2.17.31
- Backend: SQLite
- Config: `~/config.json`
- Service: `semaphore.service` (systemd, runs as [YOUR-USERNAME])

**Playbook path chain:**
```
~/semaphore-playbooks/          ← working dir (edit here)
    ↓ git push
~/semaphore-playbooks-remote.git  ← bare remote
    ↓ git pull
~/semaphore-playbooks-clone/    ← what Semaphore actually reads
```

## The Git Workflow (Critical)

Semaphore pulls from a git repository — it does NOT read files directly.

```bash
# 1. Edit playbook
vim ~/semaphore-playbooks/apt-upgrade.yml

# 2. Commit and push to bare remote
cd ~/semaphore-playbooks
git add -A && git commit -m "fix: update apt playbook"
git push

# 3. Pull into clone (Semaphore reads from here)
cd ~/semaphore-playbooks-clone && git pull

# 4. Run task in Semaphore UI
```

> [!warning] If you skip step 3, Semaphore runs the old version. Always pull the clone after pushing.

## Inventory Setup

- **Name:** [YOUR-LAB]
- **Type:** Static
- **SSH Key:** [YOUR-USERNAME]-ssh (ed25519)
- **Sudo Credentials:** MUST be set to **None**
  - If set (even to a blank-password key), Semaphore passes `-K` to ansible-playbook, which prompts for a sudo password and breaks NOPASSWD sudo

**Inventory content:**
```ini
[homelab]
your-control-node   ansible_host=192.168.x.x
your-primary-host   ansible_host=192.168.x.x
eligor
morax
xaphan
malpas
kokabiel
barbatos
purah
azazel
```

> [!note] Host patterns are case-sensitive — use lowercase throughout. [YOUR-HOST] ≠ eligor.

## Task Templates

| Template | Playbook | Purpose | Schedule |
|---|---|---|---|
| APT Upgrade | `apt-upgrade.yml` | Update all packages fleet-wide | Mon/Thu 3am |
| Config Backup | `config-backup.yml` | Pull configs to [[[YOUR-HOST]]] | Mon/Thu 4am |
| Deploy fail2ban | `fail2ban.yml` | Install + configure intrusion prevention | Manual |
| Deploy UFW | `ufw.yml` | Configure firewall rules fleet-wide | Manual |
| Deploy Fastfetch | `fastfetch.yml` | Per-host terminal theming | Manual |
| Port Scan Report | `port-scan-report.yml` | nmap all hosts from [[[YOUR-HOST]]] | Manual |
| Configure Sudoers | `sudoers.yml` | Passwordless sudo for [YOUR-USERNAME] | Manual |
| Docker Install | `docker-install.yml` | Install Docker fleet-wide | Manual |
| Phase 2.2 Monitoring | `phase2.2-monitoring.yml` | Prometheus + Grafana + node exporters | Manual |
| Phase 2.3 Wazuh | `phase2.3-wazuh.yml` | Wazuh 4.14.1 manager stack on [YOUR-HOST] | Manual |
| Phase 2.4 OpenVAS | `phase2.4-openvas.yml` | Greenbone vulnerability scanner on [YOUR-HOST] | Manual (not yet run) |

## Cron Schedules

```
0 3 * * 1,4   APT Upgrade   (Mon/Thu 3am)
0 4 * * 1,4   Config Backup (Mon/Thu 4am)
```

## Troubleshooting

### Playbook not found

```
ERROR: the playbook: X.yml could not be found
```

Semaphore caches the repo clone in `/tmp`. Stale cache causes this even after a pull.

```bash
rm -rf /tmp/semaphore/project_1/repository_1_template_2_home
cd ~/semaphore-playbooks-clone && git pull
# Then re-run the task
```

### Permission denied on apt

```
Failed to lock apt for exclusive operation: Permission denied
```

Sudo Credentials is set in the inventory. Fix:
- Edit [YOUR-LAB] inventory → clear Sudo Credentials → set to **None**

### GPG error on [YOUR-HOST]

```
GPG error: repository.spotify.com ...
```

Stale Spotify repo cache. Fix:

```bash
ssh your-primary-host 'sudo apt clean'
```

### Host unreachable

```
UNREACHABLE — Connection timed out
```

- **[YOUR-HOST]:** Start VM on [[[YOUR-HOST]]] with `vmrun`
- **[YOUR-HOST]:** May drop during service restarts — re-run is safe, playbooks are idempotent
- **Any host:** Verify Tailscale is up if host is on a non-LAN subnet

### Semaphore UI is empty (all templates gone)

SQLite database was reset. Playbooks are still in `~/semaphore-playbooks/` — recreate templates in UI with:

- Inventory: [YOUR-LAB]
- Repository: Local (`/home/[YOUR-USERNAME]/semaphore-playbooks-clone`)
- SSH Key: [YOUR-USERNAME]-ssh
- Sudo: None

## Installation Reference (New Control Node)

```bash
# Download binary
wget https://github.com/semaphoreui/semaphore/releases/download/vX.Y.Z/semaphore_linux_amd64.tar.gz
tar -xzf semaphore_linux_amd64.tar.gz
sudo mv semaphore /usr/local/bin/

# Initialize config
semaphore setup  # interactive — choose SQLite, set port 3000

# Enable service
sudo systemctl enable --now semaphore
```

Full setup guide: `skills/cocytus_ansible_semaphore_setup.json` in [[VIRGIL]].

---

[[Ansible]] [[[YOUR-HOST]]] [[[YOUR-LAB]]] [[Fleet Automation]] [[UFW]] [[fail2ban]] [[Active Directory]]
