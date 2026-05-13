# The Windows Network Command Line

## What it is

Every Windows tech eventually hits the moment when the GUI lies. The network icon shows connected, the browser shows nothing. Settings claims the DNS is set, but resolution fails. The GUI is a polite middleman; the command line is the direct line to the kernel.

Plain English: the Windows command line is a text interface where you type commands and the OS executes them. Two shells live there — **CMD** (the old Windows command interpreter, going back to DOS) and **PowerShell** (the modern object-oriented shell). For A+ you primarily live in CMD with the classic commands CompTIA loves: `ipconfig`, `ping`, `tracert`, `nslookup`, `netstat`. These are the **voice and ears** of the machine — how you ask the network stack what it's actually doing, not what the GUI claims it's doing.

Technical: these are Win32 console utilities that read directly from the TCP/IP stack, the DNS resolver cache, the routing table, the ARP cache, and the active socket table. They report ground truth. The GUI is a friendly translation layer over the same data — but when the translation breaks, you go to the source.

## Why it matters

Objective **220-1202 1.5** is a memorization gauntlet. CompTIA will give you a scenario — "a user reports they can ping by IP but not by hostname" — and expect you to instantly know that's a DNS problem and reach for `nslookup` or `ipconfig /flushdns`. They will not tell you which tool. You pick.

On the job, the command line is faster than the GUI for every networking question worth asking. The senior tech on your team will type `ipconfig /all` before they finish saying "let me take a look." It's muscle memory because it works. Learn it early or watch your tickets pile up while you click through five menus to find your default gateway.

## In your build, in the enterprise

**Beat 1 — The toolkit, by category.** The A+ network command line splits into five jobs: **see your config** (`ipconfig`, `hostname`, `whoami`, `getmac`), **test reachability** (`ping`, `tracert`, `pathping`), **test name resolution** (`nslookup`), **inspect connections** (`netstat`, `net use`), and **fix things** (`ipconfig /release`, `/renew`, `/flushdns`, `gpupdate`, `sfc`, `chkdsk`). Every command takes flags. `/?` after any command shows them — `ipconfig /?`, `ping /?`, `robocopy /?`. The `/?` flag is the most important command on the list because it's how you learn the rest without memorizing.

**Beat 2 — Diagnosing your gaming PC at 2am.** Discord call drops mid-raid. Browser says no internet. You alt-tab, hit Win+R, type `cmd`, and start the ladder.

**Step 1 — `ipconfig`.** Do I have an IP? If it's `169.254.x.x`, that's APIPA — DHCP failed, the router never gave me an address. *Address starting with 169.254 means "I never made it past the front door."*

**Step 2 — `ping 8.8.8.8`.** Can I reach the public internet by IP? If yes, the network works. If no, the problem is between me and the router or upstream. *Ping by IP isolates the network layer from DNS.*

**Step 3 — `ping google.com`.** Same destination, but now by name. If step 2 worked and step 3 fails, DNS is broken. `ipconfig /flushdns` clears the local resolver cache. *Pings by IP but not by name = DNS, every time.*

**Step 4 — `tracert google.com`.** Show me every hop. The hop where the timeouts start is where the problem lives. First hop is your router; if it times out, the problem is in your house. *Tracert tells you whose problem it is.*

**The kicker:** Nine times out of ten, it's the ISP and the fix is "wait twenty minutes." But now you know that instead of guessing.

**Beat 3 — Bridge to the enterprise helpdesk.** Same ladder, same commands, different scale. Tuesday morning ticket: "User in the Denver office can't reach the file server." You remote into their machine and run the exact same sequence. `ipconfig /all` shows the DNS server is pointing at an old domain controller that was decommissioned last month — Group Policy never updated this laptop because it hasn't been on the corporate network in three weeks. You run `gpupdate /force` to pull fresh policy, `ipconfig /registerdns` to re-register with the current DNS, and `net use Z: \\fileserver\share` to map the drive. Ticket closed in eleven minutes. The user thinks you're a wizard. You ran four commands.

**Beat 4 — The point.** Same fundamental question across every scale: **where is the break?** Physical layer, IP layer, DNS layer, application layer — the command line lets you test each one in isolation. The senior tech isn't smarter than you; they've just run this ladder ten thousand times and the order is reflex. Get the ladder into your bones now.

## Key facts

### The command table CompTIA tests

| Command | What it does | When to reach for it |
|---|---|---|
| `ipconfig` | Shows IP, subnet, gateway | First thing, every time |
| `ipconfig /all` | Adds DNS, DHCP, MAC, lease info | When `/?` isn't enough |
| `ipconfig /release` + `/renew` | Drop and request new DHCP lease | APIPA address, lease expired |
| `ipconfig /flushdns` | Clears the local DNS resolver cache | Site moved, you still hit old IP |
| `ipconfig /registerdns` | Re-register this host with DNS | Domain-joined machine, stale record |
| `ping <target>` | ICMP echo, tests reachability | Layer 3 sanity check |
| `tracert <target>` | Shows every router hop to destination | Find where the path breaks |
| `pathping <target>` | Tracert + per-hop packet loss stats | Better than tracert for flaky links |
| `nslookup <hostname>` | Query DNS directly | Is DNS resolving? To what? |
| `netstat -an` | All active connections + listening ports | What's talking to what |
| `netstat -b` | Adds process name (requires admin) | Which program opened that port |
| `net use` | Map/unmap network drives | `Z:` drive missing, mapping shares |
| `net user` | List/manage local users | Check account status, password reset |
| `hostname` | This machine's name | Fast check, no flags needed |
| `whoami` | Current logged-in user | "What account am I running as?" |
| `getmac` | MAC addresses of all NICs | MAC filtering, DHCP reservations |
| `gpupdate /force` | Pull fresh Group Policy now | Policy change didn't apply |
| `gpresult /r` | Show which policies applied to this user/machine | Verify GPO actually hit |
| `sfc /scannow` | System File Checker — repair OS files | Suspect corrupted Windows files |
| `chkdsk C: /f` | Check disk, fix filesystem errors | Disk-level errors, dirty bit set |
| `diskpart` | Interactive disk/partition manager | Wipe drives, create partitions |
| `format` | Format a volume | New drive, repurpose old drive |
| `cd` | Change directory | Move around the filesystem |
| `dir` | List directory contents | "What's in this folder?" |
| `md` / `rmdir` | Make/remove directory | Scripted folder setup |
| `robocopy` | Robust file copy with retry, mirror, logging | Anything beyond a simple copy |
| `winver` | Show Windows version + build | "What build are they on?" |

### CompTIA exam traps

> **CompTIA exam trap:** `tracert` vs `traceroute`. Windows uses `tracert` (eight letters, fits the old DOS 8.3 naming). Linux/macOS use `traceroute`. CompTIA will put both on a Windows-scenario question and one is wrong.

> **CompTIA exam trap:** `ping` by IP works, `ping` by name fails — this is **DNS**, not connectivity. Don't pick "check the cable." The cable is fine; the resolver isn't.

> **CompTIA exam trap:** `ipconfig /renew` does nothing useful if you didn't `/release` first on a stuck lease. CompTIA will offer both as separate answers — pick `/release` then `/renew`, or pick the answer that shows both.

> **CompTIA exam trap:** `netstat` alone shows established TCP connections only. To see **listening ports too**, you need `-a`. To see **numeric IPs and ports** (no DNS lookups slowing it down), add `-n`. The combo `netstat -an` is the muscle-memory answer.

> **CompTIA exam trap:** `sfc /scannow` and `chkdsk` are not the same thing. **`sfc`** repairs Windows system files (the OS). **`chkdsk`** repairs the filesystem on a disk (NTFS metadata, bad sectors). CompTIA loves to swap them in answer choices.

### Consumer vs. enterprise

**At home:** You run these commands on your own machine, you have admin already, and the worst that happens is you break your own Wi-Fi for twenty minutes. `ipconfig /flushdns` and a restart fix most things.

**In the enterprise:** It changes. You're remoting into someone else's machine, often a domain-joined laptop with Group Policy locking things down. You need admin credentials to run half these commands (`netstat -b`, `sfc`, `chkdsk` on the system drive, anything that touches `diskpart`). Group Policy is now a player — `gpupdate /force` and `gpresult /r` become daily commands you never touched at home. DNS isn't your router; it's a domain controller, and a stale DNS record can take down a user's access to twenty internal apps at once. `net use` to map drives is replaced or supplemented by GPO drive maps, but you'll still type it when the GPO fails. And **never run `diskpart clean` on the wrong disk number** — at home you lose your Steam library; at work you lose a production server and your job. The commands are identical; the blast radius is not.

## Helpdesk reality

- User says "the internet is down." Run `ipconfig` and `ping 8.8.8.8` before you believe them. Half the time the internet is fine and one app is broken.
- User says "I can't reach the share." `ping <servername>` first. If name fails but IP works, it's DNS — `ipconfig /flushdns` and check their DNS server in `ipconfig /all`.
- User says "my drive Z disappeared." `net use` to see what's mapped. Often the GPO that maps it didn't run because they're off-VPN. `gpupdate /force` after VPN connects.
- Never run `chkdsk /f` on the system drive without warning the user — it schedules for next reboot and they'll call you panicked when their PC restarts and sits at 23% for forty minutes.
- Never paste a user's `ipconfig /all` output into a public AI tool. Internal MAC addresses, DNS servers, and domain names are organizational data. Use a company-approved tool only.

## Related concepts

[[DNS and Name Resolution]] · [[DHCP and APIPA]] · [[TCP/IP Fundamentals]] · [[Group Policy]] · [[PowerShell Basics]] · [[Windows Troubleshooting Methodology]] · [[Network Troubleshooting]] · [[File and Folder Permissions]]

*Source: VIRGIL knowledge base — 2026-05-10*