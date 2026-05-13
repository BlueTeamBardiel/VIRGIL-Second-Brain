# Linux Commands Part 2

## What it is

Part 1 got you logged in and moving files. Part 2 is what makes you actually useful — package management, networking, system services, configuration files, the root account, and the handful of commands that turn a Linux box from "running" into "running the way you want it to."

This is the layer where Linux stops feeling like a different Windows and starts feeling like a tool. The kernel is the soul of the machine, systemd is the autonomic nervous system that keeps services breathing, and the package manager is how you graft new organs onto the body. Configuration files in `/etc` are the DNA — plain text, editable, version-controllable. That's the Linux deal: everything is a file, and you can read it.

The technical definition: Linux administration is a layered set of CLI tools and config files that manage processes (`ps`, `top`, `systemd`), packages (`apt`, `dnf`), networking (`ip`, `ping`, `dig`), filesystems (`mount`, `fsck`, `df`, `du`), and privilege (`su`, `sudo`, `chmod`, `chown`). The exam tests recognition: given a task, name the tool.

## Why it matters

CompTIA 220-1202 Objective 1.9 lists every command and config file in the bullets above by name. They will give you a scenario — "a user needs to install a package on Ubuntu" — and you pick `apt`. "A user needs to see which process is eating CPU" — you pick `top`. Memorize the verbs.

Career-wise: every cloud workload, every Docker container, every CI/CD runner, every web server, every router, every NAS — Linux. Windows admins who can't read a Linux config file get stuck at tier 2. The ones who can move to DevOps, security, and infrastructure. The CLI is the universal language.

## In your build, in the enterprise

**Beat 1 — The toolkit, by category.** Package managers split by distro family: `apt` (Debian, Ubuntu, Mint, Pop!_OS, Kali) and `dnf` (Fedora, RHEL, Rocky, AlmaLinux — `dnf` replaced `yum`). Networking diagnostics: `ip` replaced the deprecated `ifconfig` for interface info, `ping` for reachability (ICMP echo), `traceroute` for hop-by-hop path, `dig` for DNS queries, `curl` for HTTP/HTTPS requests. Process and system: `ps` for a snapshot of processes, `top` for live view, `systemd` (with `systemctl`) for service management — start, stop, enable on boot. Filesystem: `mount` to attach a filesystem, `fsck` to check and repair, `df` for free space per filesystem, `du` for disk usage per directory. Privilege: `su` to switch user (default: root), `sudo` to run one command as root. Text editing: `nano` for the friendly editor, `cat` to dump a file to stdout, `grep` to search inside files, `find` to search for files. Config files all live in `/etc`: `passwd` (user accounts), `shadow` (password hashes — root-only readable), `hosts` (static name-to-IP mappings), `resolv.conf` (DNS resolvers), `fstab` (filesystems to mount at boot). The bootloader (usually GRUB) loads the kernel; the kernel starts `systemd`; `systemd` brings up everything else.

**Beat 2 — Feynman: building an Ubuntu homelab box for Plex and Pi-hole.**

**Day one — install and update.** Fresh Ubuntu Server 24.04 install. First commands always: `sudo apt update` (refresh the package index), then `sudo apt upgrade` (install pending updates). `sudo` because package management writes to system directories — your user account can't. *Every Linux session for the rest of your life starts with `apt update` or `dnf update`. Muscle memory.*

**Installing Plex.** Plex isn't in the default repos, so you add their repo, then `sudo apt install plexmediaserver`. Service starts automatically because the package shipped a systemd unit. Verify: `systemctl status plexmediaserver`. Active (running). Good. *systemd is doing the work — you're just asking it questions.*

**Mounting the media drive.** External 8TB USB drive full of Linux ISOs. `lsblk` shows it as `/dev/sdb1`. `sudo mount /dev/sdb1 /mnt/media` works once. To make it survive a reboot, edit `/etc/fstab` with `sudo nano /etc/fstab` and add the UUID + mount point + filesystem type. *Forget the fstab entry, reboot, Plex shows an empty library at 11pm. Done that. Twice.*

**The 2am diagnostic.** Plex is unreachable from the living room TV. `ping plex.lab` — no response. `ip a` shows the server's IP is fine. `systemctl status plexmediaserver` — running. `ss -tlnp | grep 32400` — listening. Try `curl http://localhost:32400/web` from the server itself — works. So the box is fine, the network is broken. `ping 192.168.1.1` — gateway responds. The TV's Wi-Fi dropped. Reboot the TV. *Half of "Linux problems" are network problems. Check layer 1 before you touch the OS.*

**Beat 3 — From homelab to enterprise.** Your homelab uses `apt` against Ubuntu's public repos and a single root password you `sudo` with. In an enterprise environment, this changes:

- **Package management** is centralized through an internal mirror (Satellite for RHEL, Landscape for Ubuntu, or a Pulp/Artifactory repo). Servers don't reach the public internet — they pull vetted, version-pinned packages from a local repo so the security team controls what lands on production.
- **Configuration files** aren't hand-edited. Ansible, Puppet, Chef, or Salt pushes `/etc/hosts`, `/etc/resolv.conf`, and `/etc/fstab` from a git repo. You change the playbook, not the file. Auditable, repeatable, reversible.
- **The root account is disabled for direct login.** `/etc/shadow` shows `!` or `*` in the root password field. Admins log in as themselves and use `sudo`, which logs every command to the SIEM. You homelab — you `su -` to root and stay there. In production, that's a fireable offense at some shops.
- **systemd services** are deployed by configuration management, monitored by Prometheus/Grafana or Datadog, and alerts page someone at 3am when `systemctl status` returns anything but `active (running)`. Your homelab Plex dying is a Sunday inconvenience. A production database dying is a P1.

Same commands, same config files, same kernel. The discipline around them is what's different.

**Beat 4 — The point.** Linux administration is the same vocabulary at every scale. `apt install` on your laptop is the same `apt install` running inside a Docker container being deployed by Kubernetes on AWS. The exam tests the vocabulary. The job tests the discipline. Learn both together and you'll never be the helpdesk tech who has to escalate every Linux ticket.

## Key facts

### Package management

| Command | Distro family | What it does |
|---|---|---|
| `apt update` | Debian/Ubuntu | Refresh package index |
| `apt upgrade` | Debian/Ubuntu | Install pending updates |
| `apt install <pkg>` | Debian/Ubuntu | Install a package |
| `apt remove <pkg>` | Debian/Ubuntu | Uninstall a package |
| `dnf update` | RHEL/Fedora | Refresh + upgrade (combined) |
| `dnf install <pkg>` | RHEL/Fedora | Install a package |
| `dnf remove <pkg>` | RHEL/Fedora | Uninstall a package |

All require `sudo`. `dnf` replaced `yum` — exam may still show `yum`, treat them as synonyms.

### Networking commands

| Command | Purpose |
|---|---|
| `ip a` / `ip addr` | Show interfaces and IP addresses (replaces `ifconfig`) |
| `ip r` / `ip route` | Show routing table |
| `ping <host>` | ICMP reachability test |
| `traceroute <host>` | Show every hop between you and the destination |
| `dig <domain>` | Query DNS for a record (A, MX, TXT, etc.) |
| `curl <url>` | Fetch a URL — test web services, APIs, redirects |

### Critical configuration files (all in `/etc`)

| File | What lives inside |
|---|---|
| `/etc/passwd` | User accounts — username, UID, GID, home dir, shell. World-readable. |
| `/etc/shadow` | Password hashes. **Root-only readable** by design. |
| `/etc/hosts` | Static hostname-to-IP mappings. Checked before DNS. |
| `/etc/resolv.conf` | DNS resolver IPs (`nameserver 1.1.1.1`). |
| `/etc/fstab` | Filesystems to mount at boot. Bad entry = unbootable system. |

### Filesystem and storage

| Command | Purpose |
|---|---|
| `mount /dev/sdb1 /mnt/data` | Attach a filesystem to a mount point |
| `umount /mnt/data` | Detach |
| `fsck /dev/sdb1` | Check and repair a filesystem (unmount first) |
| `df -h` | Disk free, human-readable, per filesystem |
| `du -sh <dir>` | Disk usage of a directory, summarized |

### Processes and services

| Command | Purpose |
|---|---|
| `ps aux` | Snapshot of all running processes |
| `top` (or `htop`) | Live process view, CPU/RAM sorted |
| `systemctl status <svc>` | Is the service running? |
| `systemctl start/stop/restart <svc>` | Control a service now |
| `systemctl enable/disable <svc>` | Control whether it starts at boot |

### Privilege and permissions

| Command | Purpose |
|---|---|
| `sudo <cmd>` | Run one command as root (logged, auditable) |
| `su -` | Switch to root shell (requires root password) |
| `chmod 755 file` | Set permissions (owner rwx, group rx, other rx) |
| `chown user:group file` | Change ownership |

Permission digits: 4=read, 2=write, 1=execute. Add them: 7=rwx, 6=rw-, 5=r-x. Three digits = owner/group/other.

### OS components vocabulary

- **Bootloader (GRUB)** — first thing that runs after firmware hands off. Picks which kernel to load.
- **Kernel** — the soul. Manages hardware, memory, processes. `uname -r` shows the running version.
- **systemd** — PID 1. Brings up all services in dependency order. Manages logs (`journalctl`).

### Informational and search

| Command | Purpose |
|---|---|
| `man <cmd>` | Manual page — always the first stop when you don't know a flag |
| `cat <file>` | Dump file contents to terminal |
| `grep "pattern" file` | Search inside files |
| `find /path -name "*.log"` | Find files by name, type, size, modification time |

### CompTIA exam traps

> **Trap:** `apt` vs `dnf` — they test which distro uses which. Debian/Ubuntu = `apt`. RHEL/Fedora/Rocky = `dnf`. Mixing them up is the easiest wrong answer to eliminate.

> **Trap:** `/etc/passwd` does NOT contain passwords. It used to, decades ago. Hashes moved to `/etc/shadow` so non-root users can't read them. If a question asks where password hashes live — shadow, not passwd.

> **Trap:** `su` vs `sudo`. `su` switches user identity (default to root) and needs the target user's password. `sudo` runs one command as root and needs YOUR password (if you're in the sudoers file). Enterprise prefers `sudo` because it logs.

> **Trap:** `chmod` numbers. 755 is the most common — directories and executables. 644 is normal files. 777 is "anyone can do anything" and is almost always wrong.

> **Trap:** `ifconfig` is deprecated. The modern answer is `ip a`. Both may appear; `ip` is the right answer on newer exams.

## Helpdesk reality

- User says: "I can't install this program on my Linux machine." First question: which distro? Ubuntu → `apt`. Fedora → `dnf`. Don't guess.
- User says: "The website is down." `ping` the domain, `curl` the URL, `dig` the DNS. One of those three tells you whether it's their machine, DNS, or the actual site.
- User edits `/etc/fstab` wrong, reboots, system drops to emergency shell. Boot from live USB, mount the root partition, fix the fstab entry, reboot. *Always test fstab changes with `mount -a` BEFORE rebooting.*
- User runs `sudo rm -rf /` thinking it'll clean up. Modern distros have `--preserve-root` enabled by default, but only modern distros. Never promise recovery — go straight to backups.
- Never paste a user's `/etc/shadow` contents into an AI tool, a chat, or a ticket. Those are password hashes. Treat them like the credentials they are.

## Related concepts

[[Linux Commands Part 1]] · [[Linux File System Hierarchy]] · [[File Permissions and Ownership]] · [[Bash Scripting Basics]] · [[systemd and Service Management]] · [[Package Management Deep Dive]] · [[Linux Networking]] · [[SSH and Remote Administration]] · [[Backup Strategies]] · [[Common Linux Distributions]]

*Source: VIRGIL knowledge base — 2026-05-10*