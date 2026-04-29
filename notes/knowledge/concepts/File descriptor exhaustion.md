# File descriptor exhaustion

## What it is
Like a hotel with only 1,024 keycards — once every card is handed out, new guests are turned away at the door even if rooms are available. File descriptor exhaustion occurs when a process or system consumes all available file descriptor slots (integers the OS uses to track open files, sockets, and pipes), causing subsequent attempts to open resources to fail with errors like `EMFILE` or `ENFILE`.

## Why it matters
Attackers exploit this in denial-of-service scenarios by opening thousands of half-open TCP connections or repeatedly calling `open()` without closing handles, starving a target service of its ability to accept new connections. The 2009 Slowloris HTTP DoS tool weaponized exactly this principle — holding connections open to exhaust server socket descriptors without sending complete requests, taking down Apache servers with minimal bandwidth.

## Key facts
- Linux systems default to **1,024 file descriptors per process** (`ulimit -n`); the system-wide limit is set in `/proc/sys/fs/file-max`
- File descriptors cover more than files: sockets, pipes, device handles, and epoll instances all consume slots
- **Resource leaks** (forgetting to call `close()`) cause gradual exhaustion in long-running daemons — a common root cause in production outages
- Defenders mitigate this by setting hard limits via `ulimit`, using connection rate limiting (e.g., `iptables -m connlimit`), and monitoring `/proc/<pid>/fd/` for abnormal descriptor counts
- On Windows, the analogous concept is **handle exhaustion** — tracked via `GetSystemHandleCount()` and visible in Process Explorer

## Related concepts
[[Denial of Service]] [[Resource Exhaustion]] [[TCP Half-Open Connection Attack]] [[Slowloris Attack]] [[Race Condition]]