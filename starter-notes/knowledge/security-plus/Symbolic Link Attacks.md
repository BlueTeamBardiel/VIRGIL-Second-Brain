---
domain: "offensive-security"
tags: [symlink, privilege-escalation, filesystem, local-exploitation, linux-security, windows-security]
---
# Symbolic Link Attacks

A **symbolic link attack** (also called a **symlink attack**) is a class of local privilege escalation and [[File System Vulnerabilities|file system exploitation]] technique in which an attacker manipulates a [[Symbolic Link]] — a special file that acts as a pointer to another file or directory — to redirect a privileged process into reading, writing, or executing an unintended target. These attacks exploit the inherent trust that system processes and administrators place in file paths, and they are closely related to [[Race Condition Attacks|TOCTOU (Time-of-Check to Time-of-Use)]] vulnerabilities. Symlink attacks have been responsible for some of the most impactful [[Privilege Escalation]] vulnerabilities in Linux, macOS, and Windows environments.

---

## Overview

Symbolic links are a fundamental feature of modern operating systems. In Unix-like systems, `ln -s target linkname` creates a soft link — a filesystem object that transparently redirects any access to its target. In Windows, `mklink` provides equivalent functionality. These links are essential for software compatibility, package management, and directory organization. However, when a privileged process (such as one running as root or SYSTEM) follows a symlink without validating that the link points to the expected file, an attacker can substitute a malicious link in place of a legitimate file and redirect the privileged operation to a sensitive target.

The attack surface is enormous. Any privileged process that operates on files in world-writable directories (such as `/tmp`, `/var/tmp`, or `C:\Windows\Temp`) is potentially vulnerable. Common scenarios include installers, log rotation daemons, backup utilities, system update scripts, and cron jobs. If such a process writes to a predictable filename in a shared directory, an attacker can pre-create (or race to create) a symlink at that path pointing to `/etc/shadow`, `/etc/passwd`, a root-owned authorized_keys file, or any other privileged resource.

The TOCTOU aspect is critical to understanding symlink attacks. A privileged process typically checks a file's properties (existence, ownership, permissions) at one point in time, then performs an operation on it later. Between the check and the use, an attacker can swap the legitimate file for a symlink. This race window may be only milliseconds wide, but automated tools can reliably win the race on modern systems. The kernel's handling of symlinks in sticky directories (like `/tmp` with the sticky bit set) was specifically hardened in Linux kernel 3.6 via Yama LSM `fs.protected_symlinks`, but many systems remain misconfigured or run on older kernels.

Symlink attacks are not purely a Unix phenomenon. Windows has suffered from numerous symlink-class vulnerabilities affecting the NTFS junction points, object directory symlinks, and the Windows Object Manager. Tools like `CreateSymbolicLink()` and the `NtCreateFile` object manager path redirection have been used in SYSTEM-level privilege escalation exploits targeting Windows Installer (MSI) packages, Windows Update, and various antivirus products. The Stuxnet worm famously leveraged LNK file parsing vulnerabilities that share conceptual roots with symlink attacks.

Historically, symlink attacks have been exploited against sudo, popular package managers (apt, yum), logrotate, and numerous third-party applications. CVEs attributed to symlink attacks number in the hundreds, spanning decades of software development. They persist because developers often fail to use safe file-creation APIs (like `O_NOFOLLOW`) and because the interaction between privileged processes and shared, world-writable directories is so common.

---

## How It Works

### Conceptual Mechanism

At its core, a symlink attack follows this pattern:

1. A privileged process is expected to perform a file operation (read, write, chown, chmod) on a predictable path.
2. The attacker creates a symbolic link at that path pointing to a sensitive target.
3. The privileged process follows the symlink and operates on the attacker-controlled target.
4. The attacker gains unauthorized access, modified file content, or escalated privileges.

### Classic `/tmp` Race Attack (Linux)

Consider a vulnerable backup script running as root that creates a log file:

```bash
# Vulnerable root-owned script /usr/local/sbin/backup.sh
LOGFILE="/tmp/backup_$(date +%Y%m%d).log"
echo "Backup started" > $LOGFILE
# ... perform backup ...
chmod 644 $LOGFILE
```

An attacker who knows the filename (predictable date-based name) can exploit this:

```bash
# Attacker pre-creates the symlink before the script runs
ln -s /etc/passwd /tmp/backup_$(date +%Y%m%d).log
```

When the root script executes `echo "Backup started" > $LOGFILE`, it follows the symlink and overwrites `/etc/passwd`, corrupting the system or allowing the attacker to inject a root-level account.

### TOCTOU Race Condition Variant

For cases where the filename is not fully predictable, a race condition tool can be used:

```bash
# Terminal 1 - Attacker racing the creation
while true; do
    rm -f /tmp/vulnfile 2>/dev/null
    ln -s /etc/shadow /tmp/vulnfile 2>/dev/null
done &

# Terminal 2 - Trigger the vulnerable privileged operation repeatedly
while true; do
    /usr/bin/vulnerable_suid_binary
done
```

Tools like **`symlink-follow`**, **`inotifywait`**, and **`race-the-link`** automate this process with high reliability.

### inotify-Based Precision Attack

```bash
# Wait for the file to be created, then atomically replace it
inotifywait -m /tmp -e create 2>/dev/null | while read dir event file; do
    if [[ "$file" == "target_*" ]]; then
        rm -f "/tmp/$file"
        ln -s /root/.ssh/authorized_keys "/tmp/$file"
    fi
done
```

### Windows Object Manager Symlink Attack

On Windows, the Object Manager namespace allows symlink creation in the global namespace:

```powershell
# Using James Forshaw's NtApiDotNet or CreateSymbolicLink
# Create a directory junction pointing to a privileged path
cmd /c mklink /J C:\Temp\TargetDir C:\Windows\System32\config

# Or using the NtObjectManager PowerShell module
New-NtSymbolicLink \RPC Control\TargetPipe \Device\NamedPipe\PrivilegedPipe
```

The **James Forshaw** technique exploits Windows Installer or service MSI repair operations that create files under attacker-influenced paths, then uses a combination of directory junctions and NTFS symlinks to redirect the write to `C:\Windows\System32\` or the Windows registry hive files.

### logrotate Privilege Escalation (Real-World Pattern)

```bash
# Vulnerable logrotate configuration (running as root via cron)
# /etc/logrotate.d/app
/var/log/app/*.log {
    daily
    create 0644 www-data www-data
    postrotate
        /bin/kill -HUP $(cat /run/app.pid)
    endscript
}

# If www-data can write to /var/log/app/, they can create a symlink:
# As www-data:
ln -s /etc/cron.d/backdoor /var/log/app/app.log
# logrotate (as root) will create /etc/cron.d/backdoor with attacker-controlled content
```

### Checking for `fs.protected_symlinks`

```bash
# Check if symlink protection is enabled
sysctl fs.protected_symlinks
# Output: fs.protected_symlinks = 1 (protected)
# Output: fs.protected_symlinks = 0 (VULNERABLE)

# Also check hardlink protection
sysctl fs.protected_hardlinks
```

### Safe File Opening with O_NOFOLLOW

```c
// Vulnerable code
int fd = open(path, O_WRONLY | O_CREAT, 0644); // follows symlinks

// Safe code - O_NOFOLLOW causes open() to fail if path is a symlink
int fd = open(path, O_WRONLY | O_CREAT | O_NOFOLLOW, 0644);
// Returns ELOOP error if path is a symbolic link
```

---

## Key Concepts

- **Symbolic Link (Symlink)**: A special filesystem object that acts as a pointer or alias to another file or directory path. Unlike a hard link, a symlink can span filesystems and can point to non-existent targets (a "dangling" symlink). The OS transparently redirects any file operation through the symlink to the target.

- **TOCTOU (Time-of-Check to Time-of-Use)**: A class of [[Race Condition Attacks|race condition]] vulnerability where the security-relevant state of a resource changes between when it is checked (e.g., `access()` or `stat()`) and when it is actually used (e.g., `open()`). Symlink attacks frequently exploit this window — a process checks that a path is safe, and the attacker replaces it with a symlink before the process accesses it.

- **Sticky Bit and `fs.protected_symlinks`**: The sticky bit on a directory (e.g., `/tmp`) prevents users from deleting each other's files. Linux kernel 3.6+ added `fs.protected_symlinks`, which refuses to follow a symlink in a sticky world-writable directory if the symlink's owner differs from the follower's UID or the directory's owner — a direct mitigation for most `/tmp`-based symlink attacks.

- **Directory Junction / NTFS Symlink**: Windows-specific filesystem constructs. Directory junctions (`mklink /J`) are reparse points that redirect directory access. NTFS symbolic links (`mklink /D`) require `SeCreateSymbolicLinkPrivilege`. Windows Object Manager symlinks operate at the kernel object namespace level and are a separate, often more powerful attack vector used in SYSTEM-level escalation exploits.

- **Privilege Escalation via Arbitrary Write**: The ultimate goal of most symlink attacks is to turn a privileged process's file write operation into an **arbitrary write primitive** — the ability to write attacker-controlled content to any file on the system. This is often chained with writing to `/etc/passwd` (add root user), `/etc/sudoers`, cron directories, SSH authorized_keys, or LD_PRELOAD paths to achieve root code execution.

- **Predictable Temporary File Names**: Vulnerable programs create temporary files with predictable names (e.g., `/tmp/programname.pid`, `/tmp/backup_YYYYMMDD.log`). An attacker who can predict the name can pre-create the symlink before the privileged process runs, eliminating the need for any race condition and making the attack 100% reliable.

- **`O_NOFOLLOW` and `openat()` Mitigations**: `O_NOFOLLOW` is an `open()` flag that causes the call to fail with `ELOOP` if the final component of the path is a symbolic link. `openat()` with a directory file descriptor allows atomic, race-free file operations relative to a specific directory, preventing path-substitution attacks during traversal.

---

## Exam Relevance

**Security+ SY0-701** tests symlink attacks primarily under the domains of **Application Attacks** and **Privilege Escalation**. Key exam patterns:

- **Symlink attacks are classified as a type of privilege escalation** when they allow a lower-privileged user to manipulate files accessible only to a higher-privileged process. Know this categorization.

- **TOCTOU is the underlying vulnerability class** — if a question describes a race condition involving file access, think TOCTOU and symlink attacks. The exam may present a scenario without using the word "symlink" explicitly.

- **Common question format**: "A local attacker creates a file in /tmp that points to /etc/shadow. When the backup process runs as root, it writes to /tmp/backup.log. What type of attack is this?" → **Symbolic Link Attack / Privilege Escalation**.

- **Gotcha**: Do not confuse symlink attacks with [[Hard Link Attacks]] — hard links require the attacker to already have read permission on the target file. Symlinks can point to files the attacker cannot read, and the privileged process's permissions are what matter when following the link.

- **Mitigation association**: The exam may ask about mitigations. Know that **principle of least privilege**, **avoiding world-writable directories for privileged operations**, and **using atomic file creation flags** are the correct answers. `fs.protected_symlinks` is a Linux-specific kernel control, potentially too low-level for SY0-701 but worth knowing for context.

- **Windows context**: Windows symlink privilege escalations (e.g., involving Windows Installer, services, or AV software) may appear under questions about **local privilege escalation** or **insecure permissions**. The concept of a service writing to a user-controlled path is the abstracted exam concept.

---

## Security Implications

### Vulnerable Components and CVEs

**CVE-2017-1000117 (Git)** — Git's `ssh://` URL handling followed symlinks in a way that allowed command injection. While primarily a different class, symlink following contributed to the attack surface.

**CVE-2021-3156 (Sudo "Baron Samedit")** — While primarily a heap overflow, the discovery process involved analysis of sudo's file handling, and sudo has historically had symlink-class bugs in its log file handling.

**CVE-2019-14287 (Sudo)** — Sudo privilege bypass; symlink attacks against sudoers log files have appeared in multiple sudo CVEs over the years.

**CVE-2016-1247 (nginx)** — The nginx log rotation script (running as root) followed a symlink in `/var/log/nginx/`, allowing the `www-data` user to escalate privileges to root by replacing the error log with a symlink to `/etc/shadow` and using logrotate's `create` directive.

**CVE-2015-1322 (Ubuntu unzip)** — The `unzip` package's post-installation script used predictable temp file names in `/tmp`, allowing a local attacker to escalate privileges via symlink substitution.

**Windows MSI Repair Attacks** — Numerous Windows privilege escalations (documented by James Forshaw of Google Project Zero) exploit the Windows Installer's repair function, which runs as SYSTEM and creates files based on MSI package specifications. By manipulating directory junctions and NTFS symlinks, attackers redirect SYSTEM-level file writes to arbitrary locations.

**Antivirus Privilege Escalations** — Many AV products (Trend Micro, Symantec, McAfee) have had symlink vulnerabilities where their privileged scanning or quarantine processes followed symlinks, allowing local attackers to read or overwrite root-owned files. These have become a recurring pattern in AV security research.

### Detection Methods

- **Audit symlink creation in sensitive directories**: Use `auditd` with rules watching `/tmp`, `/var/tmp`, and application-specific temp directories.
- **Monitor for symlinks pointing to sensitive files**: Scripts or EDR tools can enumerate symlinks in world-writable directories and alert on those pointing to `/etc/`, `/root/`, or key system files.
- **Behavioral analysis**: Privileged processes accessing files in `/tmp` immediately after symlink creation is highly suspicious.
- **Inotify-based monitoring**: Tools like `inotifywait` can be used defensively to watch for suspicious symlink creation patterns.

```bash
# auditd rule to watch for symlink creation in /tmp
-a always,exit -F arch=b64 -S symlink -S symlinkat -F dir=/tmp -k symlink_attack
```

---

## Defensive Measures

### Linux / Unix Hardening

**Enable kernel symlink protections** — These should be enabled and persisted in `/etc/sysctl.d/`:

```bash
# Enable symlink and hardlink protection
echo "fs.protected_symlinks = 1" >> /etc/sysctl.d/99-security.conf
echo "fs.protected_hardlinks = 1" >> /etc/sysctl.d/99-security.conf
sysctl --system

# Verify
sysctl fs.protected_symlinks fs.protected_hardlinks
```

**Avoid predictable temp file names** — Use `mktemp` for temporary file creation in scripts:

```bash
# WRONG - predictable
TMPFILE="/tmp/myscript.$$