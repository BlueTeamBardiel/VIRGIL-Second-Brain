# MITRE ATT&CK T1059.004

## What it is
Like a building superintendent who uses a master key to quietly access every room without triggering alarms, attackers use Unix shells to move through a compromised Linux/macOS system with native authority. T1059.004 describes adversary use of Unix shell interpreters — bash, sh, zsh, dash — to execute commands, chain operations via pipes, and automate malicious tasks using shell scripts.

## Why it matters
During the 2021 TeamTNT cryptomining campaign, attackers gained initial access to exposed Docker APIs and immediately dropped bash scripts that disabled security tools, harvested cloud credentials from environment variables, and installed XMRig miners — all in a single shell session. Defenders countering this watch for anomalous shell processes spawned by web servers (e.g., `apache2` forking `bash`) using EDR tools or auditd rules.

## Key facts
- Bash is the primary target shell on Linux; zsh is common on modern macOS (post-Catalina default)
- Shell scripts (`.sh` files) or commands passed via `-c` flag (e.g., `bash -c "curl | bash"`) are the most common delivery mechanisms
- Attackers use pipes, redirects, and heredocs to chain commands and evade simple signature detection
- Living-off-the-land: no new binary needs to be dropped — the shell itself IS the weapon
- Detection focus: parent-child process anomalies (e.g., `nginx` spawning `bash`), base64-decoded commands, and `/tmp` write + execute patterns

## Related concepts
[[T1059 Command and Scripting Interpreter]] [[Living Off the Land Binaries (LOLBins)]] [[Process Injection]] [[Auditd Linux Logging]] [[T1053.003 Cron Job Persistence]]