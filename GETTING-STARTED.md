# Getting Started with VIRGIL

You're a handful of commands away from a working cybersecurity study companion. Read this end-to-end before running anything — the consequences of each step are explained before the command.

---

## Glossary — terms you'll see in this guide

If you've never set this kind of system up before, here's what the names refer to in one sentence each.

**Obsidian** — a free note-taking app that reads plain Markdown files from a folder. VIRGIL writes all your notes as Markdown; Obsidian turns them into a connected, searchable graph.

**Claude Code** — Anthropic's terminal AI. You run it inside your vault folder. It reads `CLAUDE.md` and `soul.md` and exposes the slash commands that make VIRGIL a study companion rather than a folder of notes.

**Ollama** — a tool that runs language models on your own hardware. If you have a recent GPU (or patient CPU), you can run VIRGIL fully local with no cloud API.

**Anthropic API** — Anthropic's cloud service for running Claude. Pay-as-you-go, about $3–5 per month at typical study usage. Requires an API key.

**RSS feed** — a machine-readable news format. VIRGIL pulls 22 security feeds every morning and synthesizes them into one digest note.

**CVE** — a public record of a software vulnerability with a unique ID (like CVE-2021-44228). VIRGIL ships 239 curated CVE notes and pulls new ones nightly.

**Vault** — your VIRGIL folder. Default: `~/VIRGIL`. Everything VIRGIL knows about you and the world lives there.

**cron** — the Linux/macOS scheduler that runs commands on a schedule. VIRGIL uses it to pull threat intel and CVEs while you sleep.

---

## The decisions you need to make

### Decision 1 — Which inference backend

VIRGIL needs an LLM to summarize feeds, write CVE notes, run slash commands. You pick one of two:

| Backend | Cost | Network | When to pick it |
|---|---|---|---|
| **Ollama** (local) | Free | Nothing leaves your machine | You have a GPU with 8 GB+ VRAM, or you want full privacy. |
| **Anthropic API** | ~$3–5/month | Prompts go to Anthropic | You don't have a capable GPU, or you just want it to work fast. |

There is no fallback chain. You pick one, set `VIRGIL_BACKEND` in `.env`, and that's what runs.

If you're unsure: start with the Anthropic API. It's faster to set up and is the easier first install. You can switch to Ollama later by editing `.env`.

### Decision 2 — Vault location

The installer defaults to `~/VIRGIL`. Accept the default unless you have a reason to change it. Obsidian will point here. You can override with `VIRGIL_DIR` in `.env` if you want it on an SSD, a NAS mount, or somewhere else.

---

## Step 1 — Install prerequisites

The installer needs Python 3.10+, git, curl, and a Linux/macOS shell. WSL2 on Windows works; see the Windows section at the bottom.

Verify you have them:

```bash
python3 --version    # 3.10 or higher
git --version
curl --version
```

If any are missing on Linux, install with your package manager (`apt`, `dnf`, `pacman`). On macOS, install Xcode command-line tools (`xcode-select --install`) and Homebrew if you don't have them.

---

## Step 2 — Optional: install Ollama and pull a model

Skip this step if you're using the Anthropic API. Jump to Step 3.

### Check your VRAM

The model you can run depends on your GPU's VRAM. Run this to see what you have:

```bash
nvidia-smi              # NVIDIA GPUs
rocm-smi                # AMD GPUs (if rocm is installed)
free -h                 # If no GPU, system RAM matters
```

| VRAM available | Suggested model | Notes |
|---|---|---|
| 8 GB | `llama3.1:8b` | Fast, decent quality. |
| 16 GB | `qwen2.5:14b` | Better reasoning, comfortable middle ground. |
| 24 GB+ | `gpt-oss:20b` | Headroom for long context. |
| CPU only | `llama3.1:8b` | Slow but works on modern CPUs. |

Models age quickly. The names above are accurate at v2.0.0 release; check the [Ollama library](https://ollama.com/library) for current best-in-class at your VRAM tier.

### Install Ollama

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

This downloads and installs Ollama. It then runs as a local service on port 11434.

### Pull a model

Pick from the table above and pull:

```bash
ollama pull qwen2.5:14b
```

This downloads several gigabytes. Wait for it to finish.

### Verify Ollama is running

```bash
ollama run qwen2.5:14b "Hello"
```

You should see a short response. If it hangs or errors, see Troubleshooting at the bottom.

> **Note on reasoning models.** If you use a reasoning model like `deepseek-r1`, set `num_predict` to at least 3000 — these models burn tokens on internal thinking before producing visible output, and the default budget is too low. See `ARCHITECTURE.md` §7.3.

---

## Step 3 — Run the VIRGIL installer

Clone the repo and run the installer:

```bash
git clone https://github.com/BlueTeamBardiel/virgil-public.git
cd virgil-public
bash scripts/install.sh
```

The installer is interactive. It will:

- Create `~/VIRGIL/` with the full vault structure (`notes/`, `logs/`, `memory-*.md`, `user.md`).
- Copy the 739 cert notes and 239 CVE notes into the vault.
- Write `.env` and `CLAUDE.md` based on your answers.
- Optionally install 7 cron jobs that keep the vault current (you can decline; details below).
- Optionally add `virgil-*` aliases to your shell.

Every prompt explains what saying yes vs. no will do before asking. Read each one. Saying no to optional pieces is always safe.

### About the cron jobs

If you accept the crontab prompt, the installer adds these to your user crontab:

| Time | Job | What it does |
|---|---|---|
| 06:00 daily | `rss-ingest.py` | Writes one threat-intel digest from 22 feeds. |
| 07:00 daily | `cve-ingest.py --recent` | Pulls new CVEs from NVD and writes one note each. |
| 08:00 Mondays | `triage-inbox.sh` | Routes anything you've dropped into `notes/inbox/`. |
| 23:30 daily | `wikilink-ingest.sh` | Inserts `[[wikilinks]]` across the vault. |
| 23:55 daily | `auto-reflect.sh` | Fills empty stub notes via the LLM. |
| 01:00 Mon–Sat | `promote.sh` | Distills daily logs into memory files. |
| 01:00 Sundays | `weekly-rollup.sh` | Writes the week's digest. |

You can disable any one of these later with `crontab -e` — delete the line, save. Nothing else needs to change.

### Did it work?

```bash
ls ~/VIRGIL/notes/
```

You should see `knowledge/` (the cert notes and curated CVE corpus), `cve/` (your runtime CVE feed, starts empty), `feeds/` (starts empty), and `inbox/`.

```bash
ls ~/VIRGIL/
```

You should also see `memory-working.md`, `memory-episodic.md`, `memory-semantic.md`, `user.md`, and `.env`.

---

## Step 4 — Open the vault in Obsidian

Download [Obsidian](https://obsidian.md) if you don't have it. It's free.

1. Open Obsidian.
2. Click **Open folder as vault** (not "Create new vault").
3. Navigate to `~/VIRGIL` (or wherever you pointed `VIRGIL_DIR`).
4. Click **Open**.

Obsidian indexes the Markdown files. The left sidebar shows the folder tree. Press `Ctrl+G` (Cmd+G on macOS) to open the graph view — you'll see five cert clusters and the CVE corpus connected by shared concepts.

### Did it work?

You should see `notes/knowledge/` in the sidebar with subdirectories for each cert. Click into `ccna/` — there should be 154 notes there. Click any note, then `Ctrl+G` to see how it's linked to others.

---

## Step 5 — Install Claude Code

Claude Code is the terminal AI that loads `soul.md` and gives you the slash commands. It runs on Node.js.

### Install Node.js (if you don't have it)

Ubuntu/Debian:

```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
```

macOS (with Homebrew):

```bash
brew install node
```

### Install Claude Code

```bash
npm install -g @anthropic-ai/claude-code
claude --version
```

If `npm install -g` fails with a permissions error, configure npm to use a user-local prefix (`npm config set prefix ~/.npm-global`) rather than running with `sudo`.

---

## Step 6 — Open VIRGIL

From your vault:

```bash
cd ~/VIRGIL
claude
```

Claude Code starts, loads `CLAUDE.md`, loads `soul.md`, and waits for input. Your first session, run:

```
/start
```

VIRGIL conducts a brief guided interview — your name, background, certs in progress, target roles — and writes the answers to `user.md`. Every subsequent session reads `user.md` silently. You don't have to do this again.

After the interview, pick a cert and start:

```
/secplus     ← Security+ session
/ccna        ← CCNA session
/cysa        ← CySA+ session
/aplus       ← A+ session
/netplus     ← Network+ session
```

Or jump into open-ended teaching:

```
/teach VLANs
/teach "how does SMB relay actually work"
```

---

## Your first week

| Day | What to do | Command |
|---|---|---|
| 1 | Onboarding interview + first cert session | `/start` then `/secplus` (or your cert) |
| 2 | First teaching session on a weak topic | `/teach <topic>` |
| 3 | First quiz | `virgil-quiz <topic>` (shell alias) |
| 4 | Spaced-repetition review of what you've quizzed | `virgil-review` |
| 5 | A diagnostic to find weak areas | `/diagnose` |
| 7 | Weekly digest | `/week` |

By the end of week one, the ingest pipelines have written seven daily feed digests and any new CVEs that disclosed during the week. Your vault is alive.

---

## What's in the box

- **Cert notes**: A+ (136), CCNA (154), CySA+ (263), Net+ (66), Sec+ (120). All Feynman-style per `soul.md`.
- **CVE corpus**: 239 audited starter notes plus a runtime feed that grows nightly.
- **23 slash commands**: cert sessions, teaching, diagnosis, planning, the four meta-cognition "wall" commands, session management. Full list in `ARCHITECTURE.md` §6.3.
- **soul.md**: the behavioral spec. The most important file in the repo. Edit it to retune VIRGIL's voice.
- **The promotion gate**: the security boundary that produced this repo. Runs in the maintainer's private system, not shipped here; a sanitized reference implementation is planned for v2.1.0. See ARCHITECTURE.md §9.2.

---

## Memory and context

VIRGIL keeps three memory files in your vault root:

| File | Role | Lifespan |
|---|---|---|
| `memory-working.md` | Active tasks, open threads | Cleared weekly |
| `memory-episodic.md` | Dated session history | Append-only |
| `memory-semantic.md` | Permanent facts about you, your certs, your decisions | Append-only |

Plus `user.md` — your name, background, certs in progress, target roles. `/start` and `/diagnose` populate it via guided interview.

These four files are gitignored. They're yours and they stay on your machine.

---

## Common shell aliases (added by the installer)

| Alias | What it does |
|---|---|
| `virgil-quiz <topic>` | 5-question quiz on a vault topic |
| `virgil-review` | Spaced-repetition dashboard (SM-2 over quiz scores) |
| `virgil-rss` | Run the RSS pipeline manually |
| `virgil-cve --recent` | Run the CVE pipeline manually |
| `virgil-url <url>` | Ingest a URL into the vault |
| `virgil-pdf <path>` | Ingest a PDF into the vault |
| `virgil-cert-ingest <type> <source> "<cert>"` | Ingest your own cert study material |
| `virgil-triage` | Manually triage `notes/inbox/` |

---

## Windows (via WSL2)

VIRGIL's scripts and vault run inside WSL2. Obsidian and Claude Code run natively on Windows. They connect through a network path.

### 1. Enable WSL2

Open PowerShell **as Administrator**:

```powershell
wsl --install
```

Reboot when prompted. Ubuntu finishes setting up — create a username and password when asked.

### 2. Install Windows-side tools

- [Obsidian](https://obsidian.md) — native Windows app.
- Claude Code — installed inside Ubuntu (see Step 5 above), not on Windows.

### 3. Run the VIRGIL installer inside WSL2

Open Ubuntu (search "Ubuntu" in Start menu):

```bash
git clone https://github.com/BlueTeamBardiel/virgil-public.git
cd virgil-public
bash scripts/install.sh
```

### 4. Point Obsidian at the WSL vault

1. Open Obsidian → **Open folder as vault**.
2. Type into the path bar:
   ```
   \\wsl.localhost\Ubuntu\home\<your-ubuntu-username>\VIRGIL
   ```
3. Click **Open**.

### 5. Make cron run on WSL2

WSL2 doesn't autostart cron. Add this once and restart WSL:

```bash
echo -e "[boot]\ncommand=service cron start" | sudo tee -a /etc/wsl.conf
```

Then in PowerShell: `wsl --shutdown`, reopen Ubuntu. Verify with `service cron status`.

---

## Troubleshooting

### Ollama not responding

```bash
curl http://localhost:11434/api/tags
```

If this returns "connection refused," Ollama isn't running. Start it:

```bash
ollama serve &
# or as a system service
sudo systemctl start ollama
```

### Claude Code says "ANTHROPIC_API_KEY not set"

```bash
echo $ANTHROPIC_API_KEY
```

If empty, your shell didn't pick up `.env`. Source it: `source ~/VIRGIL/.env`. To make it permanent, add `source ~/VIRGIL/.env` to your `~/.bashrc` or `~/.zshrc`.

If you're using Ollama, set `VIRGIL_BACKEND=ollama` in `.env` — this skips the API key requirement.

### Vault not visible in Obsidian

Make sure:

1. The vault was created: `ls ~/VIRGIL/notes/`.
2. You used **Open folder as vault**, not **Create new vault**.
3. On WSL2: Ubuntu must be running before you open Obsidian — the network path only appears when WSL is active.

### Cron jobs aren't running

```bash
crontab -l
```

If you see the VIRGIL section, cron has the jobs. Check the logs:

```bash
tail ~/VIRGIL/logs/rss.log
tail ~/VIRGIL/logs/cve.log
```

On macOS, you may need to grant cron full disk access in System Preferences → Security & Privacy → Privacy → Full Disk Access.

---

## Where to go next

- [`ARCHITECTURE.md`](ARCHITECTURE.md) — full architectural breakdown. Read this before forking.
- [`soul.md`](soul.md) — the behavioral spec. Read this to understand VIRGIL's voice.
- [`CONTRIBUTING.md`](CONTRIBUTING.md) — how to fork and contribute.
- [`FEEDS.md`](FEEDS.md) — the 22 RSS feeds.
- [`ROADMAP.md`](ROADMAP.md) — what's planned for v2.1.0.
