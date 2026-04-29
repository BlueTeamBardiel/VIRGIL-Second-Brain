# named pipes

## What it is
Like a pneumatic tube system in a bank — data goes in one end and comes out the other without being stored anywhere permanently. A named pipe (FIFO) is an inter-process communication (IPC) mechanism that allows two processes to exchange data through a filesystem path, persisting beyond the lifetime of either process and accessible by name rather than requiring a shared parent process.

## Why it matters
Attackers abuse named pipes heavily in post-exploitation. Tools like Cobalt Strike and Metasploit use named pipes for lateral movement and privilege escalation — a technique called "named pipe impersonation" lets a low-privileged process trick a high-privileged service into connecting to an attacker-controlled pipe, then steal that service's access token to escalate to SYSTEM. Defenders hunt for suspicious pipe names (e.g., `\\.\pipe\meterpreter`) in EDR telemetry as indicators of compromise.

## Key facts
- On Windows, named pipes live at `\\.\pipe\<name>` and are a primary mechanism for SMB-based communication, including inter-process lateral movement
- **Named pipe impersonation** is a classic local privilege escalation technique: create a pipe, wait for a privileged service to connect, call `ImpersonateNamedPipeClient()` to assume their token
- Unlike anonymous pipes, named pipes can communicate across a network (via SMB), making them useful for C2 channels that blend into legitimate traffic
- Tools like `pipelist.exe` (Sysinternals) or PowerShell's `Get-ChildItem \\.\pipe\` enumerate active pipes — a key forensic artifact during incident response
- Named pipes support two modes: **byte mode** (raw stream) and **message mode** (discrete packets), with message mode preferred for structured C2 communication

## Related concepts
[[inter-process communication]] [[privilege escalation]] [[access tokens]] [[lateral movement]] [[SMB protocol]]