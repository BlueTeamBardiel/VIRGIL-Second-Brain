# Kerberoasting

## What it is
Imagine a library where anyone with a library card can request a book locked with *any member's personal padlock* — then take that locked box home and try every key combination until it opens. Kerberoasting works the same way: any authenticated domain user can request a Kerberos service ticket (TGS) encrypted with a service account's NTLM password hash, then take that ticket offline and brute-force crack it without ever touching the target system again. It exploits a legitimate Kerberos feature, not a flaw, making it stealthy by design.

## Why it matters
In the 2020 SolarWinds-era lateral movement playbooks, attackers routinely used Kerberoasting to escalate privileges after gaining initial footholds — targeting service accounts that ran with Domain Admin privileges but had weak, rarely-rotated passwords. Defenders counter this by enforcing Managed Service Accounts (MSAs) with auto-rotating 120+ character passwords, making offline cracking computationally infeasible regardless of the attacker's hardware.

## Key facts
- **Any domain user can execute it** — no elevated privileges required to request TGS tickets
- **Attack is entirely offline** — after ticket extraction, no further network traffic to the DC is needed, evading many IDS signatures
- **RC4 encryption (etype 23) is the attacker's preference** — faster to crack than AES-256; presence of RC4 TGS requests for non-RC4-configured accounts is a detection signal
- **Tools:** Impacket's `GetUserSPNs.py`, Rubeus, and PowerView's `Invoke-Kerberoast` are the dominant extraction tools
- **SPNs are the attack surface** — only accounts with a registered Service Principal Name (SPN) are vulnerable to Kerberoasting

## Related concepts
[[Kerberos Authentication]] [[Pass-the-Hash]] [[Privilege Escalation]] [[Service Principal Names]] [[AS-REP Roasting]]