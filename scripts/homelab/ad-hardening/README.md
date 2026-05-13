# AD Hardening — Homelab Labs

Eleven PowerShell scripts that take a fresh Windows Server lab and harden it the way the certs say you should. Each maps to specific cert objectives. Stand up a Server 2022 VM, run them in order, and you've built concrete artifacts to point `/teach` at when the syllabus gets abstract.

## What these are

These are study-adjacent labs. The cert content in `notes/knowledge/security-plus/` and `notes/knowledge/cysa/` explains *what* LAPS is, *what* PowerShell logging does, *what* SMB signing prevents. These scripts let you actually deploy those controls in a lab and see what they look like when they're configured for real. Reading the GPO setting in a Sec+ note is one thing. Running `09-gpo-laps.ps1` and watching a local administrator password rotate is a different thing — the second one sticks.

You don't need a real homelab. A single Server 2022 VM in VirtualBox or Hyper-V is enough.

## Running order

Run them in numeric order. Each builds on assumptions from the previous one (DNS exists, security groups exist, audit policy is on before you log group changes, etc.).

| Script | What it does | Cert objective |
|---|---|---|
| `01-dns-records.ps1` | Audits and documents DNS records in the domain | Net+ — DNS, CCNA — DNS |
| `02-security-groups.ps1` | Inventories security groups, finds nested/circular memberships | Sec+ — IAM, CySA+ — Account audit |
| `03-service-accounts.ps1` | Lists service accounts, flags stale or over-privileged ones | Sec+ — Service accounts, CySA+ — Account hygiene |
| `04-password-lockout-policy.ps1` | Sets domain password policy and lockout thresholds | Sec+ — Account policies, CySA+ — Hardening |
| `05-gpo-audit-policy.ps1` | Enables advanced audit policy (4624, 4625, 4768, etc.) | CySA+ — Logging & monitoring, Sec+ — Log sources |
| `06-gpo-powershell-logging.ps1` | Enables PowerShell module logging, script-block logging, transcription | CySA+ — Endpoint detection, Sec+ — Logging |
| `07-gpo-smb-signing.ps1` | Forces SMB signing to prevent SMB relay | Sec+ — SMB hardening, CySA+ — NTLM/SMB attacks |
| `08-gpo-firewall.ps1` | Sets Windows Firewall via GPO across domain | Sec+ — Host hardening |
| `09-gpo-laps.ps1` | Deploys LAPS for local admin password rotation | Sec+ — LAPS, CySA+ — Credential management |
| `10-gpo-applocker.ps1` | Sets up AppLocker rules to block unauthorized executables | Sec+ — Application allow-listing |
| `11-activate-windows.ps1` | Helper to activate the Windows Server VM license | — (lab convenience) |

## Adapting them

Read each script before running it. Several assume a domain name and OU structure you'll need to adjust for your lab. Treat them as recipes, not turnkey installers — the goal is for you to understand what each line is doing so you can explain it on the exam.

If a script does something you don't understand, ask `/teach` to explain that GPO setting or PowerShell construct. The point isn't to run the scripts; it's to understand the controls they configure.

## What they're not

- Not production-ready. They harden a lab, not a real environment.
- Not turnkey. You'll edit paths, names, and OU references to fit your lab.
- Not exhaustive. Real AD hardening includes things these scripts don't touch (tiered admin, AGPM, Just-Enough-Administration, etc.).

The 11 scripts cover the controls that the cert exams care about. For deeper AD hardening, read CISA's [Mitigations for Active Directory](https://www.cisa.gov/news-events/cybersecurity-advisories) advisories and Microsoft's [Best Practices for Securing Active Directory](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).
