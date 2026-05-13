# Linux

## What it is

You've used Linux today. Your router runs it. Your Android phone runs it. The Steam Deck runs it (Arch, specifically). Every Netflix stream you've watched hit a Linux server on the way to your screen. The kernel Linus Torvalds posted to a Usenet group in 1991 now runs more of the internet than every other OS combined.

Plain English: Linux is a free, open-source operating system. The kernel — the soul of the machine — is Linux. Everything else (the shell you type into, the desktop environment, the package manager, the utilities) is bolted on top. Different combinations of "kernel + utilities + package manager + defaults" make a **distribution** (distro). Ubuntu, Fedora, Debian, Red Hat Enterprise Linux (RHEL), Arch, Mint — same kernel, different personalities.

Technical: A Unix-like, POSIX-compliant operating system built around the monolithic Linux kernel. Open source under GPLv2. Multi-user, multi-tasking, with a permission model rooted in users, groups, and the all-powerful **root** account. The shell (usually `bash` or `zsh`) is where the real work happens — GUI is optional.

## Why it matters

Two reasons. First, the **career reason**: every cybersecurity job, every cloud job, every DevOps job, every sysadmin job above tier-1 helpdesk expects Linux fluency. AWS, Azure, GCP — the VMs spinning up under the hood are overwhelmingly Linux. You will not progress past helpdesk without it.

Second, the **exam reason**: Objective 220-1202 1.9 is a command-recognition objective. CompTIA wants you to look at `chmod`, `chown`, `apt`, `dnf`, `grep`, `ps`, `top`, `df`, `du`, and know what each does without hesitation. They love putting four commands in a multiple-choice question where three are real and one is a distractor, or asking which command does a specific task. Memorization-heavy. Earn the points.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Linux is a family, not a product. Two major package-management families dominate what CompTIA tests:

- **Debian family** (Debian, Ubuntu, Mint, Pop!_OS, Raspberry Pi OS) — uses `apt` (or older `apt-get`) and `.deb` packages
- **Red Hat family** (RHEL, Fedora, CentOS Stream, Rocky, AlmaLinux) — uses `dnf` (older: `yum`) and `.rpm` packages

The kernel boots via a **bootloader** — almost always GRUB2 on modern systems. GRUB hands control to the kernel, which initializes hardware, mounts the root filesystem, and starts **systemd** (PID 1) — the init system that brings up every other service. `systemctl status sshd` asks systemd how the SSH daemon is doing. systemd replaced the old SysVinit scripts on basically every mainstream distro by 2017. Old guides still reference `service` and `/etc/init.d` — those commands often still work as compatibility shims, but `systemctl` is the real interface.

The **filesystem** is a single tree rooted at `/`. There are no drive letters. `/home` is user data, `/etc` is system configuration (text files, always), `/var` is variable data (logs, mail, databases), `/usr` is installed programs, `/boot` is the kernel and bootloader, `/proc` and `/sys` are virtual filesystems exposing kernel state. Storage devices get **mounted** into that tree — your second NVMe might mount at `/mnt/games` or `/data`. `/etc/fstab` tells the system what to mount at boot.

**Beat 2 — Feynman example via gaming/personal build.** You build a gaming PC. Windows 11 on the NVMe, runs fine. But you keep hearing about Bazzite and CachyOS — gaming-tuned Linux distros — and your buddy with the Steam Deck won't shut up about Proton. So you partition the second SSD, install Bazzite, and reboot.

**The first 20 minutes:** Terminal opens. `ls` lists files. `pwd` tells you where you are. `cd Downloads`, `ls` again — there's the Discord `.rpm` you downloaded. *Navigation is three commands. You already know them now.*

**Installing something:** `sudo dnf install discord` — Bazzite is Fedora-based, so `dnf` is the package manager. It downloads from the repo, resolves dependencies, installs. No "next next next" wizard. No bundled toolbars. *Package managers are the App Store, except they actually work and they're free.*

**Permissions bite you:** You copy a save file from a USB drive and the game can't read it. `ls -l` shows the file is owned by `root` because the USB mount did that. `sudo chown $USER:$USER savefile.sav` fixes ownership. `chmod 644 savefile.sav` fixes read permissions. *Every Linux problem eventually comes back to "who owns this and who can read it."*

**Something's running hot:** Fans spinning. `top` shows a runaway process eating 400% CPU. You note the PID, `kill 4471`, done. On Windows you'd open Task Manager and click "End task." Same idea, faster path. *The terminal isn't slower than the GUI. Once you can type, it's faster.*

**Beat 3 — Bridge from gaming to enterprise.** Same five skills, scaled up. At home you `sudo dnf install discord` on one machine. In the enterprise, you SSH into a fleet of 200 web servers and run the same kind of command via Ansible — `apt install nginx` rolled out to every box, configured identically, logged centrally. The skill is the same. The blast radius is larger.

At home, `top` shows your runaway game. At work, `top` (or its modern cousin `htop`) shows the Java process eating a production server's RAM at 2 AM, and the on-call rotation expects you to know what to do with it. `ps aux | grep java` to find it, `kill -9 <pid>` if it won't die clean, `systemctl restart tomcat` to bring it back.

At home, you edit `/etc/fstab` to auto-mount your games SSD. At work, you edit `/etc/fstab` on a database server to mount the NFS share where backups land. *Same file. Same syntax. One typo and the server won't boot — at home you reboot from a USB and fix it, at work you file an outage report.*

**Beat 4 — The point.** Linux at home and Linux at work are the same Linux. The commands don't change. What changes is the blast radius, the documentation requirements, and the fact that "I'll just try it and see" is a fireable offense in production. *Learn it on your gaming rig where mistakes cost a reinstall. By the time you're touching production, the muscle memory is built.*

## Key facts

### File management

| Command | What it does |
|---|---|
| `ls` | List directory contents. `ls -l` for details, `ls -la` to include hidden files (start with `.`) |
| `pwd` | Print working directory — where am I right now? |
| `cd` | Change directory |
| `cp` | Copy files. `cp -r` for directories recursively |
| `mv` | Move or rename a file |
| `rm` | Delete a file. `rm -rf` deletes a directory and everything in it. **No undo. No recycle bin.** |
| `find` | Search the filesystem. `find /var/log -name "*.gz"` |
| `grep` | Search inside files for text. `grep "error" /var/log/syslog` |
| `cat` | Print a file's contents to the terminal |
| `du` | Disk usage of files/folders. `du -sh /home/*` shows size per user folder |
| `df` | Disk free — how full are my mounted filesystems? `df -h` for human-readable |

### Package management

| Family | Install | Update repo | Upgrade | Remove |
|---|---|---|---|---|
| Debian/Ubuntu | `apt install <pkg>` | `apt update` | `apt upgrade` | `apt remove <pkg>` |
| Red Hat/Fedora | `dnf install <pkg>` | (automatic) | `dnf upgrade` | `dnf remove <pkg>` |

`apt update` refreshes the list of available packages. `apt upgrade` actually installs newer versions. Confusing the two is a classic A+ exam trap.

### Text editors

- **`nano`** — beginner-friendly, command hints shown at the bottom (`^X` to exit means Ctrl+X). The one CompTIA expects you to know.
- **`vi` / `vim`** — modal editor. Press `i` to insert text, `Esc` to leave insert mode, `:wq` to save and quit, `:q!` to quit without saving. Hated by beginners, loved by sysadmins.

### Common configuration files

| File | What it holds |
|---|---|
| `/etc/passwd` | User accounts (username, UID, home directory, shell). **No passwords here despite the name** — those moved to shadow decades ago |
| `/etc/shadow` | Hashed passwords. Root-readable only |
| `/etc/hosts` | Static hostname-to-IP mappings. Checked before DNS |
| `/etc/resolv.conf` | DNS server addresses |
| `/etc/fstab` | Filesystem mount table — what gets mounted where at boot |

### Network commands

| Command | What it does |
|---|---|
| `ip` | Modern replacement for `ifconfig`. `ip addr` shows interfaces and IPs, `ip route` shows the routing table |
| `ping` | Test reachability via ICMP |
| `traceroute` | Show the hop-by-hop path to a destination |
| `dig` | DNS lookup. `dig google.com` shows what the resolver returns |
| `curl` | Make HTTP requests. `curl -O <url>` downloads a file |

### Informational and administrative

| Command | What it does |
|---|---|
| `man` | The manual. `man chmod` shows every flag chmod accepts. **First stop when you don't know a command.** |
| `top` | Live process viewer — CPU, memory, PID. Press `q` to quit |
| `ps` | Process snapshot. `ps aux` shows everything running |
| `mount` | Show or attach filesystems |
| `fsck` | Filesystem check and repair. Run on **unmounted** filesystems only |

### Root account, permissions, ownership

- **`su`** — switch user. `su -` becomes root if you know root's password.
- **`sudo`** — run a single command as root using *your* password (if you're in the sudoers file). Modern best practice. The root account is often disabled for direct login on Ubuntu.
- **`chmod`** — change file permissions. `chmod 755 script.sh` = owner can read/write/execute, group and others can read/execute. Octal: read=4, write=2, execute=1.
- **`chown`** — change ownership. `chown alice:devs file.txt` sets owner to alice and group to devs.

### CompTIA exam traps

> **CompTIA exam trap:** `apt` vs `dnf` — if the question mentions Ubuntu, Debian, or Mint, it's `apt`. If it mentions Fedora, RHEL, CentOS, or Rocky, it's `dnf`. They will give you a distro name and expect you to pick the right package manager.

> **CompTIA exam trap:** `/etc/passwd` does **not** contain passwords. Hashed passwords live in `/etc/shadow`. The name is historical baggage from the 1970s.

> **CompTIA exam trap:** `rm -rf` has no undo. There is no recycle bin in the terminal. A favorite scenario question: "A technician ran `rm -rf` on the wrong directory. What's the recovery path?" Answer: restore from backup. That's it.

> **CompTIA exam trap:** `chmod 777` means everyone can do everything. It's almost always the wrong answer in a security context. If a question shows `chmod 777` as the "fix," the right answer is usually `chmod 755` or `chmod 644` with proper ownership.

## Helpdesk reality

- **"I can't install this software, it says permission denied."** They forgot `sudo`. Teach them once; they'll remember.
- **"The disk is full but I deleted everything."** `du -sh /*` to find what's actually eating space. Usually `/var/log` or a runaway Docker install.
- **"I changed `/etc/fstab` and now the server won't boot."** Boot from a live USB, mount the root partition, fix the typo, reboot. Tell them to never edit fstab without a backup copy and a test mount (`mount -a`) first.
- **"My script worked yesterday, today it says command not found."** Check `$PATH`. Check if the script is executable (`chmod +x`). Check if they're in the right shell.
- **Never promise** that a `rm -rf` is recoverable. It isn't. The fix is the backup you took before.

## Related concepts

[[Windows]] · [[macOS]] · [[Command-Line Tools]] · [[File Permissions]] · [[Shell Scripting]] · [[systemd and Services]] · [[Package Management]] · [[Filesystem Hierarchy]] · [[SSH and Remote Access]] · [[Virtualization]]

*Source: VIRGIL knowledge base — 2026-05-10*