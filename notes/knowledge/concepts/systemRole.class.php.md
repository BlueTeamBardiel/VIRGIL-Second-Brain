# systemRole.class.php

## What it is
Like a bouncer's clipboard that decides who gets into the VIP section, `systemRole.class.php` is a PHP class file responsible for defining, assigning, and enforcing user roles within a web application's access control system. It typically handles role-based logic such as checking whether a user is an admin, moderator, or standard user before granting access to privileged functionality.

## Why it matters
In 2021, attackers exploiting broken access control vulnerabilities (OWASP #1) frequently target role management files like this one — if an attacker can manipulate a session variable or directly invoke the class with a forged role parameter, they can escalate privileges horizontally or vertically. For example, a vulnerability in this file could allow a standard user to call `setRole('admin')` without server-side verification, granting full administrative access.

## Key facts
- **Broken Access Control** (OWASP A01:2021) is the top web vulnerability category; insecure role class implementations are a primary attack surface
- PHP class files like this should **never trust client-supplied role data** — roles must be validated server-side against a database or session initialized at login
- **Insecure Direct Object Reference (IDOR)** attacks can chain with weak role classes when role IDs are predictable integers (e.g., `role=1` for user, `role=0` for admin)
- Role logic should enforce **least privilege** — the class should default to the most restrictive role if assignment fails or is ambiguous
- Source code exposure of `.php` class files via misconfigured servers (directory traversal, `.git` leaks) can reveal role hierarchy logic to attackers during reconnaissance

## Related concepts
[[Role-Based Access Control (RBAC)]] [[Privilege Escalation]] [[Broken Access Control]] [[PHP Object Injection]] [[Session Management]]