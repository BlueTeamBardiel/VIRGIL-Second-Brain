# Automation for IT & Security
> "I automated myself out of a job" is the best thing you can say in a security interview.

Automation separates people who handle tickets from people who build systems. Every repetitive task you automate is time reclaimed for work that actually matters. More importantly, automation signals to employers that you think like an engineer — not just a technician.

---

## Why Automation Matters for Your Career

**What it signals to employers:**
- You understand root causes, not just symptoms
- You can multiply your own impact (one script replaces 200 manual actions)
- You're a force multiplier for the whole team
- You document your work in executable form

**The pipeline:** Help desk → automation → sysadmin/engineer/security. Every promotion comes with "this person stopped doing the same thing twice."

**VIRGIL itself is automation.** The RSS pipeline, CVE ingest, weekly summaries — these are all examples of the kind of work that makes you hireable. Build things that run while you sleep.

---

## Bash Scripting

Bash is the glue language of Linux/Unix systems. Not the most elegant, but universally available.

### Variables
```bash
#!/bin/bash
NAME="your-username"
LOG_DIR="/var/log/myapp"
TIMESTAMP=$(date '+%Y-%m-%d_%H:%M:%S')  # command substitution
FILE_COUNT=$(ls -1 "$LOG_DIR" | wc -l)

echo "Hello, $NAME"
echo "There are $FILE_COUNT log files"

# Arrays
SERVERS=("srv01" "srv02" "srv03")
echo "${SERVERS[0]}"        # first element
echo "${SERVERS[@]}"        # all elements
echo "${#SERVERS[@]}"       # count
```

### Loops
```bash
# For loop over list
for server in srv01 srv02 srv03; do
    echo "Checking $server..."
    ssh "$server" uptime
done

# For loop over array
for server in "${SERVERS[@]}"; do
    echo "$server: $(ssh "$server" 'df -h / | tail -1')"
done

# While loop
while IFS= read -r line; do
    echo "Processing: $line"
done < hostnames.txt

# C-style for
for ((i=1; i<=10; i++)); do
    echo "Iteration $i"
done
```

### Conditionals
```bash
# File tests
if [[ -f "/etc/passwd" ]]; then echo "file exists"; fi
if [[ -d "/tmp/staging" ]]; then echo "dir exists"; fi
if [[ -z "$VAR" ]]; then echo "variable is empty"; fi
if [[ -n "$VAR" ]]; then echo "variable is set"; fi

# String comparison
if [[ "$STATUS" == "failed" ]]; then
    echo "Service failed — alerting"
fi

# Numeric comparison
if [[ "$DISK_PCT" -gt 90 ]]; then
    echo "ALERT: disk above 90%"
fi

# AND / OR
if [[ -f "$FILE" && -r "$FILE" ]]; then echo "readable file"; fi
if [[ "$STATUS" == "failed" || "$STATUS" == "error" ]]; then echo "problem"; fi
```

### Functions
```bash
log()  { echo "[$(date '+%H:%M:%S')] $*"; }
warn() { echo "[WARN] $*" >&2; }
die()  { echo "[ERROR] $*" >&2; exit 1; }

check_service() {
    local service="$1"
    if systemctl is-active --quiet "$service"; then
        log "$service is running"
        return 0
    else
        warn "$service is DOWN"
        return 1
    fi
}

check_service nginx || die "nginx not running — aborting"
```

### Exit Codes
```bash
set -euo pipefail   # exit on error, unset variable, pipe failure — ALWAYS use this

command_that_might_fail || echo "it failed, continuing"
command_that_might_fail || exit 1   # fail the script

# Check last exit code
if [[ $? -ne 0 ]]; then echo "failed"; fi
```

---

## Python for IT Automation

Python is readable, has a massive standard library, and pip has a package for everything.

### `os` and `subprocess` — system interaction
```bash
import os
import subprocess

# Environment variables
api_key = os.environ.get("ANTHROPIC_API_KEY", "")
home    = os.path.expanduser("~")

# Run a command
result = subprocess.run(["systemctl", "status", "nginx"],
                        capture_output=True, text=True)
print(result.stdout)
print(result.returncode)

# Run shell command (careful with untrusted input — shell injection)
output = subprocess.check_output("df -h /", shell=True, text=True)
```

### `paramiko` — SSH automation
```bash
import paramiko

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect("192.168.1.10", username="admin", key_filename="~/.ssh/id_rsa")

stdin, stdout, stderr = ssh.exec_command("df -h")
print(stdout.read().decode())
ssh.close()
```

### `requests` — HTTP automation
```bash
import requests

# Simple GET
r = requests.get("https://api.example.com/data", timeout=10)
data = r.json()

# POST with auth header
r = requests.post(
    "https://api.anthropic.com/v1/messages",
    headers={"x-api-key": api_key, "content-type": "application/json"},
    json={"model": "claude-haiku-4-5-20251001", "max_tokens": 100,
          "messages": [{"role": "user", "content": "ping"}]}
)
```

### `json` — data handling
```bash
import json
from pathlib import Path

# Read config file
config = json.loads(Path("config.json").read_text())

# Write results
Path("report.json").write_text(json.dumps(results, indent=2))
```

---

## Ansible

[[Ansible]] is configuration management and task automation for fleets of machines. No agent needed — it uses SSH. This is what COCYTUS runs for fleet management.

### What it is
- **Idempotent:** run the same playbook 10 times, get the same result
- **Agentless:** SSH is the only requirement on targets
- **Readable:** YAML tasks that describe desired state, not imperative commands

### Inventory
```ini
# /etc/ansible/hosts or hosts.ini
[webservers]
192.168.1.10
192.168.1.11

[databases]
db01.internal
db02.internal

[all:vars]
ansible_user=admin
ansible_ssh_private_key_file=~/.ssh/id_rsa
```

### Ad-hoc commands (one-off tasks)
```bash
# Ping all hosts
ansible all -i hosts.ini -m ping

# Run a command
ansible webservers -i hosts.ini -m command -a "df -h"

# Install a package
ansible all -i hosts.ini -m apt -a "name=nginx state=present" --become

# Restart a service
ansible webservers -m service -a "name=nginx state=restarted" --become
```

### Playbooks
```yaml
# install-nginx.yml
---
- name: Install and start nginx on all web servers
  hosts: webservers
  become: true    # sudo

  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
        update_cache: true

    - name: Start and enable nginx
      service:
        name: nginx
        state: started
        enabled: true

    - name: Deploy config
      template:
        src: templates/nginx.conf.j2
        dest: /etc/nginx/nginx.conf
      notify: Reload nginx

  handlers:
    - name: Reload nginx
      service:
        name: nginx
        state: reloaded
```

```bash
ansible-playbook -i hosts.ini install-nginx.yml
ansible-playbook -i hosts.ini install-nginx.yml --check   # dry run
ansible-playbook -i hosts.ini install-nginx.yml --diff    # show changes
```

---

## Cron Jobs

### Syntax
```
┌──────── minute (0-59)
│ ┌────── hour (0-23)
│ │ ┌──── day of month (1-31)
│ │ │ ┌── month (1-12)
│ │ │ │ ┌ day of week (0-7, 0=Sun)
│ │ │ │ │
* * * * * command
```

### Common schedules
```bash
0  6 * * *      # 6am every day
0  */4 * * *    # every 4 hours
30 23 * * *     # 11:30pm every day
0  1 * * 0      # 1am every Sunday
0  8 * * 1-5    # 8am weekdays
*/15 * * * *    # every 15 minutes
```

### Managing crontabs
```bash
crontab -e       # edit your crontab
crontab -l       # list your crontab
crontab -r       # REMOVE — be careful
sudo crontab -e  # root's crontab

# System crontabs (run by root)
/etc/crontab
/etc/cron.d/
/etc/cron.daily/    # scripts here run once per day
/etc/cron.hourly/
```

---

## Real Automation Examples

### Auto-restart failed services
```bash
#!/bin/bash
# check-services.sh — restart failed services and notify Slack
SERVICES=("nginx" "postgresql" "redis")
WEBHOOK="${SLACK_WEBHOOK_URL:-}"

for svc in "${SERVICES[@]}"; do
    if ! systemctl is-active --quiet "$svc"; then
        systemctl restart "$svc"
        MSG="⚠️ $(hostname): $svc was down — restarted at $(date)"
        [[ -n "$WEBHOOK" ]] && curl -sS -X POST "$WEBHOOK" \
            -H "Content-Type: application/json" \
            -d "{\"text\":\"$MSG\"}" > /dev/null
    fi
done
```

### Disk space alert
```bash
#!/bin/bash
# disk-alert.sh — alert when any filesystem exceeds threshold
THRESHOLD=85

df -h --output=pcent,target | tail -n +2 | while read -r pct mount; do
    pct_num="${pct%%%}"   # strip % sign
    if (( pct_num >= THRESHOLD )); then
        echo "ALERT: $(hostname) — $mount at ${pct} — $(date)"
        # mail -s "Disk alert" admin@corp.com <<< "..."
    fi
done
```

### User account audit
```bash
#!/bin/bash
# user-audit.sh — find accounts that shouldn't exist
echo "=== Accounts with UID 0 (root-equivalent) ==="
awk -F: '($3 == "0") {print $1}' /etc/passwd | grep -v "^root$"

echo "=== Accounts with empty passwords ==="
awk -F: '($2 == "") {print $1}' /etc/shadow 2>/dev/null

echo "=== Users with login shells ==="
awk -F: '($7 !~ "nologin|false") && ($3 >= 1000) {print $1,$7}' /etc/passwd

echo "=== Accounts not logged in for 90+ days ==="
lastlog | awk 'NR>1 && $0 !~ "Never" {print}' | awk '{print $1, $NF}' | \
    while read user last; do
        # compare dates (simplified)
        echo "$user last: $last"
    done
```

### Failed login report (Python)
```python
#!/usr/bin/env python3
# failed-logins.py — parse auth.log and report top attackers
import re
from collections import Counter
from pathlib import Path

log = Path("/var/log/auth.log").read_text(errors="replace")
ips = re.findall(r"Failed password .+ from (\d+\.\d+\.\d+\.\d+)", log)
counts = Counter(ips).most_common(10)

print("Top 10 IPs with failed logins:")
for ip, count in counts:
    print(f"  {count:>5}  {ip}")
```

---

## Tags
`[[Ansible]]` `[[Python]]` `[[Bash]]` `[[VIRGIL]]` `[[Automation]]` `[[Help Desk]]` `[[Linux]]` `[[Cron]]`