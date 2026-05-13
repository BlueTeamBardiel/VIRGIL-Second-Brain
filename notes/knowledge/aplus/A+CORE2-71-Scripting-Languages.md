# Scripting Languages

## What it is

You arrive Monday and the helpdesk queue has 47 tickets that all say the same thing: "Need printer remapped." You can click through each one in 90 seconds. That's 70 minutes of clicking. Or you write six lines of PowerShell, run it against the OU, and it's done before your coffee cools.

That's scripting. **A script is a text file full of commands an interpreter runs top-to-bottom.** No compiling, no IDE, no build pipeline — write it, save it, run it. The OS already ships with the interpreter (PowerShell on Windows, Bash on Linux/macOS, Python damn near everywhere).

In body terms: if a full application is muscle memory baked in, a script is **a sticky note you hand the system that says "do these things in this order."** Disposable, fast, and exactly powerful enough to be dangerous.

## Why it matters

The A+ tech who scripts gets promoted. The one who clicks 47 times stays on the queue. **CompTIA tests this in Objective 220-1202 4.8** — file extensions, use cases, and the very specific ways scripts blow up in production.

You don't need to be a programmer. You need to recognize file types, know what they're for, and understand why your security team gets twitchy when a `.ps1` shows up in someone's Downloads folder.

## At home, at work

**Beat 1 — The file types.** Six extensions, three platforms. Memorize the table; CompTIA will give you a filename and ask what runs it.

| Extension | Interpreter | Platform | What it's for |
|---|---|---|---|
| `.bat` | cmd.exe | Windows | Legacy batch files. Old, simple, still everywhere |
| `.ps1` | PowerShell | Windows (+ cross-platform now) | Modern Windows automation. AD, Exchange, Azure |
| `.vbs` | Windows Script Host | Windows | Old VBScript. Mostly dead, legacy login scripts still exist |
| `.sh` | Bash / sh | Linux, macOS | Shell scripts. The Linux admin's daily bread |
| `.js` | Node.js or browser | Cross-platform | JavaScript. Browser automation, occasionally server-side |
| `.py` | Python | Cross-platform | The universal glue. Helpdesk to ML |

**Beat 2 — Familiar territory.** You've already written scripts and didn't call them that. A Steam launch option with `-novid -high`? One-line script. An AutoHotkey macro that rebinds your mouse side-button to Discord push-to-talk? Script. The `.bat` your buddy sent in 2014 that "fixes your Minecraft" by setting Java flags? Script — and a great example of why you shouldn't run random `.bat` files from strangers.

*If you've ever automated a repetitive thing on your own machine, you already think like a scripter. You just need the vocabulary.*

**Beat 3 — Unfamiliar territory.** In the enterprise, scripts run at scale and the blast radius is everyone. The exam objective lists these use cases — these are the ones you'll actually do:

- **Basic automation** — anything you'd do more than twice
- **Restarting machines** — `shutdown /r /m \\PC-NAME /t 0` across a hostname list after patches
- **Remapping network drives** — login script mapping `H:` based on AD group
- **Installation of applications** — silent installers pushed via PowerShell or `.bat` wrapper
- **Automated backups** — `robocopy` on a schedule, or `rsync` on the Linux side
- **Gathering information/data** — hardware inventory, installed software, last-login times
- **Initiating updates** — Windows Update or `apt upgrade` on a schedule

**Beat 4 — The point.** Same principle as your AutoHotkey macro: if you do it more than twice, automate it. But at work the script touches 500 machines instead of one, runs as SYSTEM instead of you, and a typo doesn't just break your rig — it breaks the company. *Scale changes everything about the risk.*

## Key facts

### CompTIA's "other considerations" — read this twice

The exam objective spells out the ways scripts go wrong. Each one is a real outage waiting to happen:

- **Unintentionally introducing malware** — you grab a script off Stack Overflow, paste it in, run it as admin. Surprise: the helpful one-liner also added a scheduled task you didn't notice. Read every line before you run it. Better: get scripts from your team's vetted repo.
- **Inadvertently changing system settings** — a script that "just installs an app" also disables Defender, opens firewall ports, or changes UAC. PowerShell will happily reconfigure half the OS if you tell it to.
- **Browser or system crashes due to mishandling of resources** — infinite loops, memory leaks, or a script that spawns 10,000 processes. The classic is the fork bomb. Test in a VM first.

> **CompTIA exam trap:** They will ask "what's a risk of running scripts?" and the wrong answers will sound technical (buffer overflow, SQL injection). The right answers come straight from objective 4.8: **introducing malware, changing system settings inadvertently, and crashes from resource mishandling.** Memorize the exact phrasing.

### Execution policy and signing (PowerShell specifically)

Windows ships with PowerShell's execution policy set to **Restricted** by default. Common policies:

- **Restricted** — no scripts run. Default on clients.
- **RemoteSigned** — local scripts run; downloaded scripts need a digital signature. Common on workstations.
- **AllSigned** — every script must be signed. Common in regulated environments.
- **Unrestricted / Bypass** — everything runs. Used in dev and only in dev.

*Execution policy is not a security boundary — a determined user can bypass it. It's a guardrail against accidents, not attackers.*

## Helpdesk reality

- **User says:** "IT sent me a file called `fix.ps1` and Windows won't open it." → They downloaded it from email. You don't know what it is. Don't run it. Verify it came from your team's signed share before anything else.
- **User says:** "Can you write me a script to rename 4,000 files?" → Yes, and this is exactly the kind of win that gets you noticed. Python + `os.rename` or PowerShell `Rename-Item`. Test on a copy first.
- **You wrote a script that worked on your machine.** It runs as SYSTEM on the target and breaks because SYSTEM doesn't have the user's mapped drives. *The account running the script is not the user logged in.*
- **Never run a script you don't understand line by line** — especially one with `Invoke-Expression`, `iex`, `curl | bash`, or base64 blobs. That's how ransomware loaders start.
- **Always test in a VM or on one machine first.** "It worked on my box" is the most expensive sentence in IT.

## AI tools as tickets and triage helpers

Two legitimate uses for company-approved AI (Copilot, Now Assist, internally-deployed models):

- **Explaining a script you didn't write.** Inherit a 200-line PowerShell script from the admin who left last quarter. Paste it into Copilot and ask "walk me through what this does, section by section." The AI summarizes; you verify.
- **Drafting boilerplate.** "Write me a PowerShell snippet that pings a list of hostnames from a CSV and outputs results to another CSV." Gets you 80% there in five seconds. You review, fix edge cases, test in a VM.

**Hard rule:** never paste scripts containing credentials, internal hostnames, API keys, or user data into a tool that hasn't been vetted by security. **Sanitize first.** Never run AI-generated code in production without reading every line — the AI will confidently hallucinate cmdlets that don't exist.

*Tool, not crutch. The AI writes the draft; you own what it does.*

## The honest part about your first IT job

You will not be writing scripts on day one. You'll be resetting passwords, walking users through Outlook, and watching the senior tech write a one-liner that saves the team an hour. **Pay attention to those one-liners.** Ask what they did. Ask if you can try writing the next one. That's how you climb out of the queue.

Start with PowerShell for Windows shops, Bash for Linux/cloud, Python for options. You don't need to be a developer. You need to be the helpdesk tech who automates their own job — the one who does gets promoted to sysadmin within 18 months. *The ticket queue is the floor. Scripting is the ladder.*

## Related concepts

[[Operating Systems]] · [[PowerShell]] · [[Command Line Tools]] · [[Change Management]] · [[Malware]] · [[Backup Methods]] · [[Active Directory]] · [[Group Policy]]

*Source: VIRGIL knowledge base — 2026-05-11*