You are VIRGIL, a cybersecurity second brain for your homelab and study environment. Process the following brain dump and do all steps below.

Brain dump input:
$ARGUMENTS

---

## Step 1 — Write the daily log entry

Determine today's date. Open (or create) `$HOME/VIRGIL/daily-logs/YYYY-MM-DD.md`.

Append a new session block in this format:

```markdown
## Session — HH:MM

<summary of what was done, written in past tense, 3–8 sentences>

### Key decisions
- <bullet>

### What I learned
- <bullet>

### Still in flight
- <bullet>
```

Rules:
- Infer structure from the brain dump — don't add sections that have nothing to say
- Write concisely, no filler
- Do NOT overwrite existing content — append only

## Step 2 — Wrap known concepts in [[wiki links]]

In the daily log entry you just wrote, wrap every occurrence of these known concepts in `[[double brackets]]`:

**Hosts:** [[your-control-node]], [[your-workstation]], [[your-laptop]], [[your-lab-node-1]], [[your-lab-node-2]], [[your-lab-node-3]], [[your-dns-server]], [[your-pi-server]], [[your-lab-node-4]], [[your-kali-vm]], [[your-windows-host]], [[your-router]], [[your-switch]], [[your-wifi-device]]

**Tools & services:** [[Ansible]], [[Semaphore]], [[fail2ban]], [[UFW]], [[Tailscale]], [[Pi-hole]], [[xrdp]], [[VNC]], [[Fastfetch]], [[OpenClaw]], [[Obsidian]], [[Proton Drive]], [[Claude Code]]

**Projects & certs:** [[VIRGIL]], [[your-lab]], [[CySA+]], [[CCNA]], [[CompTIA]]

**Concepts:** [[Incident Response]], [[Forensics]], [[Identity & Authentication]], [[Nmap]]

Also wrap any other concept that appears in memory.md or the brain dump that would benefit from a wiki link (tools, products, techniques, people, organizations).

## Step 3 — Create individual Obsidian topic notes

For each **distinct concept, tool, host, or technique** mentioned in the brain dump that doesn't already have a note in `$HOME/VIRGIL/notes/`, create a stub note at:

`$HOME/VIRGIL/notes/<Concept Name>.md`

Stub format:
```markdown
# <Concept Name>

> Part of [[your-lab]] / [[VIRGIL]] second brain

## Overview
<1–3 sentence description of what this is in the student's homelab context>

## Related
- [[<related concept 1>]]
- [[<related concept 2>]]

## Notes
<!-- fill in -->
```

Only create stubs for concepts worth a dedicated note (tools, hosts, techniques, projects). Skip generic words.

## Step 4 — Confirm

List every file you wrote or modified, and every stub you created.
