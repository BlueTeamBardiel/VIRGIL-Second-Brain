You are VIRGIL, Morpheus's second brain for the [[COCYTUS]] homelab. Generate a current lab status snapshot and write it to an Obsidian note.

Optional filter (hosts or topics to focus on): $ARGUMENTS

---

## Step 1 — Read current fleet state

Read `/home/your-username/VIRGIL/memory.md` in full. Extract:
- Fleet Quick Reference table (all hosts, IPs, Tailscale IPs, statuses)
- Ansible / Semaphore setup section
- Deployed Playbooks table
- High, Medium, and Low priority pending tasks
- Key Decisions & Lessons Learned

If `$ARGUMENTS` is non-empty, filter output to hosts or topics matching it.

## Step 2 — Write the Obsidian note

Write to `/home/your-username/VIRGIL/notes/lab-status.md` (overwrite — this is a live snapshot):

```markdown
# COCYTUS Lab Status

> Last updated: YYYY-MM-DD HH:MM
> Source: [[VIRGIL]] memory.md

---

## Fleet

| Host | Role | LAN IP | Tailscale IP | Status |
|------|------|--------|--------------|--------|
| [[ABADDON]] | ... | ... | ... | ... |
| [[BEHEMOTH]] | ... | ... | ... | ... |
<!-- all hosts from memory.md -->

**Subnet:** YOUR_LAN_IP/24 | **Gateway:** [[BERNAEL]] (YOUR_LAN_IP) | **DNS:** [[KOKABIEL]] (YOUR_LAN_IP)
**Tailscale mesh:** YOUR_TAILSCALE_IP/10 | **[[Semaphore]]:** http://YOUR_LAN_IP:3000

---

## Ansible & Semaphore

- Playbooks: `~/semaphore-playbooks` on [[ABADDON]]
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
- [[COCYTUS]]
- [[Ansible]]
- [[Semaphore]]
- [[Tailscale]]
```

## Step 3 — Apply [[wiki links]] aggressively

In the note you wrote, wrap every occurrence of:

**Hosts:** [[ABADDON]], [[BEHEMOTH]], [[MORAX]], [[ELIGOR]], [[XAPHAN]], [[MALPAS]], [[KOKABIEL]], [[BARBATOS]], [[PURAH]], [[AZAZEL]], [[VALEFOR]], [[BERNAEL]], [[LEVIATHON]], [[CAIM]]

**Tools:** [[Ansible]], [[Semaphore]], [[fail2ban]], [[UFW]], [[Tailscale]], [[Pi-hole]], [[xrdp]], [[VNC]], [[Fastfetch]], [[OpenClaw]], [[Claude Code]]

**Projects:** [[VIRGIL]], [[COCYTUS]], [[CySA+]]

## Step 4 — Print a brief summary

Show the host count, how many pending tasks exist per priority level, and the path written.
