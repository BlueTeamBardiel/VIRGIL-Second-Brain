# Basic Terminal Commands - 2

## What it is
Like a Swiss Army knife where each blade does one specific job, terminal commands are discrete tools that manipulate files, processes, and network state directly without a GUI middleman. This second set covers file permissions, process inspection, and network diagnostics — the commands that turn a blank terminal into a forensic workstation.

## Why it matters
During incident response, an analyst SSHing into a compromised Linux server will use `ps aux` to list running processes, `netstat -tulnp` (or `ss -tulnp`) to spot unexpected listening ports, and `chmod`/`chown` to lock down sensitive files an attacker may have made world-writable. Missing these commands means missing the attacker's persistence mechanism hiding in plain sight.

## Key facts
- `chmod 644 file` sets owner read/write, group and others read-only; `chmod 777` is a red flag — it grants everyone full access, a common misconfiguration attackers exploit
- `ps aux` lists ALL running processes with user ownership; look for processes running as root that shouldn't be
- `netstat -tulnp` or `ss -tulnp` reveals open TCP/UDP ports and the process ID bound to each — critical for detecting backdoors and rogue listeners
- `find / -perm -4000 2>/dev/null` locates SUID binaries — files that execute with owner privileges regardless of who runs them, a classic privilege escalation vector
- `grep -r "pattern" /var/log/` recursively searches logs for indicators of compromise without opening a GUI log viewer

## Related concepts
[[File Permissions and Access Control]] [[Privilege Escalation]] [[Incident Response Procedures]]