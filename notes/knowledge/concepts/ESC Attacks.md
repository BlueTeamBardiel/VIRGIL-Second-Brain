# ESC Attacks

## What it is
Imagine a corrupt notary who will stamp *any* document as official — that's an exploitable Certificate Authority template. ESC (Escalation via Certificate Services) attacks are a family of Active Directory Certificate Services (ADCS) misconfigurations where attackers abuse certificate templates, enrollment permissions, or CA settings to obtain certificates that impersonate privileged users, enabling domain privilege escalation.

## Why it matters
In a 2021 SpecterOps research disclosure, Will Schroeder and Lee Christofore documented 8+ ESC techniques (ESC1–ESC8) showing that most enterprise AD environments running ADCS were vulnerable. A low-privileged attacker exploiting ESC1 — where a certificate template allows the requester to specify a Subject Alternative Name (SAN) — can request a certificate claiming to be a Domain Admin and authenticate to the domain via PKINIT Kerberos, achieving full compromise without touching a password.

## Key facts
- **ESC1**: Template allows `ENROLLEE_SUPPLIES_SUBJECT` flag + low-privileged users can enroll = attacker supplies arbitrary SAN (e.g., `Administrator@domain.com`)
- **ESC4**: Over-permissioned template ACLs allow a low-privileged user to *modify* a template, then exploit it as ESC1
- **ESC8**: NTLM relay to the ADCS HTTP enrollment endpoint (`/certsrv`) allows coercing a Domain Controller to authenticate and relaying that credential to obtain a DC certificate
- **Detection**: Monitor Certificate Services event logs — Event ID **4886** (certificate issued) and **4887** are key indicators for anomalous enrollment activity
- **Tool**: `Certify.exe` (by SpecterOps) is the primary enumeration tool; `Certipy` is the Python equivalent used in offensive engagements and CTFs

## Related concepts
[[Active Directory Certificate Services]] [[Kerberos Authentication]] [[NTLM Relay Attacks]] [[Privilege Escalation]] [[PKI Infrastructure]]