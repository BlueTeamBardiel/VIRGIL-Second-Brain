# Job Control

## What it is
Like a theater stage manager who can pause an actor mid-scene, send them backstage, and recall them later — job control is the shell's mechanism for suspending, backgrounding, and foregrounding running processes. Precisely: job control is an OS and shell feature (primarily Unix/Linux) that allows users to manage multiple processes within a single terminal session using signals and process groups.

## Why it matters
During a Linux privilege escalation engagement, an attacker who gains a low-privilege shell can background a long-running exploit attempt with `Ctrl+Z` and `bg`, keeping it alive while continuing to enumerate the system in the foreground — avoiding the need for a second connection that might trigger IDS alerts. Defenders auditing shell histories for `bg`, `fg`, and `disown` commands can spot this multi-tasking tradecraft pattern.

## Key facts
- `Ctrl+Z` sends **SIGTSTP** to the foreground process, suspending it; `fg` resumes it in the foreground, `bg` resumes it in the background
- `disown` removes a job from the shell's job table, allowing it to survive shell exit — commonly abused by attackers to persist processes after closing a session
- Jobs are tracked by job ID (`%1`, `%2`) distinct from PIDs; `jobs -l` lists both
- `nohup` combined with `&` achieves similar persistence by ignoring **SIGHUP**, which is sent when a terminal closes
- Malicious use of `disown`/`nohup` can evade detection by orphaning processes from their originating terminal, making them harder to attribute in process trees

## Related concepts
[[Process Management]] [[Linux Privilege Escalation]] [[Signal Handling]] [[Persistence Mechanisms]]