# Author Role

## What it is
Like a journalist who can write and edit their own articles but cannot publish the newspaper or fire other staff, an Author in content management and access control systems can create and modify content but lacks administrative privileges over the platform itself. Precisely, the Author role is a permission tier in role-based access control (RBAC) that grants create/read/update rights on owned objects while restricting deletion of others' content and system-level configuration.

## Why it matters
In a 2023-style WordPress compromise, attackers who gained Author-level credentials via phishing couldn't directly install malicious plugins (requiring Administrator), but they injected JavaScript into published posts to harvest visitor credentials — demonstrating that even restricted roles can enable significant damage. Defenders use this scenario to justify the principle of least privilege: Authors should only publish to sandboxed staging environments until content is reviewed.

## Key facts
- Author role exemplifies **least privilege** — users receive only permissions necessary for their function, reducing attack surface
- In RBAC models, the Author role sits **below Editor and Administrator** but above Subscriber/Reader in the privilege hierarchy
- Author accounts are common **lateral movement targets** because they're numerous, less monitored, and still allow content modification
- Overprivileged Author accounts (e.g., given plugin-install rights) violate **separation of duties** — a core security control tested on Security+ (SY0-701)
- Content injection via compromised Author accounts is categorized under **stored XSS** attack vectors in CWE/OWASP frameworks

## Related concepts
[[Role-Based Access Control (RBAC)]] [[Principle of Least Privilege]] [[Separation of Duties]] [[Stored XSS]] [[Privilege Escalation]]