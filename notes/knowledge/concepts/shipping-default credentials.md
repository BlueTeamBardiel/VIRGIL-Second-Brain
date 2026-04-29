# shipping-default credentials

## What it is
Imagine every new apartment building handing out the same master key to every tenant — and never requiring them to change it. Shipping-default credentials are the factory-preset usernames and passwords (e.g., `admin/admin`, `admin/password`) embedded in hardware and software by vendors for initial setup, which remain exploitable if never changed by the end user.

## Why it matters
The 2016 Mirai botnet attack weaponized tens of thousands of IoT devices — cameras, DVRs, routers — by scanning the internet and logging in with a list of roughly 60 known default credential pairs. This gave attackers enough compute to launch a 620 Gbps DDoS attack against journalist Brian Krebs's site, demonstrating that unchanged defaults can cascade into internet-scale damage.

## Key facts
- Default credentials are catalogued in public databases like **DefaultPassword.us** and **CIRT.net**, making them trivially searchable by any attacker.
- **CIS Benchmark controls** and **NIST SP 800-82** explicitly require changing all default credentials before production deployment.
- Leaving defaults unchanged is directly mapped to **CWE-1392** (Use of Default Credentials) and is frequently tested on Security+ under the "hardening" domain.
- Tools like **Hydra** and **Medusa** can automate credential stuffing attacks using default credential wordlists, making exploitation scriptable in minutes.
- Many compliance frameworks (PCI-DSS Requirement 2.1, for example) mandate that all vendor-supplied defaults be changed and unnecessary default accounts disabled before any system touches a cardholder data environment.

## Related concepts
[[credential stuffing]] [[hardening]] [[IoT security]] [[privilege escalation]] [[network enumeration]]