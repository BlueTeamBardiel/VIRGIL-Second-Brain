# PTY

## What it is
Think of a PTY like a phone call between two people using walkie-talkies through a relay station — both sides think they're talking directly, but there's a translator in the middle handling the signals. A **pseudo-terminal (PTY)** is a software pair of virtual file descriptors (master/slave) that emulates a physical terminal, allowing programs to interact with shell sessions as if a real keyboard and screen were attached. SSH sessions, terminal emulators, and `screen`/`tmux` all operate through PTYs.

## Why it matters
In penetration testing and post-exploitation, attackers frequently need to **upgrade a dumb reverse shell to a fully interactive PTY shell** because dumb shells break when running tools like `sudo`, `vi`, or `ssh` that require terminal control. The classic technique — `python3 -c 'import pty; pty.spawn("/bin/bash")'` followed by backgrounding and `stty` manipulation — spawns a PTY to get job control, tab completion, and proper signal handling, dramatically expanding attacker capability without triggering additional network connections.

## Key facts
- PTYs consist of a **master/slave pair**: the master is held by the terminal emulator; the slave is the `/dev/pts/N` device seen by the shell process
- Spawning a PTY is a common **privilege escalation indicator** — security tools like auditd and Falco alert on unexpected `openpty()` or `forkpty()` syscalls
- `tty` command returns the current PTY device; `who` and `w` show which users are attached to which PTYs
- **No-PTY SSH connections** (`ssh -T`) disable pseudo-terminal allocation, used to harden automated pipelines and prevent interactive shell abuse
- Docker containers run without a TTY by default (`docker exec` requires `-t` flag to allocate one), limiting certain attack techniques on containerized targets

## Related concepts
[[Reverse Shell]] [[Privilege Escalation]] [[SSH Hardening]]