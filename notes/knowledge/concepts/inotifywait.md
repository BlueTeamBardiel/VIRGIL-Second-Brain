# inotifywait

## What it is
Like a doorbell that rings every time someone touches a specific file cabinet drawer, `inotifywait` is a Linux command-line tool that hooks into the kernel's inotify subsystem to watch filesystem events (reads, writes, deletions, permission changes) in real time. It blocks and waits until a monitored event occurs, then reports it — making it a lightweight, scriptable filesystem sentinel.

## Why it matters
Defenders use `inotifywait` to detect tampering with critical configuration files like `/etc/passwd` or `/etc/sudoers` — the moment an attacker writes to those files, a monitoring script can trigger an alert or kill the session. Conversely, attackers who discover active `inotifywait` monitoring may time their persistence mechanisms (cron injection, SSH key drops) between polling intervals to evade detection.

## Key facts
- Operates via the Linux kernel's **inotify API**, meaning it consumes almost no CPU compared to polling-based solutions — it only wakes when an event fires
- Common event flags include `MODIFY`, `CREATE`, `DELETE`, `ATTRIB`, and `MOVED_TO`, each mappable to specific attack behaviors
- Running `inotifywait -m -r /etc/` monitors *recursively* and *continuously* (`-m` = monitor mode), essential for catching transient file writes
- A classic blue-team use case: detecting **web shell drops** by watching the web root (`/var/www/html`) for unexpected `CREATE` events
- `inotifywait` is part of the **inotify-tools** package and is not installed by default — its absence can be an indicator of a hardened vs. unmanaged system

## Related concepts
[[File Integrity Monitoring]] [[Linux Privilege Escalation]] [[Auditd]] [[Persistence Mechanisms]] [[SIEM Log Ingestion]]