# Claude Code — VIRGIL-Second-Brain (public)

Repo context: the public open-source release of VIRGIL. Users who land here
range from senior engineers to people who have never opened a terminal
before. The installer, ingest scripts, starter notes, and guided wizard all
run on strangers' machines. Assume **no technical knowledge**.

## Confirmation Prompt Style

When asking the user to confirm any command or parameter — and when writing
installer or script prompts the user will see — always include a one-line
Feynman explanation in plain English *before* the confirmation.

Format:
  1. "[What this does in plain English — one sentence, no jargon, grounded in consequence.]"
  2. Show the command or parameter.
  3. Ask for confirmation.

The rule: if the user would need to Google what something does, explain it
first. In a public-facing repo, that threshold is low. Acronyms like RSS,
CVE, NVD, API, vault, crontab, cron, AppImage, Ollama, and WSL all require
definition on first appearance inside a prompt.

### Examples

BAD:
"Install crontab schedules? [Y/n]"

GOOD:
"Cron is a tool that runs scripts on a schedule — like setting a recurring
alarm on your phone, but for commands. VIRGIL uses it to pull threat intel,
fetch new vulnerabilities, and tidy your notes while you sleep. Saying yes
adds 7 scheduled jobs; saying no means you run them manually when you want
to. You can change this later with `crontab -e`.
Install crontab schedules? [Y/n]"

BAD:
"Paste your Anthropic API key:"

GOOD:
"An API key is like a password that lets VIRGIL talk to Claude AI. VIRGIL
uses it to turn raw CVE data and news headlines into plain-English
explanations you can actually learn from. Without it, notes save as raw
data — still useful, but not enriched. You can add it later by editing
~/VIRGIL/.env. Skip this if you plan to use local inference via Ollama.
Paste your Anthropic API key (get one free at console.anthropic.com):"

BAD:
"Obsidian not found. Install it? [y/N]"

GOOD:
"Obsidian is the app you use to read and navigate your VIRGIL vault — think
of it as a browser for your notes that shows you how they connect. This
download is about 100 MB and takes a minute on a typical connection. You
can also install it later manually from https://obsidian.md.
Download and install the Obsidian AppImage now? [y/N]"

### Public-repo-specific rules

- **Never assume the user knows what a terminal command does.** Every flag,
  every path, every environment variable — explain consequence in one line.
- **Consequences belong before commands.** "This deletes X" comes *before*
  `rm -rf X`, never after.
- **Say what lives locally vs. what phones home.** Users coming from
  subscription tools need to know their data stays on their machine.
- **Never use jargon without unpacking it.** RSS = "news feed format."
  NVD = "government vulnerability database." Cron = "scheduled job tool."
- **Give the opt-out.** Every prompt should make saying *no* safe and
  explain what happens if they do.
- **Writing installer prompts?** Every `read -r -p` line is a user-facing
  prompt — the lines above it must Feynman-explain what the input will do.

### When this does NOT apply

- Reading files (Read/Grep/Glob) — no user confirmation needed at all
- Internal refactors — the diff is the explanation to the maintainer
- Commit messages — keep these precise and technical (PR reviewers read them)
- `.github/` workflows, CI config — maintainer-facing, not user-facing
