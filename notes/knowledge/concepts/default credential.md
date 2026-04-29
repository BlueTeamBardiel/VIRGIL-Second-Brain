# default credential

## What it is
Like a master key shipped with every lock in a hotel chain — convenient for the manufacturer, catastrophic if guests never change it. A default credential is a factory-set username and password (e.g., `admin/admin`, `admin/password`) embedded in hardware or software by the vendor, intended as a starting configuration that administrators are expected to replace before deployment.

## Why it matters
In the 2016 Mirai botnet attack, attackers scanned the internet for IoT devices (cameras, routers, DVRs) using a hardcoded list of ~60 default credential pairs. Millions of devices were compromised and weaponized into a massive DDoS botnet that took down Dyn DNS, making Twitter, Netflix, and Reddit unreachable. Changing default credentials on every deployed device would have neutralized most of the attack surface.

## Key facts
- Default credentials are a top attack vector for network devices, IoT, and web application admin panels; explicitly tested in penetration testing frameworks like Metasploit.
- **Credential databases** like SecLists and CIRT.net catalog thousands of known vendor defaults, making automated scanning trivial.
- NIST SP 800-82 and CIS Controls both mandate changing default credentials as a baseline hardening step.
- Some vendors hardcode credentials that **cannot be changed** (a subset of default credentials called *hardcoded* or *embedded* credentials) — these require firmware updates or device replacement to remediate.
- On Security+ and CySA+ exams, default credentials fall under **misconfiguration** vulnerabilities and are a key item in system hardening checklists.

## Related concepts
[[hardcoded credential]] [[misconfiguration]] [[IoT security]] [[network hardening]] [[vulnerability scanning]]