# Getting Started with VIRGIL

VIRGIL is an Obsidian-based second brain. If you don't have Obsidian, download it free at [obsidian.md](https://obsidian.md) — it's a note-taking app that connects your notes like a wiki.

Welcome. This guide is for first-time users who just installed VIRGIL and want to understand how the vault is structured.

> **No API key required.** VIRGIL works fully with local inference via [Ollama](https://ollama.com) — no Anthropic account, no API costs. An Anthropic API key unlocks cloud fallback (Claude Haiku, ~$3–5/month at typical usage) but is entirely optional. See [ARCHITECTURE.md](ARCHITECTURE.md) for the full inference stack and how to configure local-only mode.

## Windows (via WSL2)

The short version: **VIRGIL's scripts and vault run inside WSL2. Obsidian and Claude Code run natively on Windows.** They connect through a network path — no file copying, no sync software.

### Why WSL2?

VIRGIL uses bash, Python, and cron — tools that don't run natively on Windows. WSL2 gives you a full Linux environment running alongside Windows. Obsidian reads the vault files over the WSL network path as if they were a normal local folder.

### Step 1 — Enable WSL2

Open PowerShell **as Administrator** and run:
```powershell
wsl --install
```
Reboot when prompted. This installs WSL2 and Ubuntu in one step. After reboot, Ubuntu will finish setting up — create a username and password when asked.

### Step 2 — Install Windows-side tools

These run on Windows, not inside WSL:
- **[Obsidian](https://obsidian.md)** — the vault viewer. Free download, native Windows app.
- **[Claude Code](https://claude.ai/code)** — requires WSL2 on Windows. The installer handles this automatically; you run it from inside the Ubuntu terminal.

### Step 3 — Run the VIRGIL installer inside WSL2

Open your Ubuntu terminal (search "Ubuntu" in the Start menu), then run:
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/BlueTeamBardiel/VIRGIL-Second-Brain/main/scripts/install.sh)
```
The installer detects WSL2 and prints notes specific to your setup.

### Step 4 — Connect Obsidian to the vault

1. Open Obsidian on Windows → **Open folder as vault**
2. In the folder picker, type this path directly into the address bar:
   ```
   \\wsl.localhost\Ubuntu\home\<your-ubuntu-username>\VIRGIL
   ```
   Replace `<your-ubuntu-username>` with the username you created in Step 1.
3. Click **Open**

Obsidian sees the vault as a regular local folder. Edits sync instantly — no file copying involved. If the path doesn't work, check that your Ubuntu username is correct and WSL2 is running.

### Step 5 — Fix cron (WSL2 doesn't autostart it)

Cron doesn't start automatically when WSL launches. Fix this once:
```bash
# Option A: Add to /etc/wsl.conf (starts cron every time WSL launches)
echo -e "[boot]\ncommand=service cron start" | sudo tee -a /etc/wsl.conf
```
Restart WSL (`wsl --shutdown` in PowerShell, then reopen Ubuntu) to apply. Verify: `service cron status`

### WSL2 Troubleshooting

**Obsidian can't find the vault path:** Make sure Ubuntu is running (open a terminal, then retry in Obsidian). WSL2 only registers the network path when it's active.

**`virgil-rss` works but Obsidian doesn't show new notes:** Obsidian caches the file list — press `Ctrl+Shift+I` to open the developer console, or close and reopen the vault.

**Claude Code says WSL2 is required:** You're not in the WSL terminal. Close any PowerShell or CMD windows and run it from the Ubuntu terminal instead.

**Line ending issues with git:** WSL2 and Windows can disagree on `\r\n` vs `\n`. Inside WSL, run:
```bash
git config --global core.autocrlf input
```

---

## Step 0: Open the Vault in Obsidian

1. Open Obsidian
2. Click **Open folder as vault**
3. Navigate to your `VIRGIL_DIR` (wherever `install.sh` put it, default: `~/VIRGIL`)
   - **Windows users:** use `\\wsl.localhost\Ubuntu\home\<username>\VIRGIL`
4. Click **Open**

Obsidian will index all the Markdown files. The left sidebar shows your folder structure.

## Step 1: Understand the Note Structure

```
notes/
├── inbox/        ← START HERE. Drop anything here, triage handles routing.
├── mitre/        ← ATT&CK techniques (auto-ingested from attack.mitre.org)
├── cve/          ← CVE notes (auto-generated daily from NVD)
├── feeds/        ← Daily threat intel digests (auto-generated at 6am)
├── knowledge/    ← Your study library (PDFs, URLs, NIST docs)
│   ├── security/
│   ├── networking/
│   └── nist/
└── personal/     ← Fitness, study logs, goals (optional)
```

## Step 2: Enable Graph View

In Obsidian, press `Ctrl+G` (or `Cmd+G` on Mac) to open the graph view. After you've ingested a few notes, you'll start to see the `[[wiki link]]` connections between them.

This is the payoff. Notes about CVEs link to ATT&CK techniques. ATT&CK notes link to NIST controls. Your study session notes link to the concepts they covered. Over time, the graph becomes a map of everything you know.

## Step 3: Run Your First Ingestion

Open a terminal and run:

```bash
# Pull today's security news feeds
virgil-rss

# Ingest an ATT&CK technique
virgil-url https://attack.mitre.org/techniques/T1059/

# Pull recent CVEs
virgil-cve --recent
```

Open Obsidian. You'll see new notes in `notes/feeds/`, `notes/mitre/`, and `notes/cve/`. Click into them. Follow the `[[wiki links]]`.

## Step 4: Set Up the Daily Habit

VIRGIL runs mostly on autopilot once the crontab is configured. Your daily workflow:

1. **Morning**: Check `notes/feeds/YYYY-MM-DD.md` for overnight threat intel digest
2. **During study**: Use `virgil-pdf` and `virgil-url` to capture anything interesting
3. **After a Claude Code session**: Run `/reflect` to fill in your session summary
4. **Sunday**: Check `weekly-summaries/YYYY-WNN.md` for the week's synthesis

## Step 5: Understand Wiki Links

VIRGIL uses `[[wiki links]]` throughout. In Obsidian, `[[T1059]]` creates a clickable link to the note `T1059.md`. `[[Wazuh]]` links to your Wazuh note.

The wikilink-ingest script (runs nightly at 11:30pm) scans recently modified notes and automatically injects `[[wiki links]]` for any mention of a known note title. You don't have to manually link everything.

To manually link something: type `[[` in Obsidian and start typing. Obsidian autocompletes from your existing notes.

## Step 6: The Memory System

Three files track your persistent context (these are gitignored — they stay on your machine):

| File | What It Holds |
|------|--------------|
| `memory-working.md` | Your active tasks and current sprint. Cleared weekly by `promote.sh`. |
| `memory-episodic.md` | Dated history of what you've done. Append-only. |
| `memory-semantic.md` | Permanent facts: your lab setup, certs in progress, key decisions. |

When you run `/reflect` in Claude Code, it reads these files to give you context-aware responses. Update `memory-semantic.md` with facts you want Claude to always know about your setup.

## Step 7: The Inbox Workflow

Anything you're not sure where to file goes in `notes/inbox/`. Every Monday at 8am, `triage-inbox.sh` runs Claude Haiku against each note and makes a routing decision.

You can also run triage manually anytime:
```bash
virgil-triage
```

## Common Obsidian Tips for VIRGIL

- **Search everything**: `Ctrl+Shift+F` — searches all note content
- **Quick switcher**: `Ctrl+O` — jump to any note by name  
- **Graph view**: `Ctrl+G` — see your knowledge graph
- **Backlinks**: In any note, the right panel shows all notes that link to it
- **Tags**: Click any `#tag` to see all notes with that tag
- **Daily notes**: Not required but pairs well with VIRGIL's daily log system

## Option B: Local Inference (No API Key Required)

If you don't have an Anthropic API key, or prefer to keep your data fully local, VIRGIL scripts support [Ollama](https://ollama.com) as a drop-in backend.

**Quick setup:**

```bash
# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Pull a model (qwen2.5:14b is a good balance of speed and quality)
ollama pull qwen2.5:14b

# Tell VIRGIL to use Ollama instead of the Anthropic API
echo 'VIRGIL_BACKEND=ollama' >> ~/.env
echo 'OLLAMA_MODEL=qwen2.5:14b' >> ~/.env
echo 'OLLAMA_URL=http://localhost:11434' >> ~/.env
```

Scripts that support Ollama will skip the `ANTHROPIC_API_KEY` check when `VIRGIL_BACKEND=ollama` is set. See [Ollama's model library](https://ollama.com/library) for available models.

> **Note:** Smaller models (7B–14B) produce noticeably shorter and less structured notes than Claude Haiku. For exam-critical content (CVE notes, ATT&CK techniques), Claude Haiku is recommended if cost is manageable (~$3–5/month at typical usage).

## Troubleshooting

**virgil-rss fails with "no API key"**: You have two options — (1) set `ANTHROPIC_API_KEY` in your `.env` file and source it (`source ~/.env`), or (2) set `VIRGIL_BACKEND=ollama` to use local inference with no API key (see **Option B** above). If you're not sure which you want, start with Ollama.

**virgil-rss fails even with a key**: Run `echo $ANTHROPIC_API_KEY` — if empty, your `.env` isn't being sourced. Add `source ~/VIRGIL/.env` to your `~/.bashrc` or re-run the installer.

**Notes aren't getting wiki links**: The wikilink script runs at 11:30pm. Run it manually: `virgil-wikilink`

**Triage isn't routing correctly**: Check `ingest/triage-inbox.log` for the routing decision on each note.

**Cron jobs not running**: Run `crontab -l` and verify the VIRGIL entries are present. If not, re-run the installer with `bash scripts/install.sh` from your cloned repo.
