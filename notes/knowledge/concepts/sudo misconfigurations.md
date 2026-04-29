# sudo misconfigurations

## What it is
Like giving a hotel housekeeper a master key because they need to clean one specific room — sudo misconfigurations grant users far more system-level access than their job requires. Precisely, `sudo` (superuser do) is a Linux privilege escalation tool that lets users execute commands as root or another user; misconfigurations occur when the `/etc/sudoers` file is overly permissive, allowing attackers to leverage legitimate access into full root compromise.

## Why it matters
In a 2021 penetration test scenario, an attacker who compromised a low-privilege web server account discovered the account could run `sudo vim` without a password. By spawning a shell from within vim (`:!bash`), the attacker escaped to a fully interactive root shell — achieving complete system compromise from a single misconfigured sudoers entry. This pattern is so common that GTFOBins maintains a dedicated catalog of such escapes.

## Key facts
- The `NOPASSWD` directive in `/etc/sudoers` allows commands to run as root without password prompting — a critical misconfiguration when applied to shells or editors
- Wildcard abuse: `sudo /bin/vi /var/log/*` can be exploited by passing a malicious filename like `/var/log/../../etc/passwd`
- `sudo -l` is the attacker's first enumeration command after gaining a shell — it lists all allowed sudo commands for the current user
- The `env_reset` option should be enabled to prevent environment variable injection attacks like `LD_PRELOAD` privilege escalation
- CVE-2021-3156 (Baron Samedit) demonstrated that even properly configured sudo can be vulnerable — patching is as critical as configuration

## Related concepts
[[principle of least privilege]] [[privilege escalation]] [[Linux file permissions]] [[GTFOBins]] [[credential misuse]]