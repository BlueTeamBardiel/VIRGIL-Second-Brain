---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# Linux File System Hierarchy
**Linux organizes everything—from programs to hardware—into a tree structure where every file has its place, and understanding that place is how you hunt for threats.**

---

## Overview

The [[Linux]] operating system treats everything as a file and arranges these files in a hierarchical directory tree with `/` (root) at the trunk. A security analyst must understand this hierarchy because attackers hide malware in predictable locations, logs reveal intrusions in specific directories, and misconfigurations expose sensitive data in the wrong places. Knowing the filesystem is like knowing the floor plan of a building you're defending—you can't spot intruders or find hidden contraband if you don't know where things belong.

---

## Key Concepts

### Root Directory (`/`)

**Analogy**: Think of `/` like the foundation and main entrance of a massive apartment building—everything else in the entire structure connects back to it, and there's only one root.

**Definition**: The top-level directory from which all other directories and files branch. Every absolute path on the system starts here. Access to `/` itself requires elevated privileges for modifications.

**Security Note**: [[Privilege escalation]] attacks often target processes running from or writing to root-level directories.

---

### `/bin` — Essential User Binaries

**Analogy**: Like the tool rack in a shared workshop—basic tools everyone needs are stored here so any user can grab them.

**Definition**: Contains critical executable programs needed for basic system operation and user commands (ls, cp, cat, etc.). These binaries are available to all users and are required to boot and operate the system.

**[[SOC]] Relevance**: Attackers sometimes replace legitimate binaries here with trojans. File integrity monitoring (FIM) watches this directory closely.

---

### `/boot` — Boot Loader and Kernel Files

**Analogy**: This is the instruction manual and starter kit your car needs to turn on before anything else happens.

**Definition**: Stores the kernel image, bootloader configuration, and initial RAM filesystem (initramfs) required to start the system. Without these files, the system cannot boot.

**Security Note**: Rootkits targeting the boot process hide here. [[UEFI]] and bootloader misconfigurations create persistence opportunities.

---

### `/dev` — Device Files

**Analogy**: Imagine a control panel where each switch represents a piece of hardware—flip the switch (read/write to the file), and something physical happens.

**Definition**: Contains special files representing hardware devices and pseudo-devices. For example, `/dev/sda1` represents a disk partition, `/dev/null` discards data, and `/dev/zero` provides null bytes. The [[kernel]] manages these files dynamically.

**[[SOC]] Relevance**: Attackers sometimes redirect output to `/dev/null` to hide evidence or write to `/dev/urandom` for data destruction.

---

### `/etc` — System Configuration Files

**Analogy**: Your house's instruction manual and settings—where the thermostat, alarm code, and guest list are documented.

**Definition**: Contains system-wide configuration files that control how services operate. Includes password hashes (in `/etc/shadow`), user accounts (in `/etc/passwd`), and configuration for nearly every installed service.

**Security Critical**: This is ground zero for privilege escalation and persistence. Misconfigurations here often create [[vulnerability|vulnerabilities]].

| File | Purpose | Security Impact |
|------|---------|-----------------|
| `/etc/passwd` | User account list | Publicly readable; contains usernames and UIDs |
| `/etc/shadow` | Password hashes | Root-readable only; contains actual authentication material |
| `/etc/sudoers` | Sudo privileges | Misconfiguration = privilege escalation |
| `/etc/ssh/sshd_config` | SSH settings | Weak configs allow remote access attacks |

---

### `/home` — User Home Directories

**Analogy**: Individual apartments where residents store personal belongings, photos, and private documents.

**Definition**: Contains user-specific home directories (`/home/alice`, `/home/bob`, etc.). Each user has read/write access to their own directory and stores documents, downloads, configuration files, and personal data here.

**[[SOC]] Relevance**: Attackers hide command history, stolen data, and malware staging directories in `/home`. Check for unusual files, hidden directories (`.`), and unexpected user accounts. Also note: users with UID 1000+ typically have legitimate home directories—random new users here = red flag.

---

### `/lib` and `/lib64` — Essential Shared Libraries

**Analogy**: Shared ingredient containers in a communal kitchen—programs grab what they need to function instead of duplicating ingredients.

**Definition**: Contains dynamically linked libraries (`.so` files) required by binaries in `/bin`, `/sbin`, and the kernel. These are essential for system boot and basic functionality.

**Forensic Note**: Compromised libraries allow [[LD_PRELOAD]] attacks and library injection techniques.

---

### `/media` — Removable Media Mount Points

**Analogy**: A parking garage where visitors temporarily park their vehicles—USB drives, external disks, and CD-ROMs get mounted here automatically.

**Definition**: Automatic mount point for removable media devices (USB sticks, external drives, optical media). The system typically mounts these automatically when inserted.

**Threat Vector**: USB-based malware, data exfiltration via external drives, and supply chain attacks enter through here.

---

### `/mnt` — Manual Mount Points

**Analogy**: A reserved space where the facility manager can temporarily connect equipment on-demand.

**Definition**: Directory used for manual temporary mounting of filesystems. Administrators explicitly mount network shares, additional disks, or remote filesystems here.

**[[SOC]] Relevance**: Check for suspicious mounts—especially NFS shares or SMB mounts from unfamiliar network locations. Indicates possible [[lateral movement]].

---

### `/opt` — Optional Third-Party Software

**Analogy**: Like a shopping mall's specialty stores—not part of the main building's essential infrastructure but added later.

**Definition**: Contains optional, add-on, or third-party application software that isn't managed by the system package manager. Commercial tools and vendor-supplied software often live here.

**Security Concern**: Third-party software frequently contains vulnerabilities. Monitor `/opt` for unauthorized installations and version mismatches.

---

### `/proc` — Process and Kernel Information (Virtual Filesystem)

**Analogy**: A live X-ray of the system showing every organ (process) currently functioning and its vital signs.

**Definition**: A virtual filesystem that doesn't actually exist on disk—the [[kernel]] creates it dynamically on boot. Contains directories for each running process (numbered by PID) and files exposing kernel parameters. Reading `/proc/[PID]/cmdline` shows what a process was launched with; `/proc/[PID]/maps` shows loaded libraries.

**Forensic Gold**: `/proc` reveals real-time system state. Analysts use it to understand active processes, network connections via `/proc/net/tcp`, and memory maps during live incident response.

---

### `/root` — Root User Home Directory

**Analogy**: The executive penthouse—separate from the apartment building, more restricted, and where the owner keeps sensitive business documents.

**Definition**: The home directory for the root (superuser/UID 0) account. NOT the same as `/`. Contains root's personal files, SSH keys, configuration, and history.

**Critical Security**: Root's home often contains authentication material and administrative credentials. Unauthorized access here = system compromise.

---

### `/run` — Runtime State and Boot-Time Data

**Analogy**: A whiteboard listing current tasks and temporary statuses that gets erased on restart.

**Definition**: Contains volatile runtime information since the last boot: PID files for running services, Unix sockets, and boot-time state. Cleared on reboot.

**[[SOC]] Use**: Check `/run/systemd/journal/` for recent service status changes and `/run/lock/` for service locks that may indicate suspicious process activity.

---

### `/sbin` — System Administration Binaries

**Analogy**: The toolkit locked in the janitor's closet—only authorized administrators should be using these.

**Definition**: Contains system-level executable binaries typically run only by root during system administration and boot: `ifconfig`, `iptables`, `fsck`, `mount`, etc. More restricted than `/bin`.

**Privilege Escalation Risk**: Misconfigured [[SUID]] bit on `/sbin` binaries creates exploitable elevation paths.

---

### `/srv` — Service Data Directory

**Analogy**: The storage room for a restaurant's food and supplies—data actively being served to customers.

**Definition**: Holds data served by network services like FTP, web servers, TFTP, or custom application services. Service-specific subdirectories live here.

**Integrity Risk**: Attackers modifying web content in `/srv/www/` or FTP data in `/srv/ftp/` creates website defacement or data manipulation.

---

### `/tmp` — Temporary Files

**Analogy**: A public trash bin where anyone can toss stuff—cleaned out regularly but contains whatever people threw away recently.

**Definition**: World-writable directory for temporary files. Typically cleared on reboot (though this varies by distribution). Any process can create files here.

**Incident Response Goldmine**: Attackers stage malware, scripts, and stolen data in `/tmp` because they assume cleanup is automatic. Always preserve `/tmp` during forensic collection. Check for:
- Compiled binaries (why would a temp file be executable?)
- Hidden directories (`.hidden_stuff/`)
- Recently modified files during incident timeline

---

### `/usr` — User System Resources and Applications

**Analogy**: A library system with thousands of books, manuals, and reference materials organized by subject.

**Definition**: Contains user-accessible programs, libraries, documentation, and system resources installed via package managers. Includes `/usr/bin` (application binaries), `/usr/lib` (application libraries), `/usr/share` (documentation and data). Generally read-only for unprivileged users.

**Not user home directories** — this is a common confusion with `/home`.

| Subdirectory | Contents |
|---|---|
| `/usr/bin` | User application binaries (gcc, python, curl, etc.) |
| `/usr/sbin` | User-level system administration tools |
| `/usr/lib` | Application libraries and shared objects |
| `/usr/share` | Architecture-independent files: icons, docs, fonts |
| `/usr/local` | Locally compiled/installed software (survives package updates) |

---

### `/var` — Variable Data, Logs, and Caches

**Analogy**: A newspaper office's archive—every day new editions are filed away, and you can read what happened by checking back issues.

**Definition**: Contains files that change frequently during operation: system logs, application caches, mail spools, temporary database files, and activity tracking. Critical for forensics and incident response.

**Subdirectories of Forensic Interest**:

| Path | Contents | Why It Matters |
|------|----------|---|
| `/var/log/` | System and application logs | Primary evidence for timeline, intrusions, errors |
| `/var/log/auth.log` | Authentication attempts | Login attacks, privilege escalation evidence |
| `/var/log/syslog` | General system messages | Boot events, service crashes, kernel warnings |
| `/var/log/apache2/` or `/var/log/nginx/` | Web server logs | HTTP request logs, web application attacks |
| `/var/cache/` | Cached data | DNS caches, package caches, temporary app data |
| `/var/spool/` | Queued jobs and mail | Scheduled tasks, email evidence |
| `/var/tmp/` | Temporary files (NOT cleared on reboot) | More persistent than `/tmp` |

**[[SOC]] Critical**: Log analysis happens here. Attackers delete or rotate logs in `/var/log/` to hide tracks. Enable centralized log aggregation to prevent on-box deletion.

---

## Analyst Relevance

**Real SOC Scenario**: 3:47 AM, you're investigating a suspected lateral movement incident. A web server was compromised and the attacker deployed a webshell. Here's what you actually do:

1. **Check `/tmp` and `/var/tmp`** → Find the compiled C2 malware the attacker staged before execution
2. **Check `/home/www-data/`** → Discover the attacker's SSH keys and scripts
3. **Check `/var/log/apache2/access.log`** → Timeline shows the exact HTTP request that uploaded the webshell
4. **Check `/var/log/auth.log`** → See failed privilege escalation attempts and successful sudo commands
5.