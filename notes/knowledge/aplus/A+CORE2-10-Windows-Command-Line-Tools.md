# Windows Command Line Tools

## What it is

You open Command Prompt because the GUI is lying to you. Explorer says the file copied; the destination is empty. Settings says the network is connected; nothing loads. The GUI is the personality — friendly, opinionated, sometimes wrong. The command line is the nervous system speaking directly. No middleman, no animations, no "we're working on it." You type, the OS does, the OS reports back.

In plain English: Windows ships with dozens of built-in commands that do what the GUI does, plus things the GUI can't do at all. Some manage files. Some interrogate the network. Some repair the OS when it's eating itself. Knowing which command answers which question is the difference between a 30-minute ticket and a 3-hour ticket.

Technically: these are executables living in `C:\Windows\System32`, invoked from `cmd.exe` (or PowerShell, which inherits them). They take arguments, return exit codes, and write to stdout/stderr. Run them as standard user for read operations; right-click → Run as administrator for anything that writes to the OS, the disk, or policy.

## Why it matters

CompTIA tests this objective heavily because it separates the tech who can troubleshoot from the tech who can only click. Objective 220-1202 1.5 lists roughly 25 commands by name, and the exam will hand you a scenario and ask which one to run. "User says they can reach Google but not the file server" — that's a different command than "user's profile won't load on the domain."

In the real job, the command line is faster. Always. You'll watch senior techs diagnose a network issue in 90 seconds with three commands while the GUI tech is still waiting for Network and Sharing Center to populate. Speed in the ticket queue is the difference between hitting your SLA and explaining to your manager why you didn't.

It's also how scripts work. Every login script, every group policy preference, every PDQ deploy job — they're command-line tools wrapped in automation. You can't write a useful script if you don't know what commands exist.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Commands fall into six functional groups. Navigation moves you around the filesystem (`cd`, `dir`). File management creates, copies, and destroys (`md`, `rmdir`, `robocopy`). Disk management touches storage at a low level (`chkdsk`, `format`, `diskpart`, `sfc`). Network covers everything from "is this host alive" to DNS resolution (`ping`, `tracert`, `pathping`, `nslookup`, `ipconfig`, `netstat`, `net use`). OS management touches policy and system state (`gpupdate`, `gpresult`). Informational answers "where am I, who am I, what version is this" (`hostname`, `whoami`, `winver`, `net user`). The universal helper is `/?` — append it to any command for syntax. `robocopy /?` is a small book. `ping /?` fits on one screen.

**Beat 2 — Feynman example via gaming/personal build.** You finish a new build at 1am. Windows installed clean, drivers loaded, but Steam won't connect. Browser works. Discord works. Steam just spins.

**Step one — `ping 8.8.8.8`.** Replies come back. *Internet works at the IP layer.* Not a cable, not a router, not the ISP.

**Step two — `ping store.steampowered.com`.** Replies come back too. *DNS resolves and the server is up.* So it's not Steam's servers either.

**Step three — `netstat -ano | findstr ESTABLISHED`.** Steam has connections open. Something's flowing. *Not a total block — partial.*

**Step four — `tracert store.steampowered.com`.** Twelve hops, all clean. But one of them is timing out intermittently. Your new ISP is doing something weird with the route to Valve's CDN. *Reboot the router, the route changes, Steam connects.*

Five minutes. No GUI tool gives you that path of reasoning. The command line let you isolate the layer.

**Beat 3 — Bridge from gaming to enterprise.** Same workflow, different stakes. A user calls: "I can't open the shared drive." At home you'd shrug and reboot. At work:

- `hostname` — confirm which machine you're actually on (remote session, easy to forget)
- `whoami` — confirm whose credentials are running this session
- `ping fileserver01` — is the server reachable by name?
- `nslookup fileserver01` — does DNS resolve it correctly, and to the right IP?
- `net use` — what drive mappings does this user actually have right now?
- `net use Z: \\fileserver01\share` — remap it
- `gpresult /r` — confirm group policy applied; the drive-map GPO might have failed
- `gpupdate /force` — pull policy fresh

That's a five-minute fix that would take 45 minutes through Control Panel, Settings, and File Explorer guesswork.

**Beat 4 — The point.** Same fundamental question across every build, every job: *what layer is broken?* Physical, link, network, transport, application, identity, policy. The commands are the probes that let you ask the layer directly. Learn which command interrogates which layer and you'll diagnose anything. Get this into your bones — you'll type these for the rest of your career.

## Key facts

### Navigation and file management

| Command | What it does | Example |
|---|---|---|
| `cd` | Change directory. `cd ..` goes up one level. `cd \` goes to drive root. | `cd C:\Users\jsmith\Desktop` |
| `dir` | List directory contents. `/a` shows hidden, `/s` recurses. | `dir /a /s C:\Temp` |
| `md` (or `mkdir`) | Create a directory. | `md C:\Logs\2026` |
| `rmdir` (or `rd`) | Remove a directory. `/s` deletes contents too, `/q` skips confirmation. | `rmdir /s /q C:\OldLogs` |
| `robocopy` | Robust file copy. Resumes interrupted copies, preserves ACLs, mirrors directories. | `robocopy C:\Source D:\Dest /MIR /Z` |

> **CompTIA exam trap:** `copy` and `xcopy` are not on the 1202 objectives — `robocopy` is. CompTIA wants you to know `robocopy` because it's the production tool: it survives network drops, preserves NTFS permissions, and handles paths over 260 characters. `/MIR` mirrors source to destination (deletes files at destination that don't exist at source — dangerous if you reverse the arguments).

### Disk and OS health

| Command | What it does |
|---|---|
| `chkdsk` | Scans disk for filesystem errors. `/f` fixes errors, `/r` locates bad sectors. Needs reboot for system drive. |
| `sfc /scannow` | System File Checker. Verifies and repairs protected Windows files from the component store. |
| `format` | Formats a volume. `format D: /fs:ntfs /q` for quick NTFS format. |
| `diskpart` | Interactive disk partitioning tool. Subcommands: `list disk`, `select disk 1`, `clean`, `create partition primary`. |
| `winver` | Pops a tiny dialog showing exact Windows version and build. First thing you check on any unknown machine. |

> **CompTIA exam trap:** `chkdsk /f` versus `chkdsk /r`. `/f` fixes filesystem errors only. `/r` implies `/f` and also scans for bad sectors and recovers readable data. `/r` takes hours on a spinning disk. CompTIA loves asking which one to run for "physical disk errors" — answer is `/r`.

### Network commands

| Command | What it does |
|---|---|
| `ipconfig` | Shows IP config. `/all` shows DNS, DHCP, MAC. `/release` and `/renew` for DHCP. `/flushdns` clears DNS cache. |
| `ping` | ICMP echo to a host. Tests reachability and round-trip time. `-t` runs continuously. |
| `tracert` | Traces the route to a destination, hop by hop. Shows where latency or drops occur. |
| `pathping` | Hybrid of `ping` and `tracert`. Runs for several minutes, reports loss per hop. Better for intermittent issues. |
| `nslookup` | Queries DNS. `nslookup google.com` returns the IP. Interactive mode lets you query specific record types. |
| `netstat` | Shows active connections and listening ports. `-ano` shows all sockets with PIDs. `-rn` shows routing table. |
| `net use` | Lists or maps network drives. `net use Z: \\server\share /persistent:yes` |
| `hostname` | Prints the computer's name. One word, no flags. |

### Policy and identity

| Command | What it does |
|---|---|
| `gpupdate` | Refreshes group policy. `/force` reapplies all settings even if unchanged. |
| `gpresult` | Shows what policies actually applied to the user/computer. `/r` for summary, `/h report.html` for full HTML report. |
| `whoami` | Prints the current user. `/groups` lists group memberships, `/priv` shows privileges. |
| `net user` | Lists local users. `net user jsmith` shows account details. With admin rights, can create/modify accounts. |

### The universal helper

`[command] /?` — every built-in command supports this. Forgot robocopy syntax? `robocopy /?`. Forgot ipconfig flags? `ipconfig /?`. This is the answer to half the exam scenarios that ask "how do you find correct syntax."

### Consumer vs. enterprise

**At home,** you'll use maybe five of these regularly: `ipconfig`, `ping`, `chkdsk`, `sfc`, and `dir`. The rest sit unused because there's no domain, no file server, no group policy, no centralized DNS to query, no shared drives to remap.

**In an enterprise environment, this changes:**

- `gpupdate` and `gpresult` become daily tools — every Windows machine on a domain pulls policy, and when policy breaks (printer GPO didn't apply, drive map missing, security setting reverted), these are your first calls
- `net use` is how you diagnose every "I can't see the S: drive" ticket — the GUI hides the actual mappings, the command shows truth
- `nslookup` matters because enterprises run internal DNS — when `fileserver01` resolves to the wrong IP, you're chasing a stale DNS record
- `robocopy` runs in scheduled tasks and migration scripts; consumer file copy never touches it
- `netstat -ano` is how the security team finds the malicious process holding a connection open to a C2 server
- `whoami /groups` matters when a user can't access a folder — you're checking which AD groups they're actually a member of versus what the share's ACL requires

Your home toolkit covers maybe 20% of what the helpdesk queue throws at you. Build the muscle memory on the other 80% before your first day.

## Helpdesk reality

- **"My internet is broken."** Translation: something is broken. Could be Wi-Fi, DNS, a captive portal, a VPN, a single website, or their browser. `ping 8.8.8.8` and `nslookup google.com` separate "no internet" from "no DNS" in 10 seconds.
- **"I can't get to the shared drive."** Run `net use` first. The mapping might just be gone. If it's there, `ping` the server. If that works, the share permissions changed — escalate to whoever owns the file server.
- **"My computer is slow."** Don't promise a fix. Run `sfc /scannow` and `chkdsk` as first-pass health checks while you ask what changed recently. Slowness is rarely one cause.
- **"Group policy isn't applying."** `gpresult /h c:\temp\gp.html` produces a full report. Open it, find the failed GPO, read the error. Half the time it's a WMI filter or a security group the user isn't in.
- **Never run `format` or `diskpart clean` without triple-checking the target.** `diskpart` will happily wipe the wrong disk and not warn you twice. Always `list disk` and confirm size before `select disk N`. *This is how techs become former techs.*

## Related concepts

[[Windows Settings and Control Panel]] · [[PowerShell Basics]] · [[Group Policy]] · [[Active Directory]] · [[Windows File Systems NTFS and ReFS]] · [[Network Troubleshooting Methodology]] · [[DNS Fundamentals]] · [[Windows Recovery Environment]]

*Source: VIRGIL knowledge base — 2026-05-10*