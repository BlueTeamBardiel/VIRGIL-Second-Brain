# scripts/

> [[VIRGIL]] utility scripts — fleet deployment, vault sync, and project bridge

One-shot scripts run manually from [[your-workstation]]. They are not cron-scheduled — invoke when setting up a new machine, syncing project progress, or deploying [[VIRGIL]] to a new host.

---

## Scripts

### deploy-machine.sh
**Purpose:** Deploy [[VIRGIL]] to any machine in the [[your-lab]] fleet. SSHes into the target, clones the VIRGIL repo, installs Python deps, sets up crontab (promote.sh + weekly-rollup.sh), writes env vars, and registers Claude Code hooks.

```bash
./scripts/deploy-machine.sh [user@]host

# Examples:
./scripts/deploy-machine.sh your-host
./scripts/deploy-machine.sh your-username@YOUR_TAILSCALE_IP
```

**Prerequisites:**
- SSH access to the target (key in `~/.ssh/config` or agent)
- `ANTHROPIC_API_KEY` and `SLACK_WEBHOOK_URL` in environment (prompted if not set)
- GitHub SSH key or HTTPS credentials configured on the target

---

### deploy-your-host.sh
**Purpose:** Dedicated deploy script for [[your-control-node]] (YOUR_LAN_IP / Tailscale YOUR_TAILSCALE_IP). Functionally similar to `deploy-machine.sh` but hardcodes [[your-control-node]]'s address and includes YOUR-CONTROL-NODE-specific cron entries (rss-ingest.py at 6am, cve-ingest.py at 7am).

```bash
./scripts/deploy-your-host.sh
```

**Prerequisites:**
- Run from [[your-workstation]]
- SSH access to `your-username@YOUR_HOST_IP`
- `ANTHROPIC_API_KEY` and `SLACK_WEBHOOK_URL` set or will be prompted

---

### sync-projects.sh
**Purpose:** Feed external project progress into [[VIRGIL]]. Appends a timestamped `## External Project Sync` entry to today's daily log, finds the matching note in `notes/` (fuzzy match on project name), appends a `### Update — YYYY-MM-DD` section to that note, and greps `memory.md` for tasks that look done. Posts to Slack.

```bash
./scripts/sync-projects.sh "<ProjectName>" "<Summary of what was done>"

# Examples:
./scripts/sync-projects.sh "LOGOS" "Built docker-status schema, portainer-launcher schema."
./scripts/sync-projects.sh "YOUR_LAB Phase 2" "Deployed Docker on YOUR-LAB-NODE-2. Portainer running."
```

**Use when:** Doing work in another repo or tool (e.g., [[LOGOS]], [[Semaphore]]) and want that progress reflected in VIRGIL's daily log and relevant note without a full `/reflect` session.

---

## Subdirectories

### scripts/ad/
[[Active Directory]] hardening scripts for `yourdomain.local`. Numbered sequentially — deploy in order on [[DC01]].

| Script | Purpose |
|--------|---------|
| `03-service-accounts.sh` | Create AD service accounts |
| `04-password-lockout-policy.sh` | Set domain password and lockout policy |
| `05-gpo-audit-policy.sh` | GPO: enable audit logging |
| `06-gpo-powershell-logging.sh` | GPO: PowerShell ScriptBlock + Module logging |
| `07-gpo-smb-signing.sh` | GPO: require SMB signing |
| `08-gpo-firewall.sh` | GPO: Windows Firewall baseline |
| `09-gpo-laps.sh` | GPO: configure LAPS |
| `10-gpo-applocker.sh` | GPO: AppLocker baseline rules |
| `11-activate-windows.sh` | Windows activation (KMS/MAK) |

---

## Related

- [[VIRGIL]] — system these scripts serve
- [[your-lab]] — fleet being deployed to
- [[your-control-node]] — primary non-YOUR-WORKSTATION deployment target
- [[Ansible]] / [[Semaphore]] — used for fleet-wide playbook deployment (separate from these scripts)
