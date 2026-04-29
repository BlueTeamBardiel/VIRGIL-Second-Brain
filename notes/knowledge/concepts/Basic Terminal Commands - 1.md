# Basic Terminal Commands - 1

## What it is
Think of the terminal like talking directly to the engine room of a ship — no touchscreen dashboard, just raw commands to the crew. The terminal (command-line interface) is a text-based interface that allows users to interact directly with the operating system by typing instructions, bypassing graphical layers entirely. On Linux/Unix systems this is typically Bash; on Windows, CMD or PowerShell.

## Why it matters
During incident response, an analyst SSH'd into a compromised Linux server must navigate the filesystem, inspect running processes, and examine network connections — all without a GUI. Commands like `ps aux`, `netstat -tulnp`, and `cat /etc/passwd` are often the first tools a defender uses to determine whether a rootkit is hiding malicious processes or unauthorized accounts have been created.

## Key facts
- `pwd` prints the current working directory; `ls -la` lists all files including hidden ones (prefixed with `.`) with permissions — critical for spotting rogue files
- `cd`, `cp`, `mv`, `rm`, and `mkdir` are the core filesystem navigation and manipulation commands
- `cat`, `less`, and `grep` allow reading and searching file contents — `grep -r "password" /etc/` can quickly surface credential exposure
- `chmod` and `chown` control file permissions and ownership; misconfigured permissions are a top Linux privilege escalation vector
- On Windows CMD, equivalent commands include `dir` (ls), `type` (cat), `icacls` (chmod) — knowing both platforms matters for CySA+ scenarios

## Related concepts
[[Linux File Permissions]] [[Command Line Scripting]] [[Log Analysis]]