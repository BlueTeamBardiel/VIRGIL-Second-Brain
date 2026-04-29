# wall

## What it is
Like a PA system that forces every logged-in user's terminal to display your message whether they want to hear it or not — `wall` (write all) is a Unix/Linux command that broadcasts a message to all currently logged-in users' terminals simultaneously. It requires elevated privileges (or sudo) to use without restriction.

## Why it matters
An attacker who gains a foothold on a Linux system with sufficient privileges can use `wall` to send misleading messages to all active users — for example, crafting a fake system alert saying "Critical maintenance: please re-enter your credentials at [malicious URL]." This is a low-tech, high-impact social engineering vector that leverages legitimate OS functionality, making it harder to detect as malicious activity.

## Key facts
- `wall` writes to all terminals listed under `/dev/pts/*` and `/dev/tty*` for active sessions
- Requires either root privileges or membership in the `tty` group to broadcast to terminals where the user has run `mesg n` (which blocks non-root messages)
- Used in incident response to alert active users of a breach or mandatory evacuation of a compromised system
- Abuse of `wall` falls under the **Living off the Land (LotL)** attack category — using native OS tools to avoid detection by AV/EDR
- Logging of `wall` usage is not enabled by default; defenders must explicitly audit `sudo` logs or use auditd rules to catch it

## Related concepts
[[Living off the Land Attacks]] [[Privilege Escalation]] [[Social Engineering]] [[Linux Auditing (auditd)]]