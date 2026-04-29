# Authenticated File Read

## What it is
Like a hotel guest who has a valid keycard but uses it to sneak into the maintenance closet instead of their assigned room — an Authenticated File Read occurs when a legitimately logged-in user reads files they are not authorized to access. Specifically, it's a vulnerability where valid credentials bypass or satisfy authentication checks but authorization controls fail to restrict file system access appropriately.

## Why it matters
In 2021, attackers exploited an Authenticated File Read in Pulse Secure VPN appliances (CVE-2021-22893) to read sensitive configuration files containing cached credentials — even after patches were applied — because session tokens from previously compromised accounts remained valid. This allowed persistent access without re-exploitation, demonstrating that authentication alone is not a security boundary.

## Key facts
- Authenticated File Read is distinct from **unauthenticated** file read — credentials are required, but authorization (what the user *can* access) is the broken control
- Often manifests through **path traversal** (e.g., `../../etc/passwd`) or **direct object reference** flaws after login
- Commonly targeted files include `/etc/passwd`, `/etc/shadow`, application config files, SSH private keys, and `.env` files containing secrets
- Discovered frequently in **VPNs, CMS platforms, and REST APIs** where file-serving endpoints lack proper access control lists (ACLs)
- Exploitability is rated **higher severity** than similar unauthenticated reads by some frameworks because insiders, compromised accounts, or low-privilege users become viable attackers

## Related concepts
[[Path Traversal]] [[Broken Access Control]] [[Local File Inclusion]] [[Insecure Direct Object Reference]] [[Principle of Least Privilege]]