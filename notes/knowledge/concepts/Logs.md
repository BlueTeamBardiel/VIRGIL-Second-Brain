# Logs

## What it is
Like a ship's captain recording every course correction, weather event, and crew action in a logbook, a system log is a timestamped, sequential record of every event that occurs within an operating system, application, or network device. Logs capture who did what, when, from where, and with what result — creating an auditable trail of system behavior.

## Why it matters
During the 2020 SolarWinds attack, investigators relied heavily on log analysis to reconstruct attacker movement through compromised networks — but many organizations discovered their logs had been deliberately cleared or never enabled in critical systems. A centralized, tamper-resistant logging strategy (using a SIEM) would have accelerated detection and contained the blast radius significantly earlier.

## Key facts
- **Windows Event Log key IDs to memorize:** 4624 (successful logon), 4625 (failed logon), 4648 (explicit credential use), 4720 (account creation), 7045 (new service installed)
- **Log types include:** Security logs, System logs, Application logs, DNS logs, firewall logs, proxy logs, and authentication logs — each revealing different attacker behaviors
- **Log integrity matters:** Attackers routinely clear logs (Windows Event ID 1102 signals audit log cleared); forward logs off-system immediately to prevent tampering
- **Retention requirements:** HIPAA mandates 6 years, PCI-DSS requires 1 year (3 months immediately accessible); know these for compliance questions
- **Syslog (UDP 514 / TCP 6514 for TLS)** is the standard protocol for shipping logs from network devices to centralized collectors — UDP is fast but lossy, TCP/TLS is reliable and encrypted

## Related concepts
[[SIEM]] [[Security Auditing]] [[Log Analysis]] [[Chain of Custody]] [[Syslog]]