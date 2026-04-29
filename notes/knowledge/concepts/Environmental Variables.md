# Environmental Variables

## What it is
Think of environmental variables like sticky notes plastered around a computer's workspace — every program that opens the office can read them without being explicitly told. Precisely, they are dynamic named values stored in a process's memory that define the operating environment for running applications, controlling behavior like where to find executables, library paths, and user-specific configurations.

## Why it matters
In the 2014 Shellshock vulnerability, attackers exploited Bash's handling of environment variables to execute arbitrary commands on web servers — CGI scripts passed HTTP headers as environment variables, and malformed values containing embedded code were executed by the shell before it even started. This single flaw compromised millions of servers worldwide, demonstrating that environment variables are a direct attack surface, not just a configuration convenience.

## Key facts
- `PATH` hijacking occurs when an attacker places a malicious binary in a directory listed early in the PATH variable, causing it to execute instead of the legitimate program
- On Unix/Linux, `LD_PRELOAD` is particularly dangerous — it forces the dynamic linker to load a specified library before all others, enabling privilege escalation if exploitable by a setuid binary
- Sensitive data (API keys, passwords) stored in environment variables can be exposed through `/proc/[pid]/environ` on Linux or via process inspection tools
- Environment variables are inherited by child processes, meaning malicious values can propagate through an entire process tree
- Windows uses `%VARIABLE%` syntax while Unix/Linux uses `$VARIABLE`; both are targets for injection in batch scripts and shell scripts respectively

## Related concepts
[[Privilege Escalation]] [[Path Hijacking]] [[Shellshock CVE-2014-6271]] [[Process Injection]] [[Secure Coding Practices]]