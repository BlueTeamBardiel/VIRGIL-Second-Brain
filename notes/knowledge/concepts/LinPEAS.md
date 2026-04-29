# LinPEAS

## What it is
Like a bloodhound that memorizes every scent trail in a building before reporting back to its handler, LinPEAS systematically sniffs every corner of a Linux system for privilege escalation paths. It is a shell script from the PEASS-ng toolkit that automates enumeration of misconfigurations, weak permissions, vulnerable software versions, and credential exposures on Linux/Unix hosts. It doesn't exploit — it maps every door that might already be unlocked.

## Why it matters
During a penetration test, an attacker lands a low-privilege shell via a web application vulnerability. Rather than manually checking hundreds of config files and SUID binaries, they run LinPEAS, which highlights a writable `/etc/passwd` file and a cronjob running as root — two clear paths to full system compromise in under two minutes. Defenders use its output in reverse: hardening checklists built from what LinPEAS would find become the remediation roadmap.

## Key facts
- LinPEAS color-codes findings: **red/yellow = high probability of privilege escalation**, making triage fast during time-boxed engagements
- It checks for SUID/SGID binaries, sudo misconfigurations, writable cron jobs, exposed credentials in config files, and kernel exploit candidates
- Runs entirely in memory when piped via `curl | sh`, leaving minimal disk artifacts — relevant for stealth and forensic detection evasion
- Part of the **PEASS-ng** (Privilege Escalation Awesome Scripts Suite) project; the Windows equivalent is WinPEAS
- Its output is commonly fed into post-exploitation frameworks and is referenced in OSCP exam methodology for systematic local enumeration

## Related concepts
[[Privilege Escalation]] [[SUID Binaries]] [[Post-Exploitation]] [[Linux File Permissions]] [[WinPEAS]]