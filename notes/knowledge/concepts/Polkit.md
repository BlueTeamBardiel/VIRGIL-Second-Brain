# Polkit

## What it is
Think of Polkit as a bouncer at a VIP club — regular users can request access to privileged actions, and the bouncer checks a rulebook to decide if they get in without needing to bother the club owner (root). Precisely, Polkit (formerly PolicyKit) is a Linux authorization framework that mediates privilege escalation between unprivileged processes and privileged system daemons, without requiring full sudo access. It defines fine-grained policies governing which users can perform which administrative actions.

## Why it matters
CVE-2021-4034, dubbed "PwnKit," exposed a memory corruption vulnerability in Polkit's `pkexec` binary that existed in the codebase for **12 years** and allowed any unprivileged local user to gain full root privileges on virtually every major Linux distribution. This made it a critical post-exploitation tool — an attacker who lands a low-privilege shell can immediately escalate to root, bypassing all application-level controls. Patching was urgent because exploitation was trivial and reliable.

## Key facts
- **pkexec** is Polkit's primary user-facing binary, similar to `sudo`, allowing execution of commands as another user under policy control
- PwnKit (CVE-2021-4034) was a **local privilege escalation (LPE)** vulnerability — requires existing local access, not remote exploitation alone
- Polkit policies are defined in XML files stored in `/usr/share/polkit-1/actions/` and can be overridden in `/etc/polkit-1/`
- Polkit runs as its own daemon (`polkitd`) and communicates via **D-Bus**, making D-Bus monitoring relevant for detecting abuse
- Authentication agents (GUI prompts asking for your password) are Polkit's mechanism for interactive authorization challenges

## Related concepts
[[Privilege Escalation]] [[D-Bus]] [[sudo]] [[CVE Exploitation]] [[Linux Hardening]]