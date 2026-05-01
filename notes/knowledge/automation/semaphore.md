# Semaphore — Ansible Web UI for Fleet Automation
> "Run Ansible playbooks from a browser. Schedule them. Never forget what you ran or when."

## What Semaphore Is
- Web UI for [[Ansible]] — replaces running `ansible-playbook` from the command line
- Stores inventory, SSH keys, repositories, and task templates in one place
- Schedules playbooks via cron
- Logs every run with full output — audit trail of every change made to the fleet
- Self‑hosted, free, SQLite or MySQL backend
- Runs as a systemd service on the control node

## YOUR-LAB Setup
- Runs on [[YOUR_JUMP_SERVER]] at <http://LAB_IP:3000>
- Version: 2.17.31
- Backend: SQLite
- Config: `~/config.json`
- Service: `semaphore.service` (systemd, runs as YOUR-USERNAME)

**Playbook path chain:**
```
~/semaphore-playbooks/          ← working dir (edit here)
    ↓ git push
~/semaphore-playbooks-remote.git  ← bare remote
    ↓ git pull
~/semaphore-playbooks-clone/    ← what Semaphore actually reads
```

> [!warning] If you skip step 3, Semaphore runs the old version. Always pull the clone after pushing.

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

## Inventory Setup

- **Name:** YOUR-LAB
- **Type:** Static
- **SSH Key:** YOUR-USERNAME-ssh (ed25519)
- **Sudo Credentials:** MUST be set to **None**
  - If set (even to a blank‑password key), Semaphore passes `-K` to ansible‑playbook, which prompts for a sudo password and breaks NOPASSWD sudo

**Inventory content:**
```ini
[homelab]
your-control-node   ansible_host=LAB_IP
your-primary-host   ansible_host=LAB_IP
eligor
morax
xaphan
malpas
kokabiel
barbatos
purah
azazel
```

> [!note] Host patterns are case‑sensitive — use lowercase throughout. LAB_HOST ≠ eligor.

## Task Templates

| Template | Playbook | Purpose | Schedule |
|---|---|---|---|
| APT Upgrade | `apt-upgrade.yml` | Update all packages fleet‑wide | Mon/Thu 3 am |
| Config Backup | `config-backup.yml` | Pull configs to [[YOUR_JUMP_SERVER]] | Mon/Thu 4 am |
| Deploy fail2ban | `fail2ban.yml` | Install + configure intrusion prevention | Manual |
| Deploy UFW | `ufw.yml` | Configure firewall rules fleet‑wide | Manual |
| Deploy Fastfetch | `fastfetch.yml` | Per‑host terminal theming | Manual |
| Port Scan Report | `port-scan-report.yml` | nmap all hosts from [[YOUR_JUMP_SERVER]] | Manual |
| Configure Sudoers | `sudoers.yml` | Passwordless sudo for YOUR-USERNAME | Manual |
| Docker Install | `docker-install.yml` | Install Docker fleet‑wide | Manual |
| Phase 2.2 Monitoring | `phase2.2-monitoring.yml` | Prometheus + Grafana + node exporters | Manual |
| Phase 2.3 Wazuh | `phase2.3-wazuh.yml` | Wazuh 4.14.1 manager stack on LAB_HOST | Manual |
| Phase 2.4 OpenVAS | `phase2.4-openvas.yml` | Greenbone vulnerability scanner on LAB_HOST | Manual (not yet run) |

## Cron Schedules

```
0 3 * * 1,4   APT Upgrade   (Mon/Thu 3 am)
0 4 * * 1,4   Config Backup (Mon/Thu 4 am)
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
# Then re‑run the task
```

### Permission denied on apt

```
Failed to lock apt for exclusive operation: Permission denied
```

Sudo Credentials is set in the inventory. Fix:
- Edit YOUR-LAB inventory → clear Sudo Credentials → set to **None**

### GPG error on YOUR_WORKSTATION

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

- **YOUR_KALI_VM:** Start VM on [[YOUR_JUMP_SERVER]] with `vmrun`
- **YOUR_LAPTOP:** May drop during service restarts — re‑run is safe, playbooks are idempotent
- **Any host:** Verify Tailscale is up if host is on a non‑LAN subnet

### Semaphore UI is empty (all templates gone)

SQLite database was reset. Playbooks are still in `~/semaphore-playbooks/` — recreate templates in UI with:

- Inventory: YOUR-LAB
- Repository: Local (`/home/your-username/semaphore-playbooks-clone`)
- SSH Key: YOUR-USERNAME-ssh
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

## What Is It? (Feynman Version)

Semaphore is a web‑based front‑end that turns a pile of Ansible scripts into a click‑through checklist, so you can run, schedule, and audit automation without touching a terminal.

## Why Does It Exist?

Before Semaphore, sysadmins had to remember every `ansible-playbook` command, manage SSH keys in separate files, and hunt through cron logs for failures. The result: manual, error‑prone deployments that broke when a single host was down or a key rotated. Semaphore unifies those steps, making the fleet feel like a single machine that can be told to act at a specific time, and you can later read a record of exactly what changed.

## How It Works (Under the Hood)

1. **Web request** → Semaphore server (Python/Flask) receives the run command.  
2. **Repository pull** → The server runs `git pull` on the clone directory, ensuring it has the latest playbooks.  
3. **Inventory load** → Inventory files are parsed into JSON; SSH keys are read from the key store.  
4. **Playbook execution** → The server invokes `ansible-playbook` with the selected playbook, inventory, and any variables.  
5. **Output capture** → Standard output and errors are streamed back to the web UI and simultaneously written to the SQLite/MySQL database.  
6. **Audit trail** → Every run creates a database row with timestamps, user, playbook, and full log, making roll‑backs and forensic analysis trivial.  
7. **Scheduling** → The cron‑style syntax in the UI maps to systemd timers that trigger step 2 at the requested times.

## What Breaks When It Goes Wrong?

- **Stale cache** → Semaphore runs an old playbook, leading to stale configurations on hosts.  
- **Incorrect inventory Sudo settings** → Playbooks hang at a password prompt, halting the entire run and leaving hosts in an inconsistent state.  
- **Network outage** → Unreachable hosts cause playbooks to fail, potentially leaving a subset of the fleet updated while others are not, breaking dependencies.  
- **Database reset** → All audit logs vanish, erasing traceability and compliance evidence, and requiring a manual rebuild of templates.

These failures manifest as silent misconfigurations, untracked changes, and, in worst cases, downtime for critical services.

---

## [Ansible] [YOUR_JUMP_SERVER] [YOUR-LAB] [Fleet Automation] [UFW] [fail2ban] [Active Directory]

<!-- preserved: [[Active Directory]] -->
<!-- preserved: [[YOUR-LAB]] -->
<!-- preserved: [[Fleet Automation]] -->
<!-- preserved: [[UFW]] -->
<!-- preserved: [[fail2ban]] -->