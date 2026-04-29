# inter-process communication

## What it is
Like workers in separate offices passing notes through a mail slot in the wall, IPC is the mechanism that allows separate processes running on the same system to exchange data and coordinate actions. Precisely, IPC encompasses OS-provided mechanisms — pipes, sockets, shared memory, message queues, and semaphores — that enable process isolation to coexist with necessary collaboration. The kernel mediates these channels, enforcing access controls between communicating parties.

## Why it matters
Privilege escalation attacks frequently exploit insecure IPC channels — a classic example is a low-privileged process sending crafted messages to a high-privileged service via a named pipe on Windows, tricking it into executing arbitrary code under SYSTEM context. This pattern appeared in real-world exploits targeting Windows Task Scheduler and various antivirus engines that exposed powerful IPC endpoints without proper caller authentication. Defenders audit IPC endpoint permissions as part of hardening, since an exposed named pipe or D-Bus socket can be as dangerous as an open network port.

## Key facts
- **Named pipes** on Windows are a common IPC attack surface; tools like PipeList and AccessChk reveal exposed pipes with weak DACLs
- **Shared memory segments** can leak sensitive data between processes if permissions are misconfigured (world-readable `/dev/shm` objects on Linux)
- **D-Bus** is the primary IPC mechanism on Linux desktops; misconfigured D-Bus policies have enabled local privilege escalation on systemd-based systems
- **TOCTOU (Time-of-Check to Time-of-Use)** race conditions frequently occur in IPC implementations where state is shared asynchronously
- IPC mechanisms are governed by the OS security model — Unix domain sockets respect filesystem permissions, while Windows named pipes use security descriptors

## Related concepts
[[privilege escalation]] [[race conditions]] [[shared memory attacks]]