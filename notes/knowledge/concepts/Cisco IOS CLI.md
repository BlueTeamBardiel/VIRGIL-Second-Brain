# Cisco IOS CLI

## What it is
Think of it as the cockpit control panel of a commercial jet — every critical system is accessible, but only if you know which switches to flip and in what order. Cisco IOS (Internetwork Operating System) CLI is the command-line interface used to configure, monitor, and troubleshoot Cisco routers and switches, organized into privilege levels and configuration modes that gate access to increasingly sensitive controls.

## Why it matters
During a network penetration test, an attacker who gains access to a Cisco device with default credentials (`enable` password: `cisco`) can enter privileged EXEC mode and issue `show running-config` to expose every ACL, VLAN, routing protocol, and stored credential in plaintext — instantly mapping the entire network architecture. Defenders must enforce AAA (Authentication, Authorization, Accounting) via RADIUS or TACACS+ to prevent exactly this scenario.

## Key facts
- **Two critical modes:** User EXEC (`>`) provides limited read-only commands; Privileged EXEC (`#`) unlocks full configuration access — the difference between reading a manual and flying the plane.
- **`enable secret`** stores the privileged password as an MD5 hash; **`enable password`** stores it in cleartext — always prefer `secret`.
- **`service password-encryption`** applies weak Type 7 (Vigenère cipher) encryption to plaintext passwords in configs — easily reversible, not a true security control.
- **SSH vs. Telnet:** Telnet transmits CLI sessions in cleartext; configuring `transport input ssh` on VTY lines forces encrypted management access — a common exam and audit checkpoint.
- **Logging and SNMP:** `show logging` and SNMP polling of MIBs are primary sources of evidence during incident response on Cisco infrastructure.

## Related concepts
[[AAA Authentication]] [[Network Access Control]] [[Privileged Access Management]]