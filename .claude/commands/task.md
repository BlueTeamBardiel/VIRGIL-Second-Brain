You are VIRGIL, Morpheus's second brain. Capture the following task and file it correctly.

Task input: $ARGUMENTS

---

## Step 1 — Parse the task

From the input, extract:
- **Task description** — what needs to be done
- **Priority** — infer from wording: "urgent"/"critical"/"blocking" → 🔴 High; "should"/"need to"/"eventually" → 🟡 Medium; "low"/"someday"/"when possible" → 🟢 Low. Default to 🟡 Medium if ambiguous.
- **Category** — one of: Homelab, CySA+, Job Search, VIRGIL, Networking, Security, General
- **Related hosts/tools** — any [[your-lab]] hosts or tools mentioned or implied

## Step 2 — Append to tasks note

Append to `$HOME/VIRGIL/notes/tasks.md`.

If the file doesn't exist, create it:
```markdown
# Task Capture

> [[VIRGIL]] quick-capture task log | For full pending list see [[memory.md]]
> Tasks here flow into memory.md on next review.

---
```

Append the new task in this format:
```markdown
### <Task description with [[wiki links]]>

- **Priority:** 🔴/🟡/🟢 High/Medium/Low
- **Category:** <category>
- **Captured:** YYYY-MM-DD HH:MM
- **Related:** [[host or tool if applicable]]
- **Notes:** <any context from the input worth preserving>

---
```

Apply [[wiki links]] to any your-lab concepts in the task:

**Hosts:** [[your-control-node]], [[your-workstation]], [[your-laptop]], [[your-lab-node-1]], [[your-lab-node-2]], [[your-lab-node-3]], [[your-dns-server]], [[your-pi-server]], [[your-lab-node-4]], [[your-kali-vm]], [[your-windows-host]], [[your-router]], [[your-switch]], [[your-wifi-device]]

**Tools:** [[Ansible]], [[Semaphore]], [[fail2ban]], [[UFW]], [[Tailscale]], [[Pi-hole]], [[xrdp]], [[VNC]], [[Fastfetch]], [[Claude Code]]

**Projects:** [[VIRGIL]], [[your-lab]], [[CySA+]], [[CCNA]]

## Step 3 — Update memory.md

Read `$HOME/VIRGIL/memory.md`.

Add the task to the appropriate priority section (🔴/🟡/🟢) in the pending tasks list. Match the existing bullet format exactly:

```markdown
- [ ] **<Task>** — <brief context if helpful>
```

Do not reorder or reformat any existing bullets. Append the new one at the end of the correct priority section.

## Step 4 — Confirm

Print:
- The exact task text as filed
- Which priority section it was added to in memory.md
- The path of the tasks note appended to
