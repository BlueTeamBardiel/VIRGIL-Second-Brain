---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# Basic Terminal Commands - 1
**Master the shell interface and navigation—your gateway to system investigation and forensic analysis.**

---

## Overview

The [[terminal]] is where security analysts live. It's a text-based conversation between you and the operating system—you type commands, the system executes them. Security professionals need terminal fluency because GUI tools hide the details; the command line reveals everything. Whether you're hunting malware, investigating logs, or collecting evidence, you're using these fundamental tools.

---

## Key Concepts

### [[Shell]] and the Command Line Interface

**Analogy**: Think of the shell like a translator at the UN—you speak English (commands), it translates to the OS's language, and reports back what happened.

**Definition**: A [[shell]] is the interpreter that accepts your text commands and communicates with the operating system to execute them. [[Bash]] (Bourne Again Shell) is the standard on most [[Linux]] systems and what you'll encounter in CySA+ scenarios.

### [[Command Prompt]] Structure

**Analogy**: The prompt is like a return address on an envelope—it tells you exactly where you are and what authority level you have.

**Definition**: The command prompt follows this pattern: `username@hostname:current_directory$`

| Element | Meaning | Example |
|---------|---------|---------|
| Before @ | User account running commands | analyst |
| Between @ and : | Machine name | soc-workstation-01 |
| Between : and $ | Your current location in the file system | /home/analyst/cases |
| $ symbol | Normal user privileges | $ |
| # symbol | Root/administrative privileges | # |

The ending symbol ($or #) is critical—it tells you your privilege level at a glance.

### [[Working Directory]] Navigation

**Analogy**: Your working directory is like being in a specific room in a building—you need to know which room you're in before opening drawers.

**Definition**: The [[working directory]] is your current location in the file system. [[pwd]] (Print Working Directory) displays the absolute path showing exactly where you are: `/home/analyst/cases/case-2024-001`

### [[Path]] Types: Absolute vs. Relative

**Analogy**: An absolute path is a GPS coordinate (works from anywhere); a relative path is "turn left, go 3 blocks" (only works from where you are now).

**Definition**: 
- **Absolute path**: Complete path from the root (`/`) — works from anywhere. Example: `cd /home/analyst/evidence`
- **Relative path**: Path from your current location — faster but context-dependent. Example: `cd evidence` (only works if you're already in `/home/analyst`)

### [[Directory]] Shortcut Symbols

**Analogy**: Shortcuts are like bookmarks in a book—quick jumps to important locations.

**Definition**:
- `.` = current directory (use: `cd ./malware_samples`)
- `..` = parent directory, one level up (use: `cd ..`)
- `~` = home directory of the current user (use: `cd ~`)
- `-` = previous directory, toggles back and forth (use: `cd -`)

---

## Command Documentation Tools

### [[whatis]]

**Analogy**: Like reading a one-liner summary on the back of a book cover.

**Definition**: Displays a single-line description of what a command does.

```
whatis pwd
# Output: pwd (1) - print name of working/current directory
```

Use this for quick context when you can't remember what a command is.

### [[help]]

**Analogy**: Like asking a coworker for a quick explanation of their workflow.

**Definition**: Shows usage information and parameters for [[shell]] built-in commands (commands that are part of [[Bash]] itself, not separate programs).

```
help cd
# Shows: cd [-L|[-P [-e]] [-@]] [dir]
```

Only works for built-ins; won't work for external commands like `find`.

### [[man]] (Manual Pages)

**Analogy**: The complete encyclopedia entry—exhaustive, detailed, sometimes overwhelming.

**Definition**: Displays comprehensive manual pages with full syntax, options, examples, and descriptions. The gold standard for command documentation.

```
man ls
# Gives you 10 pages of ls documentation
```

Use `man command_name` for in-depth learning. Press `q` to exit.

---

## File and Directory Operations

### [[ls]] (List)

**Analogy**: Opening a file cabinet and seeing what folders are inside.

**Definition**: Lists files and directories in a specified location.

| Command | What It Does | Use Case |
|---------|-------------|----------|
| `ls` | Basic file listing | Quick check of current directory |
| `ls /path/to/dir` | List specific directory | Check evidence folder contents |
| `ls -a` | Include hidden files (start with .) | Find config files attackers may have hidden |
| `ls -l` | Detailed listing (permissions, owner, size, date) | Forensic analysis of file properties |
| `ls -la` or `ls -al` | Combination: detailed + hidden files | Complete directory investigation |

In security investigations, `ls -la` is your workhorse—it reveals everything including suspicious hidden files.

### [[touch]]

**Analogy**: Like jotting down a note on a blank piece of paper.

**Definition**: Creates a new empty file instantly.

```
touch evidence.txt
# Creates a new file named evidence.txt
```

In a SOC, you'll use this to create temporary working files, logs, or documentation files during investigations.

### [[mkdir]] (Make Directory)

**Analogy**: Creating new folders in your filing cabinet for organization.

**Definition**: Creates new directories for organizing files.

| Command | Result | Use Case |
|---------|--------|----------|
| `mkdir case_2024_001` | Single directory | Create one case folder |
| `mkdir case1 case2 case3` | Multiple directories at once | Batch create case folders |
| `mkdir -p case/evidence/artifacts` | Nested directories (-p flag creates parent paths) | Organize investigation hierarchy |

The `-p` flag is powerful—it prevents "parent directory doesn't exist" errors.

### [[pwd]] (Print Working Directory)

**Analogy**: Checking the address on your envelope to confirm where you are.

**Definition**: Outputs the absolute path of your current location.

```
pwd
# Output: /home/analyst/investigations/case-2024-001
```

Run this constantly during investigations to avoid operating on files in the wrong directory—especially critical before running deletion commands!

### [[cd]] (Change Directory)

**Analogy**: Walking from one room to another in a building.

**Definition**: Navigates between directories using absolute or relative paths.

```
# Absolute: works from anywhere
cd /home/analyst/evidence/malware

# Relative: must be in /home/analyst first
cd evidence/malware

# Using shortcuts
cd ..              # Go up one level
cd ~               # Jump to home
cd -               # Toggle to previous directory
cd ./artifacts     # Explicitly reference current directory
```

Master `cd` navigation—it's the foundation of everything else.

---

## Analyst Relevance

Picture this: It's 2 AM, you've got a potential breach. A user's account has suspicious activity. You need to:

1. Navigate to the forensic image mounted at `/mnt/evidence/user_drive`
2. List all files including hidden ones that might contain attacker artifacts (`ls -la`)
3. Check your current location to avoid making mistakes (`pwd`)
4. Create an investigation folder structure (`mkdir -p /home/analyst/cases/breach_2024_001/{logs,artifacts,reports}`)
5. Copy suspicious files there for analysis
6. Document what you found

Without terminal fluency, you're blind. With it, you own the investigation. Every command here is used in real SOC work—not theoretical, not optional. These commands are your eyes and hands when investigating live systems, forensic images, and server infrastructure.

---

## Exam Tips

### Question Type 1: Navigation and Path Understanding

*"An analyst needs to navigate from `/home/analyst` to `/var/log/apache2`. Which command uses an absolute path?"*
→ `cd /var/log/apache2`

**Trick**: Watch for relative paths that look like absolute paths. Relative paths never start with `/`. If you see `cd var/log/apache2`, that would fail unless you're already in `/`.

*"What does the `.` symbol represent when used as `cd ./suspicious_folder`?"*
→ The current directory

**Trick**: Don't confuse `.` (current) with `..` (parent). The exam loves mixing these up in command strings.

### Question Type 2: Hidden Files and Detailed Listings

*"Which `ls` flag reveals hidden files that attackers commonly hide configuration in?"*
→ `-a` or `-la`

**Trick**: The exam may show output and ask which command produced it. Files starting with `.` (like `.bashrc`, `.ssh`) only appear with `-a`.

*"An investigator needs to see file permissions, ownership, and timestamps. Which command?"*
→ `ls -l` (or `ls -la` to include hidden files)

**Trick**: Know what each column in `-l` output means: permissions, owner, group, size, date, filename.

### Question Type 3: Directory Creation

*"An analyst needs to create nested directories: `case/evidence/artifacts/malware` but the `case` directory doesn't exist yet. Which command works?"*
→ `mkdir -p case/evidence/artifacts/malware`

**Trick**: Without `-p`, mkdir fails if parent directories don't exist. The flag "creates parents as needed"—memorize this.

---

## Common Mistakes

### Mistake 1: Confusing Absolute and Relative Paths

**Wrong**: "I'll use `cd home/analyst/evidence` to navigate anywhere in the system."

**Right**: Absolute paths start with `/` (like `/home/analyst/evidence`). Relative paths start with the current directory and work only from a specific location (like `cd evidence` when you're already in `/home/analyst`).

**Impact on Exam**: You'll get navigation questions wrong. You might also accidentally operate on files in the wrong directory—catastrophic in forensics where contamination matters.

---

### Mistake 2: Forgetting the `-a` Flag When Investigating

**Wrong**: Using `ls` without `-a` and missing hidden configuration files like `.ssh`, `.bashrc`, or `.bash_history` that contain attacker evidence.

**Right**: Always use `ls -la` during security investigations. Hidden files (starting with `.`) are where attackers hide backdoor access, credential theft, and persistence mechanisms.

**Impact on Exam**: You'll fail real-world scenarios because you miss critical evidence. Exam questions specifically test whether you know hidden files require `-a`.

---

### Mistake 3: Not Using `pwd` Before Dangerous Commands

**Wrong**: Running `rm -rf *` without verifying your location with `pwd` first, then realizing you deleted the wrong directory.

**Right**: Always run `pwd` before executing any destructive command. It takes 1 second and prevents irreversible damage.

**Impact on Exam**: Scenario-based questions test your safety habits. Analysts who show they verify location before deletion score higher on judgment-based questions.

---

### Mistake 4: Mixing Up `.` and `..`

**Wrong**: Using `cd ..` when you meant `cd .` (staying in current directory).

**Right**: 
- `.` = current directory
- `..` = parent (one level up)

**Impact on Exam**: Easy point to lose. The exam includes commands with these symbols mixed up to test attention to detail.

---

### Mistake 5: Not Understanding Shell vs. External Commands

**Wrong**: Using `help ls` to get documentation (doesn't work—`ls` is external, not a shell built-in).

**Right**: 
- `help cd` works (cd is built-in)
- `man ls` works (works for everything)
- `whatis ls` works (quick reference for external commands)

**Impact on Exam**: You'll waste time trying commands that don't work. Know which documentation tool fits which command type.

---

## Related Topics

- [[Linux File System Hierarchy]] — understanding `/home`, `/var`, `/root` and other critical directories
- [[File Permissions and Ownership]] — what the permission columns in `ls -l` mean
- [[Bash Scripting Basics]] — writing loops and automating repetitive navigation tasks
- [[Forensic File Collection]] — using these commands to gather evidence
-