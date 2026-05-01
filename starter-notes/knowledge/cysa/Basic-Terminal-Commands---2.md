---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# Basic Terminal Commands - 2
**Master the essential file manipulation and investigation tools that power forensic analysis and log hunting.**

---

## Overview

This section covers the intermediate-to-advanced terminal commands that security analysts use daily to inspect, manipulate, and search through files during incident response and threat hunting. A SOC analyst who can't efficiently navigate the command line is essentially working with one hand tied behind their back—these tools let you quickly pivot through logs, find malicious artifacts, and reconstruct attacker activity.

---

## Key Concepts

### File Movement & Duplication

**Analogy**: Think of `mv` like physically picking up a paper from one folder and placing it in another (or renaming the label on the folder). `cp` is like photocopying that same paper—the original stays, but now you have a duplicate.

**Definition**: [[mv]] relocates or renames files without creating copies; [[cp]] creates duplicates of files or entire directory trees using the `-r` (recursive) flag for folders.

| Command | Action | Use Case |
|---------|--------|----------|
| `mv oldname newname` | Rename file | Standardizing log filenames |
| `mv /source /dest/` | Move file | Organizing forensic artifacts |
| `cp file destination/` | Copy single file | Creating backups before analysis |
| `cp -r folder dest/` | Copy directory tree | Preserving full evidence chains |

### File Deletion

**Analogy**: `rm` is like shredding documents—once it's gone, it's gone. The `-r` flag is like telling the shredder "also shred everything inside this filing cabinet."

**Definition**: [[rm]] permanently deletes files; using `-r` deletes entire directories and their contents recursively, which is dangerous if mistyped.

---

### File Reading & Display

**Analogy**: `cat` is like unrolling an entire scroll of parchment on a table (shows everything at once), while `more` is like reading a book page by page so you don't get overwhelmed.

**Definition**: [[cat]] outputs entire file contents to screen instantly; [[more]] displays files in interactive, paginated sections you navigate with Enter/Space/q.

| Command | Output | When to Use |
|---------|--------|------------|
| `cat logfile` | Full file, all at once | Small files, quick inspection |
| `more logfile` | Paginated, interactive | Large files (doesn't freeze your terminal) |
| `head -n 10 file` | First 10 lines | Checking file structure quickly |
| `tail -n 20 file` | Last 20 lines | Finding recent events in logs |

### Text Output & File Creation

**Analogy**: `echo` is your megaphone—it broadcasts text. The `>` symbol is like pointing that megaphone at a file instead of the air (overwrites), while `>>` is like appending words to the end of an existing sentence.

**Definition**: [[echo]] prints text to the terminal or writes it to files; `>` overwrites files (destructive), `>>` appends without erasing previous content.

```bash
echo "Incident detected" > alert.txt      # Creates/overwrites
echo "New event" >> alert.txt             # Adds to existing
```

---

### Searching & Filtering

**Analogy**: [[grep]] is like using the Find function in your word processor—you tell it what phrase to hunt for, and it highlights every line containing that phrase. [[find]] is like a more powerful search tool that can filter by file type, size, or modification date.

**Definition**: [[grep]] searches within file contents for matching text patterns; [[find]] searches the filesystem for files/directories matching criteria like name or type.

```bash
grep "failed password" /var/log/auth.log    # Find login failures
find /home -type f -name "*.pdf"            # Locate all PDFs
find /tmp -type d -name "malware*"          # Find suspicious folders
```

---

### Text Counting & Analysis

**Analogy**: [[wc]] is like having a word processor's statistics panel—it counts lines, words, and characters. [[sort]] arranges items alphabetically; [[uniq]] removes duplicates from a sorted list (like removing duplicate entries from a phone list).

**Definition**: [[wc]] counts lines (`-l`), words (`-w`), or characters (`-m`) in files. [[sort]] orders content alphabetically. [[uniq]] eliminates consecutive duplicate lines (requires sorted input).

```bash
wc -l access.log                           # How many entries?
sort suspicious_ips.txt | uniq             # Unique IPs only
```

**Pipeline Magic**: The `|` (pipe) symbol chains commands—output from the left command becomes input for the right command.

---

### File Type Identification

**Analogy**: [[file]] is like a forensic examiner looking inside a box—it doesn't care what the box is labeled, it inspects the actual contents to determine what's really inside.

**Definition**: [[file]] identifies file types by reading the magic bytes (file header signature), ignoring the file extension entirely.

```bash
file mystery.exe        # Actually detects if it's truly executable
file image.jpg          # Confirms actual format despite extension
```

---

### System Information

**Analogy**: [[date]] is your clock; [[uptime]] tells you how long the power has been on and how hard the system is working. [[history]] is like reviewing your command audit trail.

**Definition**: [[date]] displays current system time; [[uptime]] shows system runtime and load averages; [[history]] displays previously executed commands from `~/.bash_history`.

---

## Analyst Relevance

You're investigating a potential data exfiltration. You've just captured logs from a compromised server:

1. **`tail -n 100 access.log`** → Quickly spot the most recent suspicious activity
2. **`grep "USERNAME" access.log`** → Find all actions by a specific user
3. **`grep "DELETE\|DROP" database.log | wc -l`** → Count how many database records were destroyed
4. **`sort suspicious_ips.txt | uniq`** → Identify unique C2 servers
5. **`find /var/www -type f -name "*.php" -mtime -1`** → Locate webshells modified in the last day
6. **`file downloaded_file`** → Confirm if a supposed image is actually malware
7. **`history | grep "rm -r"`** → Detect if the attacker tried to destroy evidence
8. **`cp -r /var/log /external_drive/evidence/`** → Preserve the entire log directory for forensic analysis

Without these tools, you're manually combing through gigabytes of data. With them, you're a threat-hunting machine.

---

## Exam Tips

### Question Type 1: Command Selection
- *"An analyst needs to view the last 50 lines of a system log to identify recent unauthorized access attempts. Which command is most appropriate?"* → `tail -n 50 /var/log/auth.log`
- **Trick**: Students confuse `head` (beginning) with `tail` (end). Remember: **tail** = **t**he **end**.

### Question Type 2: File Operations
- *"A forensic investigator must copy an entire directory tree of evidence while preserving the original. Which is correct?"* → `cp -r source_dir destination_dir`
- **Trick**: Without `-r`, copying directories will fail silently or error out. The flag is non-negotiable for directories.

### Question Type 3: Search & Filter
- *"Which command identifies all PDF files modified within the last 24 hours in /home directory?"* → `find /home -type f -name "*.pdf" -mtime -1`
- **Trick**: `-mtime -1` means "less than 1 day old"; `-mtime +1` means "older than 1 day". The sign matters.

### Question Type 4: Piping Logic
- *"To remove duplicate IPs from a suspicious IP list, what is the correct sequence?"* → `sort ips.txt | uniq`
- **Trick**: `uniq` only removes *consecutive* duplicates. You **must** `sort` first, or duplicates won't be detected.

### Question Type 5: File Type Verification
- *"A suspected malware sample is named 'document.pdf'. The analyst runs `file document.pdf` and it returns 'PE executable'. What does this indicate?"* → The file is actually malware masquerading as a PDF; filename extension cannot be trusted.
- **Trick**: Always use `file` before executing or opening suspicious files—the extension is the attacker's lie.

---

## Common Mistakes

### Mistake 1: Using `>` Instead of `>>`
**Wrong**: `echo "log entry" > important_log.txt` (overwrites entire log!)
**Right**: `echo "log entry" >> important_log.txt` (appends safely)
**Impact on Exam**: You'll see a scenario where data is accidentally destroyed. Knowing the difference between `>` (overwrite) and `>>` (append) is critical for evidence preservation.

---

### Mistake 2: Forgetting `-r` Flag on Directory Copy/Delete
**Wrong**: `cp malware_folder /evidence/` (fails with error)
**Right**: `cp -r malware_folder /evidence/` (copies entire tree)
**Impact on Exam**: Questions specifically test whether you understand that directories require the `-r` recursive flag.

---

### Mistake 3: Running `grep` Without Sorting Before `uniq`
**Wrong**: `grep "error" logfile | uniq` (misses non-consecutive duplicates)
**Right**: `grep "error" logfile | sort | uniq` (catches all duplicates)
**Impact on Exam**: You'll be asked to deduplicate a list. Not sorting first is a trap answer.

---

### Mistake 4: Confusing `head` and `tail`
**Wrong**: `head -n 50 access.log` when you need recent entries
**Right**: `tail -n 50 access.log` to see the most recent 50 lines
**Impact on Exam**: Scenario-based questions ask "show me recent suspicious activity"—only `tail` does this.

---

### Mistake 5: Trusting File Extensions
**Wrong**: Assuming `executable.exe` is definitely malware
**Right**: Running `file executable.exe` to verify the actual file type
**Impact on Exam**: Exam questions specifically test whether you know attackers rename files. `file` command with magic byte inspection is the correct approach.

---

### Mistake 6: Not Using `more` for Large Files
**Wrong**: `cat huge_log_file.txt` (terminal freezes/floods)
**Right**: `more huge_log_file.txt` (readable, paginated navigation)
**Impact on Exam**: Not a direct question, but a real-world analyst skill—knowing when to use `more` vs `cat` separates novices from professionals.

---

## Related Topics
- [[Regular Expressions & grep Advanced Patterns]]
- [[File Permissions & Ownership (chmod, chown)]]
- [[Log File Analysis & Forensics]]
- [[Piping & Command Chaining]]
- [[Linux File System Hierarchy]]
- [[Evidence Preservation & Chain of Custody]]
- [[SOC]]
- [[CySA+]]

---

*Source: CySA+ CS0-003 Study Notes | [[CySA+]] | [[VIRGIL Cybersecurity Study Companion]]*