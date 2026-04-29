# subprocess

## What it is
Like a manager delegating work by shouting orders to a subordinate process running in a separate room, `subprocess` is a programming mechanism that allows a parent process to spawn, communicate with, and control child processes at the OS level. In Python specifically, the `subprocess` module provides the API; more broadly, subprocess execution describes any technique where an application launches external commands or programs.

## Why it matters
Command injection attacks exploit subprocess execution directly — an attacker who controls input to a `subprocess.call("ping " + user_input, shell=True)` call can append `; rm -rf /` and execute arbitrary OS commands. Defenders audit code for `shell=True` usage and unsanitized inputs feeding into subprocess calls, as this pattern appears frequently in CVEs targeting web applications and automation scripts.

## Key facts
- **`shell=True` is dangerous**: it passes the command through the system shell (bash/cmd.exe), enabling metacharacter injection (`;`, `|`, `&&`, backticks)
- **Prefer list arguments**: `subprocess.run(["ping", user_input])` prevents shell interpretation — the OS treats each list element as a literal argument
- **Command injection (CWE-78)** is the formal vulnerability class when attacker-controlled data reaches a subprocess call unsanitized
- **SUID/privilege escalation**: if a privileged binary calls subprocesses using relative paths, attackers manipulate `PATH` to hijack which binary executes (PATH hijacking)
- **Detection**: SIEM rules flagging unexpected child processes (e.g., `apache` spawning `cmd.exe` or `bash`) are a primary indicator of web shell compromise

## Related concepts
[[Command Injection]] [[Path Traversal]] [[Privilege Escalation]] [[Process Hollowing]] [[Input Validation]]