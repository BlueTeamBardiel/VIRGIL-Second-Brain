# shell

## What it is
Think of a shell like a drive-through intercom — it's the interface between you (the customer) and the kitchen (the OS kernel) where your orders get translated into action. Precisely, a shell is a command-line interpreter that accepts user input, parses it, and passes instructions to the operating system for execution. Common examples include Bash (Linux), PowerShell (Windows), and cmd.exe.

## Why it matters
Attackers who compromise a web server often implant a **web shell** — a malicious script (PHP, ASP) uploaded to the server that provides remote command execution through a browser. From there, they can exfiltrate data, pivot laterally, or establish persistence — all while hiding behind legitimate HTTP traffic that firewalls typically allow. Defenders hunt for web shells by monitoring for unusual child processes spawned by web server processes (e.g., `apache2` spawning `whoami`).

## Key facts
- **Reverse shell**: victim machine initiates an outbound connection back to the attacker, bypassing inbound firewall rules — commonly established via `netcat`, `Bash /dev/tcp`, or Metasploit payloads
- **Bind shell**: malicious listener opens a port on the victim machine; attacker connects inbound — easier to detect and block
- **Web shells** are a top post-exploitation technique; defenders use file integrity monitoring (FIM) and EDR to detect them
- PowerShell logging (`Script Block Logging`, `Module Logging`) is a critical defensive control against living-off-the-land attacks using native shells
- Shell escape (or "breakout") occurs when a restricted shell or sandboxed environment is bypassed — common in CTFs and privilege escalation scenarios (e.g., `vi :!bash`)

## Related concepts
[[reverse shell]] [[command and control]] [[privilege escalation]] [[web shell]] [[PowerShell logging]]