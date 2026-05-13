# Linux Commands Part 1

## What it is

You sit down at a Linux box. There is no Start menu. There is no Settings app. There is a blinking cursor and a prompt that ends in `$`. Everything you want the machine to do — list files, install software, edit a config, check the network — you type. The shell is the mouth and ears of the OS; commands are the verbs.

Plain English: Linux exposes its guts through a text interface called the **shell** (usually `bash` or `zsh`). You speak to the kernel — the soul of the machine — through small, focused programs chained together. Each command does one thing. You combine them.

Technical: Linux commands are user-space binaries (most live in `/bin`, `/usr/bin`, `/sbin`) that the shell executes. They read input, manipulate the filesystem or kernel state through system calls, and write output. Mastering them means mastering the OS.

## Why it matters

Every Linux server, every container, every cloud VM, every Raspberry Pi, every Android phone runs on these commands. The Steam Deck runs Arch. Your company's web servers run Ubuntu or RHEL. The SIEM your future SOC team uses sits on Linux. CompTIA Objective 220-1202 1.9 tests whether you can sit at a Linux prompt without panicking.

The exam will give you a scenario — "a user can't reach a server, what command checks DNS resolution" — and expect you to pick `dig` from a list. Memorize the verbs. Know which directory each config file lives in. Know the difference between `su` and `sudo`. CompTIA loves these distinctions because the wrong choice in production fires people.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Linux commands split into rough families: **file management** (`ls`, `cp`, `mv`, `rm`, `pwd`, `find`, `cat`, `grep`), **filesystem/disk** (`mount`, `df`, `du`, `fsck`), **process and system info** (`ps`, `top`, `man`), **permissions** (`chmod`, `chown`), **network** (`ip`, `ping`, `curl`, `dig`, `traceroute`), **package management** (`apt` on Debian/Ubuntu, `dnf` on Fedora/RHEL), **privilege** (`su`, `sudo`), and **editors** (`nano` is the friendly one; `vi`/`vim` is the one that traps newbies who can't figure out how to quit — `:q!`, you're welcome). The configs they touch live in `/etc`: `/etc/passwd`, `/etc/shadow`, `/etc/hosts`, `/etc/fstab`, `/etc/resolv.conf`. The init system that ties it together on every modern distro is `systemd`, which loads after the **bootloader** (GRUB) hands off from UEFI to the **kernel**.

**Beat 2 — Feynman example via your homelab.** You stand up a Proxmox node on the old gaming rig. You SSH in. Now what?

**Where am I, what's here:** `pwd` tells you the working directory. `ls -lah` shows files with permissions, owners, sizes, hidden dotfiles. *These two are reflex — type them without thinking.*

**Moving stuff:** `cp source dest` copies. `mv source dest` renames or moves. `rm` deletes — and `rm -rf /` is the meme that ends careers. There is no recycle bin. *Linux assumes you meant it.*

**Finding stuff:** `find /etc -name "*.conf"` walks the tree. `grep "listen" /etc/nginx/nginx.conf` searches inside files. `cat /etc/hosts` dumps a file to the screen. Chain them: `cat /var/log/syslog | grep error`. *The pipe is the entire philosophy of Unix.*

**Checking the box:** `top` shows live processes and CPU/RAM load — your Task Manager. `ps aux` is the snapshot version. `df -h` shows disk space per mounted filesystem. `du -sh /var/log` shows how much one directory weighs. *When the disk fills at 2am, `df` tells you which volume, `du` tells you which folder.*

**Beat 3 — Bridge from homelab to enterprise.** Same commands, higher stakes. At home you `sudo apt update && sudo apt upgrade` whenever you remember. In the enterprise, that same command runs through a change ticket, in a maintenance window, on a patch-management system (Ansible, Satellite, Landscape) that hits 400 servers in a controlled wave. At home, `chmod 777` on a folder makes the permission error go away. In the enterprise, `chmod 777` on a production directory is a finding on the next audit and a phone call from the security team. At home, you edit `/etc/resolv.conf` with `nano` to point at 1.1.1.1. In the enterprise, that file is managed by `systemd-resolved` or by DHCP, and your manual edit gets overwritten on reboot — you change DNS in the right config layer, not the file CompTIA tells you to memorize.

**Beat 4 — The point.** Same verbs, different blast radius. Get the muscle memory at home where the only thing you can break is a VM you can rebuild in ten minutes. By the time you're typing `sudo` on a prod box, the commands should be automatic and the *thinking before pressing enter* should be the slow part.

## Key facts

### File management commands

| Command | What it does | Common flags |
|---|---|---|
| `pwd` | Print working directory | — |
| `ls` | List directory contents | `-l` long, `-a` all (hidden), `-h` human sizes |
| `cd` | Change directory | `cd ~` home, `cd -` previous |
| `cp` | Copy file or directory | `-r` recursive, `-p` preserve perms |
| `mv` | Move or rename | — (no `-r` needed) |
| `rm` | Delete file | `-r` recursive, `-f` force — **no undo** |
| `cat` | Concatenate / dump file | `cat file1 file2 > combined` |
| `find` | Walk filesystem by name/type/size | `find / -name "*.log" -size +100M` |
| `grep` | Search inside files | `-r` recursive, `-i` case-insensitive, `-v` invert |

### Permissions and ownership

`chmod` changes the permission mode. Three digits: owner, group, others. Each is read(4) + write(2) + execute(1).

- `chmod 644 file` → owner read/write, everyone else read
- `chmod 755 script.sh` → owner full, others read/execute (standard for executables)
- `chmod +x script.sh` → just add execute

`chown` changes ownership: `chown user:group file`. Use `-R` to recurse.

### Privilege: `su` vs `sudo`

> **CompTIA exam trap:** `su` vs `sudo` — `su` switches you *into* another user (usually root) and you stay there until you `exit`. You need that user's password. `sudo` runs *one command* as root, you stay yourself, and you use *your own* password (if you're in the sudoers file). Enterprise uses `sudo` so every privileged action is logged per-user. CompTIA tests this distinction every exam cycle.

### Package management

| Distro family | Tool | Install | Update index | Upgrade all |
|---|---|---|---|---|
| Debian / Ubuntu | `apt` | `sudo apt install pkg` | `sudo apt update` | `sudo apt upgrade` |
| Fedora / RHEL / Rocky | `dnf` | `sudo dnf install pkg` | (automatic) | `sudo dnf upgrade` |

`apt update` only refreshes the package list. `apt upgrade` actually installs new versions. Confusing both is the most common newbie mistake.

### Network commands

| Command | Purpose | Replaces |
|---|---|---|
| `ip addr` | Show interfaces and IPs | old `ifconfig` |
| `ip route` | Show routing table | old `route` |
| `ping host` | ICMP reachability test | — |
| `traceroute host` | Hop-by-hop path to destination | — |
| `dig domain` | DNS lookup, verbose | old `nslookup` |
| `curl url` | HTTP request, fetch content | — |

> **CompTIA exam trap:** `ip` replaced `ifconfig` years ago on every modern distro. CompTIA still lists both in older materials, but on the 1202 the answer is `ip`. Same with `dig` over `nslookup`.

### Critical configuration files

| File | What's in it |
|---|---|
| `/etc/passwd` | User accounts — username, UID, GID, home dir, shell. **World-readable**, no passwords here anymore |
| `/etc/shadow` | Hashed passwords, password aging. **Root-only readable** |
| `/etc/hosts` | Static hostname-to-IP mappings. Checked *before* DNS |
| `/etc/fstab` | Filesystems to mount at boot — device, mount point, type, options |
| `/etc/resolv.conf` | DNS servers the resolver uses |

> **CompTIA exam trap:** `/etc/passwd` does **not** contain passwords. It used to, decades ago. The hashes moved to `/etc/shadow` so they're not world-readable. CompTIA will offer "passwords are stored in /etc/passwd" as a tempting wrong answer.

### Filesystem and storage

- `mount /dev/sdb1 /mnt/data` — attach a filesystem to a directory
- `df -h` — disk free, per mounted filesystem, human-readable
- `du -sh /var` — disk usage of a directory, summarized
- `fsck /dev/sda1` — filesystem check and repair. **Unmount first** or run from a recovery environment

### OS components

- **Kernel** — the soul. Linus's code. Manages memory, CPU scheduling, device drivers, system calls.
- **Bootloader** — GRUB on most distros. Runs after UEFI, picks a kernel, hands off.
- **systemd** — the init system. PID 1. Starts services, manages units, handles logging via `journalctl`. Replaced the old SysV `init` on every mainstream distro.

### Informational commands

- `man command` — manual page. `man ls` shows every flag `ls` accepts. *When you don't know a flag, `man` first, Google second.*
- `top` — live process view, sorted by CPU. Press `q` to quit, `M` to sort by memory.
- `ps aux` — snapshot of all processes.

### Text editors

- `nano file` — friendly editor, commands shown at the bottom. `Ctrl+O` save, `Ctrl+X` exit. Use this until you choose to learn vim.
- `vi` / `vim` — modal editor, powerful, hostile to beginners. `i` to insert, `Esc` then `:wq` to save and quit, `:q!` to quit without saving.

## Helpdesk reality

- User says "I can't connect to the server." First three commands: `ping` (is it reachable?), `dig` (does DNS resolve?), `curl` (does the service respond?). In that order.
- User says "the disk is full." `df -h` first to confirm which mount. Then `du -sh /*` working down the tree to find the offender. Usually `/var/log` or someone's home directory full of `.iso` files.
- "Permission denied" is the most common Linux error and almost always means: wrong user, wrong `chmod`, or you forgot `sudo`. Check in that order.
- Never run `rm -rf` with a variable in the path unless you have personally verified the variable is set. The classic incident: `rm -rf $UNSET_VAR/something` becomes `rm -rf /something`.
- If a user pastes you a command from a random website that starts with `curl ... | sudo bash`, do not run it. That's downloading and executing a stranger's script as root. The enterprise answer is: pull the script first, read it, then decide.

## Related concepts

[[Windows Command Line]] · [[File Permissions and ACLs]] · [[Linux Filesystem Hierarchy]] · [[Package Management]] · [[Shell Scripting Basics]] · [[Network Troubleshooting Commands]] · [[systemd and Services]]

*Source: VIRGIL knowledge base — 2026-05-10*