# Default Credentials

## What it is
Like a master key that every locksmith cuts identically and ships with every lock — default credentials are the factory-set usernames and passwords baked into devices and software at manufacture. Every Cisco router leaving the factory with `admin/admin`, every CCTV camera with `admin/12345` is a lock shipped with the same key given to everyone on Earth.

## Why it matters
In the 2016 Mirai botnet attack, threat actors scanned the internet for IoT devices (cameras, DVRs, routers) still running default credentials, compromised hundreds of thousands of them, and launched one of the largest DDoS attacks ever recorded — taking down DNS provider Dyn and knocking major websites offline. The fix was trivially simple: change the password before deployment.

## Key facts
- Default credentials are catalogued publicly at sites like `default-password.info` and in tools like **Hydra** and **Metasploit**, making exploitation trivial
- Changing default credentials before deployment is a foundational **hardening** step and is explicitly required by **CIS Benchmarks** and **NIST SP 800-123**
- Leaving default credentials active is classified as a **misconfiguration vulnerability** — one of OWASP's Top 10 and a common finding in penetration tests
- **Credential stuffing** attacks often use harvested default credential lists against internet-exposed management interfaces (SSH, Telnet, HTTP admin panels)
- Some regulations (e.g., California's **SB-327**) now legally require manufacturers to ship IoT devices with unique per-device credentials rather than shared defaults

## Related concepts
[[Hardening]] [[Credential Stuffing]] [[Misconfiguration]] [[IoT Security]] [[Privilege Escalation]]