# Scripting Use Cases

## What it is

You have forty machines that need the same registry tweak by end of day. You can RDP into each one and click through it manually — three hours, mistakes guaranteed — or you write twelve lines of PowerShell and walk to lunch. That's scripting. It's how IT scales past the point where one human with a mouse can keep up.

In plain English: a script is a text file full of commands the OS runs top to bottom. No compiler, no build step. You save it, you run it, the machine does the work.

Technically: scripts are interpreted programs — interpreted by a shell (cmd, PowerShell, bash) or a runtime (Python, Node, the VBScript host). They automate tasks that would otherwise require manual clicks. On the A+ they live in domain 4.0 because scripting is operational glue: the thing techs reach for when the work outgrows the hands.

## Why it matters

Your first IT job will not have you writing scripts from scratch on day one. You'll *run* scripts other people wrote — onboarding scripts, drive-mapping scripts, software install scripts the senior tech committed to a shared repo three years ago. Knowing what file extension does what, and what a script can do when you double-click it, is table stakes. CompTIA tests this directly on 220-1202 objective 4.8.

The deeper reason: every step up the IT ladder — sysadmin, DevOps, security engineer — is a step further into scripting. The techs who learn to read and modify scripts in their first year promote out of the helpdesk. The ones who avoid the terminal stay on the phones.

## At home, at work

**Beat 1 — Technical depth.** Six file extensions matter for the exam:

| Extension | Interpreter | Platform | Typical use |
|---|---|---|---|
| `.bat` | cmd.exe | Windows | Legacy batch, simple automation, drive mapping |
| `.ps1` | PowerShell | Windows (cross-platform now) | Modern Windows admin, AD, Exchange |
| `.vbs` | Windows Script Host | Windows (legacy) | Old logon scripts, deprecated but in the wild |
| `.sh` | bash/sh | Linux, macOS | Everything on Unix-likes |
| `.js` | Node.js / browser | Cross-platform | Web automation, occasional system scripts via Node |
| `.py` | Python interpreter | Cross-platform | General-purpose glue, infrastructure tooling |

Execution policy matters. Windows blocks `.ps1` by default — `Set-ExecutionPolicy RemoteSigned` is the typical unlock. Linux requires `chmod +x` before a `.sh` will run. `.bat` and `.vbs` run on double-click, which is exactly why attackers love them as email attachments.

**Beat 2 — Feynman example via the homelab.** You spin up a Proxmox box and start collecting VMs.

**The first month:** You build each VM by hand. Click through the installer, set the hostname, install Docker, copy your SSH key. Forty minutes per VM, and you forget a step every third one. *Manual builds are inconsistent builds.*

**The script:** You write a `.sh` cloud-init script — twenty lines — that runs on first boot. Every VM comes up identical in four minutes. *The script is the documentation. The script is the standard.*

**The accident:** You add `rm -rf /tmp/*` to clean up build artifacts. You typo it as `rm -rf / tmp/*` — note the space. The script runs on your media-server VM at 3 AM. The VM eats itself. *A script does exactly what you wrote, at machine speed, with no second thoughts.*

**Beat 3 — Bridge to the enterprise.** The senior sysadmin maintains a PowerShell script that runs at user onboarding: creates the AD account, adds them to security groups, provisions a mailbox, maps department drives. You ran it forty times your first month and never thought about it. Then one day someone modifies the group list, doesn't test, and the next twelve hires land in Domain Admins. *Scripts at enterprise scale make mistakes at enterprise scale.*

**Beat 4 — The point.** A script is leverage. Leverage cuts both ways. The same fifty-line file that saves you six hours a week is the same file that can lock out three hundred users if someone changes one line and skips testing. *Read it first. Test it on one machine. Then deploy.*

## Key facts

### The seven use cases CompTIA tests

- **Basic automation** — repetitive tasks: renaming files, parsing logs, batch operations
- **Restarting machines** — scheduled reboots after patch night
- **Remapping network drives** — logon scripts connecting `H:` to home share, `S:` to department share
- **Installation of applications** — silent installers across the fleet (`msiexec /i app.msi /quiet`)
- **Automated backups** — scheduled robocopy, rsync, or Veeam jobs via Task Scheduler or cron
- **Gathering information/data** — inventory scripts pulling hostname, serial, software, disk into CSV
- **Initiating updates** — `Install-WindowsUpdate` or package-manager loops on a schedule

### The four ways scripts hurt you (also on the exam)

- **Unintentionally introducing malware** — you grab a "helper script" from a random GitHub gist. It works. It also phones home. *If you didn't read every line, you didn't audit it.*
- **Inadvertently changing system settings** — a script meant to fix one machine gets deployed fleet-wide and breaks something you didn't anticipate
- **Browser or system crashes** — a script eats memory in a loop, spawns processes faster than they exit
- **Mishandling of resources** — `Get-ChildItem -Recurse` on `C:\` pegs the disk for an hour; the backup script fills the destination drive

### CompTIA exam traps

> **CompTIA exam trap:** `.bat` vs `.ps1`. Batch files are the old cmd.exe world — limited, no real objects, mostly string juggling. PowerShell is the modern Windows answer with full .NET access. If a question mentions "modern Windows administration," the answer is `.ps1`. If it says "legacy" or "simple," it's `.bat`.

> **CompTIA exam trap:** `.vbs` is legacy. Microsoft is actively removing VBScript from Windows. If you see it on the exam, the context is "old logon script you inherited." Don't pick it as the modern answer.

> **CompTIA exam trap:** `.sh` does not run on Windows by default. If the question says "Linux server," it's `.sh`. If it says "Windows endpoint," it's not.

## AI tools as tickets and triage helpers

Two legitimate uses for company-approved AI (Copilot, internal models) when scripting comes up:

- **Reading scripts you didn't write.** A user opens a ticket saying "this onboarding script failed halfway through." Paste the relevant section into the approved AI and ask "what does this block do and where could it fail?" The AI explains syntax; you decide what to do.
- **Formatting a runbook entry.** After you resolve it, your rough notes — "PS exec policy blocked, set to RemoteSigned, reran, mapped drives" — go into the AI to come back as a clean KB article.

**Hard rule:** never paste a script containing credentials, API keys, internal hostnames, or customer data into a tool that hasn't been security-approved. Half the scripts in any enterprise have a hardcoded service account password somewhere they shouldn't. Sanitize before you paste, or don't paste at all.

## Helpdesk reality

- *User:* "I double-clicked the file from accounting and now my computer is doing weird stuff." Translation: they ran a `.bat` or `.vbs` attachment. Disconnect from network, escalate to security, image the machine. Don't troubleshoot possible malware in place.
- *User:* "The drive-mapping script isn't running on my laptop." Check group policy assignment, execution policy, and whether they're on corporate network or VPN. Logon scripts silently skip when the network isn't ready at logon.
- *User:* "I wrote a script to clean up my downloads folder and it deleted my desktop." Recover from backup. Never test destructive scripts against real data.
- Never run a script you found online on a production machine without reading it line by line. *The exam tests this; reality enforces it.*
- The first script you write in your IT career should solve a real problem you have right now. Not a tutorial example. That's how it sticks.

## Related concepts

[[PowerShell Basics]] · [[Command-Line Tools]] · [[Group Policy]] · [[Task Scheduler and Cron]] · [[Change Management]] · [[Malware Types]] · [[Backup Methods]] · [[Software Deployment]]

*Source: VIRGIL knowledge base — 2026-05-11*