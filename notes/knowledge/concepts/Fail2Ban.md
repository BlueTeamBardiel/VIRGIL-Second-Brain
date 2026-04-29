# fail2ban

## What it is
Think of it as a bouncer who watches the velvet rope — after someone tries the wrong password three times, they're physically thrown out and their face goes on a blacklist. Fail2ban is an open-source intrusion prevention framework that monitors log files for repeated failed authentication attempts and dynamically updates firewall rules (e.g., iptables, nftables) to block offending IP addresses for a configurable duration.

## Why it matters
In a brute-force SSH attack, an automated tool like Hydra can attempt thousands of password combinations per minute against port 22. Fail2ban detects the pattern of repeated failures in `/var/log/auth.log`, triggers a ban rule after a defined threshold (e.g., 5 failures in 60 seconds), and blocks the attacker's IP — turning a viable attack into a dead end before credentials are compromised.

## Key facts
- Uses **"jails"** — configuration blocks pairing a log filter (regex pattern) with an action (typically a firewall ban); each service like SSH, Apache, or FTP gets its own jail
- Default ban action inserts a **DROP rule into iptables**, silently discarding packets from the banned IP rather than sending a reset
- **`bantime`**, **`findtime`**, and **`maxretry`** are the three core parameters controlling how quickly and how long bans are applied
- Fail2ban is a **reactive** control, not preventive — it doesn't stop the first N attempts, only escalates after the threshold is crossed
- Logs bans to `/var/log/fail2ban.log` and supports **email alerts**, making it relevant to both active defense and audit logging requirements

## Related concepts
[[brute-force attack]] [[iptables]] [[intrusion prevention system]] [[SSH hardening]] [[account lockout policy]]