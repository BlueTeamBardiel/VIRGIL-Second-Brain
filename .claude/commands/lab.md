You are VIRGIL, a cybersecurity second brain for your homelab and study environment. Generate a current lab status snapshot and write it to an Obsidian note.

Optional filter (hosts or topics to focus on): $ARGUMENTS

---

## Step 1 — Read current fleet state

Read `$HOME/VIRGIL/memory.md` in full. Extract:
- Fleet Quick Reference table (all hosts, IPs, Tailscale IPs, statuses)
- Ansible / Semaphore setup section
- Deployed Playbooks table
- High, Medium, and Low priority pending tasks
- Key Decisions & Lessons Learned

If `$ARGUMENTS` is non-empty, filter output to hosts or topics matching it.

## Step 2 — Write the Obsidian note

Write to `$HOME/VIRGIL/notes/lab-status.md` (overwrite — this is a live snapshot):

```markdown
# your-lab Lab Status

> Last updated: YYYY-MM-DD HH:MM
> Source: [[VIRGIL]] memory.md

---

## Fleet

| Host | Role | LAN IP | Tailscale IP | Status |
|------|------|--------|--------------|--------|
| [[your-control-node]] | ... | ... | ... | ... |
| [[your-workstation]] | ... | ... | ... | ... |
<!-- all hosts from memory.md -->

**Subnet:** YOUR_LAN_IP/24 | **Gateway:** [[your-router]] (YOUR_LAN_IP) | **DNS:** [[your-dns-server]] (YOUR_LAN_IP)
**Tailscale mesh:** YOUR_TAILSCALE_IP/10 | **[[Semaphore]]:** http://YOUR_LAN_IP:3000

---

## Ansible & Semaphore

- Playbooks: `~/semaphore-playbooks` on [[your-control-node]]
- Clone (Semaphore reads): `~/semaphore-playbooks-clone`
- Workflow: edit → commit → push → pull clone → run in [[Semaphore]]

### Deployed Playbooks

| Playbook | Status | Schedule |
|----------|--------|----------|
<!-- from memory.md -->

---

## Pending Tasks

### 🔴 High Priority
<!-- bullets from memory.md with [[wiki links]] on tool/host names -->

### 🟡 Medium Priority
<!-- bullets from memory.md -->

### 🟢 Low Priority
<!-- bullets from memory.md -->

---

## Key Lessons

<!-- bullets from Key Decisions & Lessons Learned, with [[wiki links]] -->

---

## Related
- [[VIRGIL]]
- [[your-lab]]
- [[Ansible]]
- [[Semaphore]]
- [[Tailscale]]
```

## Step 3 — Apply [[wiki links]] aggressively

In the note you wrote, wrap every occurrence of:

**Hosts:** [[your-control-node]], [[your-workstation]], [[your-laptop]], [[your-lab-node-1]], [[your-lab-node-2]], [[your-lab-node-3]], [[your-dns-server]], [[your-pi-server]], [[your-lab-node-4]], [[your-kali-vm]], [[your-windows-host]], [[your-router]], [[your-switch]], [[your-wifi-device]]

**Tools:** [[Ansible]], [[Semaphore]], [[fail2ban]], [[UFW]], [[Tailscale]], [[Pi-hole]], [[xrdp]], [[VNC]], [[Fastfetch]], [[OpenClaw]], [[Claude Code]]

**Projects:** [[VIRGIL]], [[your-lab]], [[CySA+]]

## Step 4 — Print a brief summary

Show the host count, how many pending tasks exist per priority level, and the path written.
