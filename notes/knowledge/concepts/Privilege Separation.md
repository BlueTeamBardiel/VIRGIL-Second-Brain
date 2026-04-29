# Privilege Separation

## What it is
Like a restaurant where the waiter takes your order but never enters the kitchen, privilege separation splits a program into components that each hold only the privileges they need for their specific task. Formally, it is a design principle that divides a process into isolated parts — a privileged component handling sensitive operations and an unprivileged component handling untrusted input — so that a compromise of one part does not automatically yield control of the other.

## Why it matters
OpenSSH pioneered this technique in 2002 specifically to limit exploitation blast radius. When an attacker sends malicious data to the SSH daemon during connection setup, they interact with an unprivileged child process running in a chroot jail — if exploited, they gain almost no privileges because the sensitive key material and authentication logic live in a separate privileged monitor process that only responds to tightly defined messages.

## Key facts
- **Principle of Least Privilege is the parent concept** — privilege separation is its structural, architectural enforcement in software design
- OpenSSH uses a three-phase model: pre-auth unprivileged child → privileged monitor → post-auth unprivileged user process
- Chromium's sandbox architecture applies privilege separation by isolating the renderer (handles untrusted web content) from the browser process (holds OS permissions)
- Privilege separation reduces the **attack surface** of critical processes by ensuring exploited components have minimal capability to pivot
- It is distinct from **privilege escalation prevention** — separation limits damage *after* exploitation, while escalation controls prevent gaining higher privilege *in the first place*

## Related concepts
[[Principle of Least Privilege]] [[Sandboxing]] [[Defense in Depth]] [[Attack Surface Reduction]] [[Process Isolation]]