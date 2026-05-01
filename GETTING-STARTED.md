# Getting Started with VIRGIL

You're 3 commands away from a working second brain.

```bash
# 1. Install Ollama (local AI — no API costs)
curl -fsSL https://ollama.com/install.sh | sh && ollama pull qwen2.5:14b

# 2. Run the VIRGIL installer
bash <(curl -fsSL https://raw.githubusercontent.com/BlueTeamBardiel/VIRGIL-Second-Brain/main/scripts/install.sh)

# 3. Open VIRGIL
cd ~/VIRGIL && claude
```

That's it. VIRGIL introduces itself and walks you through the rest.

---

## The two decisions you need to make

**Decision 1 — API key (optional)**

VIRGIL runs fully with local inference via [Ollama](https://ollama.com) — no API key, no cost. An Anthropic API key unlocks cloud fallback (Claude Haiku, ~$3–5/month at typical usage) but is not required.

- No API key: set `VIRGIL_BACKEND=ollama` in `~/.env`
- With API key: set `ANTHROPIC_API_KEY=sk-...` in `~/.env`

If you're not sure, start without one. You can add it later.

**Decision 2 — Vault location**

The installer defaults to `~/VIRGIL`. Accept the default unless you have a reason to change it. Obsidian will point here.

---

## Glossary — what is all this?

**CVE (Common Vulnerabilities and Exposures)**
A CVE is a public record of a security vulnerability in software or hardware.
Every CVE has a unique ID (like CVE-2024-1234), a severity score, and a description
of what the vulnerability is and how it can be exploited.
VIRGIL pulls new CVEs daily from the US government's vulnerability database (NVD).

**MITRE ATT&CK**
A publicly available knowledge base of real-world attacker tactics and techniques.
Security teams use it to understand how attackers operate and to map defenses.
VIRGIL includes notes on ATT&CK techniques so you can study them for your cert.

**RSS Feed**
RSS is a format that lets websites publish updates in a machine-readable way.
VIRGIL subscribes to security news sites (Bleeping Computer, SANS ISC, etc.)
and pulls their latest articles into your vault every morning automatically.

**Obsidian**
A free note-taking app that reads plain markdown files from a folder on your machine.
VIRGIL writes all your notes as markdown files — Obsidian turns them into a connected
knowledge graph you can search, browse, and navigate visually.

**Claude Code**
An AI coding and research assistant that runs in your terminal.
VIRGIL uses it as the primary interface for study sessions, slash commands,
and interacting with your vault using natural language.

**Ollama**
A tool that lets you run AI language models locally on your own hardware.
VIRGIL can use Ollama instead of an API key if your machine has enough RAM or a GPU.
See the hardware requirements section before installing.

---

## Step 1 — Check your hardware, then install Ollama

### Before you pull a model — check your hardware

`qwen2.5:14b` requires approximately 16 GB of RAM and runs best with a GPU.
Running it on an underpowered machine will cause it to hang or crash silently.

```bash
free -h          # RAM — need 16 GB+ for qwen2.5:14b
nproc            # CPU cores
lspci | grep -i vga   # GPU (optional but recommended)
```

| Your hardware | Recommended model | RAM needed |
|---|---|---|
| GPU with 16 GB+ VRAM | `qwen2.5:14b` (best quality) | 16 GB RAM |
| GPU with 8 GB VRAM | `qwen2.5:7b` (good quality) | 8 GB RAM |
| No GPU / older laptop | Use Anthropic API key instead | Any |
| Unsure | Use Anthropic API key instead | Any |

If you're not sure, use an Anthropic API key — it's faster to set up and costs
roughly $3–5/month at typical usage: https://console.anthropic.com

### Install Ollama and pull your model

```bash
curl -fsSL https://ollama.com/install.sh | sh

# Replace qwen2.5:14b with qwen2.5:7b if you have less than 16 GB RAM
ollama pull qwen2.5:14b
```

**Did it work?**
```bash
ollama run qwen2.5:14b "Hello"
```
You should see a short response. If Ollama isn't running, see [Troubleshooting](#troubleshooting).

> **Reasoning models (deepseek-r1, deepseek-r1 variants):** Set `num_predict` to at least 3000 — these models use internal thinking tokens and may return empty responses on complex questions if the limit is too low. Add `PARAMETER num_predict 3000` to your Modelfile or pass `--num-predict 3000` when running.

---

## Step 2 — Run the VIRGIL installer

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/BlueTeamBardiel/VIRGIL-Second-Brain/main/scripts/install.sh)
```

The installer:
- Creates `~/VIRGIL/` with the full vault structure
- Installs scripts to `~/.local/bin/`
- Sets up crontab for daily ingest, nightly memory distillation, weekly rollup
- Runs a live CVE demo so you can see it working

**Did it work?**
```bash
ls ~/VIRGIL/notes/
```
You should see `inbox/`, `mitre/`, `cve/`, `feeds/`, `knowledge/`.

---

## Step 3 — Open the vault in Obsidian

Download [Obsidian](https://obsidian.md) (free) if you don't have it.

1. Open Obsidian → **Open folder as vault**
2. Navigate to `~/VIRGIL` (default install path)
3. Click **Open**

Obsidian indexes all Markdown files. The left sidebar shows your folder structure. Press `Ctrl+G` to open graph view.

**Did it work?**

You should see folders in the left sidebar and notes in `notes/knowledge/`. Press `Ctrl+G` — if notes have wikilinks, you'll see a connected graph.

**Windows (WSL2):** In the folder picker, type `\\wsl.localhost\Ubuntu\home\<your-ubuntu-username>\VIRGIL` directly into the address bar.

---

## Step 4 — Install Claude Code and open VIRGIL

Claude Code is the AI terminal interface for VIRGIL — it's how you run study sessions,
use slash commands, and interact with your notes using natural language.

### Install Claude Code

```bash
# Requires Node.js. Install it first if you don't have it:

# Ubuntu/Debian:
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# macOS (with Homebrew):
brew install node

# Install Claude Code
npm install -g @anthropic-ai/claude-code

# Verify
claude --version
```

### Open VIRGIL

```bash
cd ~/VIRGIL && claude
```

VIRGIL introduces itself and shows your vault status. From here:

| Command | What it does |
|---------|-------------|
| `/secplus` | Security+ SY0-701 Feynman study session |
| `/cysa` | CySA+ CS0-003 domain-mapped study session |
| `/ccna` | CCNA routing/switching study session |
| `/aplus` | A+ Core 1/Core 2 study session |
| `/virgil-quiz "topic"` | Quiz yourself on any topic from your vault |
| `/reflect` | End-of-session memory distillation |
| `/handoff` | Save session context before closing |

**Did it work?**

Type `/secplus` and answer the first question. If you get a Feynman-style prompt back, the system is working. If you get an error, see [Troubleshooting](#troubleshooting).

---

## Your First 5 Minutes

You've installed VIRGIL and opened it in Claude Code. Here's what to do right now.

**Day 1 reality:** `quiz-scores.json` doesn't exist yet. The study commands work, but they'll pull random topics instead of weak ones — because you have no quiz history yet. That's fine. Fix it in 5 minutes.

### 1. Seed your quiz history

```bash
virgil-quiz
```

This runs a 5-question quiz on a random topic and creates `logs/quiz-scores.json`. Answer honestly — this is how VIRGIL learns what you know.

### 2. Check your baseline

```bash
virgil-progress
```

Everything will show 0% or "no data" on day 1. That's expected. Bookmark this output — check it again in a week.

### 3. Start a study session

Open Claude Code, then:
```
/secplus
```
or `/cysa` if that's your cert. VIRGIL pulls your weakest topics and starts drilling with Feynman analogies and exam questions.

### Did it work?

- [ ] `virgil-quiz` ran and asked 5 questions
- [ ] `logs/quiz-scores.json` now exists
- [ ] `virgil-progress` printed your cert dashboard
- [ ] `/secplus` gave you a Feynman explanation + exam question

**Your vault is pre-loaded.** You have 1,500+ notes installed — Security+, CySA+, CCNA, ATT&CK techniques, and CVEs. The ingest pipelines will continue adding live threat intel each morning. By day 3, the vault is actively updating itself.

---

## Step 5 — Run your first ingest

```bash
# Pull today's threat intel feeds
virgil-rss

# Ingest a MITRE ATT&CK technique
virgil-url https://attack.mitre.org/techniques/T1059/

# Pull recent CVEs
virgil-cve --recent
```

Open Obsidian. You'll see new notes in `notes/feeds/`, `notes/mitre/`, and `notes/cve/`. Click into them and follow the `[[wiki links]]`.

---

## Step 6 — The daily habit

VIRGIL runs mostly on autopilot once crontab is configured.

1. **Morning**: Check `notes/feeds/YYYY-MM-DD.md` for overnight threat intel digest
2. **During study**: Use `virgil-pdf` and `virgil-url` to capture anything interesting
3. **After a quiz**: Run `virgil-review` — this is the most important 5 minutes you'll spend
4. **After a session**: Run `/reflect` to distill your session into permanent memory
5. **Sunday**: Check `weekly-summaries/YYYY-WNN.md` for the week's synthesis

### virgil-review — your daily spaced repetition session

After any quiz, run:

```bash
virgil-review
```

This surfaces your weakest topics using the SM-2 spaced repetition algorithm — the same algorithm behind Anki. Topics you struggle with come back sooner; topics you've mastered drift further out. Without review, quiz scores don't compound. With it, you build durable knowledge instead of short-term recall.

`virgil-review` shows what's due today, what's coming up, and lets you jump straight into a quiz on the top overdue topic. It takes 5–10 minutes.

---

## Your first week with VIRGIL

| Day | What to do | Command |
|-----|-----------|---------|
| 1 | Set up your profile and find your starting point | `/start` then `/diagnose` |
| 2 | First teaching session — learn from your vault | `/teach` |
| 3 | First quiz + spaced repetition review | `virgil-quiz [topic]` then `virgil-review` |
| 4 | Check your progress by domain | `virgil-progress` |
| 7 | Weekly synthesis — what you covered this week | `/week` |

After day 7, the system runs itself. The cron jobs pull threat intel, your quiz scores track what you know, and `virgil-review` tells you what to study next.

---

## Slack integration (optional)

If you want to approve/deny pipeline actions from your phone, VIRGIL has a Slack bot. This is completely optional and not required for any core functionality.

See [ARCHITECTURE.md](ARCHITECTURE.md) for setup instructions. Skip this entirely if you just want the knowledge base.

---

## Optional — Local RAG setup

RAG (Retrieval-Augmented Generation) lets VIRGIL query your actual vault notes during every conversation instead of relying only on the model's training data.

Without RAG, VIRGIL knows what it was trained on. With RAG, VIRGIL knows what *you* know — your notes, your CVEs, your lab configs.

**What you need:**
```bash
pip install chromadb --break-system-packages
ollama pull nomic-embed-text
```

**Set up the embedding pipeline:**
```bash
python3 ~/VIRGIL/ingest/chroma-ingest.py  # embeds notes into ChromaDB
```

**Wire into OpenWebUI:**
1. Install the Pipelines service:
   ```bash
   docker run -d --name pipelines --network host \
     -v ~/pipelines:/app/pipelines \
     --restart always \
     ghcr.io/open-webui/pipelines:main
   ```
2. Copy the pipeline file:
   ```bash
   cp ~/VIRGIL/ingest/virgil_rag_pipeline.py ~/pipelines/virgil_rag.py
   docker restart pipelines
   ```
3. In OpenWebUI → Admin Settings → Connections → add URL: `http://localhost:9099`, API Key: `0p3n-w3bu!`
4. Select **VIRGIL RAG** from the model dropdown.

**Make ingest persistent:**
```bash
# Add to crontab — re-embed vault nightly so new notes are searchable
python3 ~/VIRGIL/ingest/chroma-ingest.py  # embeds notes into ChromaDB
```

---

## Windows (WSL2) setup

VIRGIL's scripts and vault run inside WSL2. Obsidian and Claude Code run natively on Windows. They connect through a network path.

### Step 1 — Enable WSL2

Open PowerShell **as Administrator**:
```powershell
wsl --install
```
Reboot when prompted. Ubuntu will finish setting up — create a username and password when asked.

### Step 2 — Install Windows-side tools

- **[Obsidian](https://obsidian.md)** — native Windows app
- **[Claude Code](https://claude.ai/code)** — run the installer from inside the Ubuntu terminal

### Step 3 — Run the VIRGIL installer inside WSL2

Open your Ubuntu terminal (search "Ubuntu" in the Start menu):
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/BlueTeamBardiel/VIRGIL-Second-Brain/main/scripts/install.sh)
```

### Step 4 — Connect Obsidian to the vault

1. Open Obsidian → **Open folder as vault**
2. Type this path directly into the address bar:
   ```
   \\wsl.localhost\Ubuntu\home\<your-ubuntu-username>\VIRGIL
   ```
3. Click **Open**

### Step 5 — Fix cron (WSL2 doesn't autostart it)

```bash
echo -e "[boot]\ncommand=service cron start" | sudo tee -a /etc/wsl.conf
```
Restart WSL (`wsl --shutdown` in PowerShell, then reopen Ubuntu). Verify: `service cron status`

---

## Troubleshooting

### Ollama not running

```bash
# Check if Ollama is running
curl http://localhost:11434/api/tags

# Start it if not
ollama serve &

# Or as a service
sudo systemctl start ollama
```

If `curl` returns connection refused, Ollama isn't started. Run `ollama serve` in a separate terminal.

### Claude Code not authenticated

```bash
# Verify your API key is set
echo $ANTHROPIC_API_KEY

# If empty, source your env file
source ~/.env

# Or set it directly
export ANTHROPIC_API_KEY=sk-ant-...
```

If you're using local-only mode (Ollama), set `VIRGIL_BACKEND=ollama` in `~/.env` — this skips the API key check entirely.

### Vault not found in Obsidian

1. Verify the vault was created: `ls ~/VIRGIL/notes/`
2. In Obsidian, use **Open folder as vault** — do not use **Create new vault**
3. On WSL2: make sure Ubuntu is running before opening Obsidian; the network path `\\wsl.localhost\...` only appears when WSL is active

---

## Vault structure

```
notes/
├── inbox/        ← Drop anything here; triage routes it nightly
├── mitre/        ← ATT&CK techniques (auto-ingested)
├── cve/          ← CVE notes (auto-generated daily from NVD)
├── feeds/        ← Daily threat intel digests (6am)
├── knowledge/    ← Study library
│   ├── security/
│   ├── networking/
│   └── nist/
└── personal/     ← Your notes (gitignored)
```

---

## Memory system

Three files track your persistent context (gitignored — they stay on your machine):

| File | What it holds |
|------|--------------|
| `memory-working.md` | Active tasks and current sprint. Cleared weekly by `promote.sh`. |
| `memory-episodic.md` | Dated history of what you've done. Append-only. |
| `memory-semantic.md` | Permanent facts: your lab setup, certs in progress, key decisions. |

When you run `/reflect`, VIRGIL reads these files to give you context-aware responses. Update `memory-semantic.md` with facts you want VIRGIL to always know about your setup.

---

## Common Obsidian shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+F` | Search all note content |
| `Ctrl+O` | Quick switcher — jump to any note by name |
| `Ctrl+G` | Graph view |
| `Ctrl+[` | Back in history |

The wikilink-ingest script (runs nightly at 11:30pm) automatically injects `[[wiki links]]` for any mention of a known note title. You don't have to manually link everything.

---

Full architecture details: [`ARCHITECTURE.md`](ARCHITECTURE.md)

