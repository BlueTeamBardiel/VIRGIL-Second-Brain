# mutex

## What it is
Like a bathroom with a single key hanging on a hook — only one person can have the key at a time, and everyone else waits outside. A mutex (mutual exclusion lock) is a synchronization primitive that ensures only one thread or process can access a shared resource at a time, preventing race conditions in concurrent execution.

## Why it matters
Malware authors use a clever trick: they give their malware a unique mutex name so only one instance runs per machine (avoiding double-infection noise). Incident responders actively hunt for known mutex names — tools like Process Hacker or Sysinternals handle.exe reveal these artifacts, turning the malware's own anti-duplication mechanism into a detection fingerprint.

## Key facts
- A **race condition** occurs when two threads compete for a resource without mutex protection — attackers exploit this in TOCTOU (Time-of-Check to Time-of-Use) vulnerabilities to escalate privileges
- Mutexes are **kernel objects** on Windows, making them visible across processes and useful as malware IOCs (Indicators of Compromise)
- **Deadlock** happens when two threads each hold a mutex the other needs — a denial-of-service condition that can be deliberately triggered
- Common malware families leave well-documented mutex names (e.g., Poison Ivy used `]5DT6W]`) — threat intel feeds catalog these for detection rules
- Unlike semaphores, a mutex has **ownership** — only the thread that locked it can unlock it, preventing accidental releases

## Related concepts
[[race condition]] [[TOCTOU vulnerability]] [[indicators of compromise]]