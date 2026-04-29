# Windows Certificate Services

## What it is
Think of it as a government passport office that your organization runs in-house — instead of a foreign authority stamping your identity documents, your own servers issue and sign digital certificates. Windows Certificate Services (Active Directory Certificate Services, or AD CS) is a Microsoft server role that lets organizations operate their own Public Key Infrastructure (PKI), issuing X.509 certificates for authentication, encryption, and digital signing. It functions as an internal Certificate Authority (CA) trusted by all domain-joined machines.

## Why it matters
AD CS has become a prime attack target because misconfigured certificate templates can allow low-privileged users to request certificates that impersonate domain administrators — a class of vulnerabilities documented by SpecterOps as **ESC1 through ESC8**. An attacker who exploits ESC1 can request a certificate with an arbitrary Subject Alternative Name (SAN), effectively forging a domain admin's identity and achieving full domain compromise without touching a password. This makes AD CS misconfigurations as dangerous as Kerberoasting or Pass-the-Hash.

## Key facts
- AD CS issues certificates through a **Certificate Authority (CA)** hierarchy: typically a root CA (offline) and subordinate issuing CAs (online)
- **Certificate templates** define what a cert can be used for (e.g., smart card login, EFS, code signing) — overly permissive templates are the primary attack surface
- The **ESC1 vulnerability** occurs when a template allows the requester to supply a SAN *and* enables client authentication — allowing identity spoofing
- Tools like **Certipy** (Linux) and **Certify** (Windows) automate enumeration of vulnerable AD CS configurations
- Certificates issued by AD CS can be used for **PKINIT Kerberos authentication**, making stolen or forged certs equivalent to stolen passwords

## Related concepts
[[Public Key Infrastructure]] [[Kerberos Authentication]] [[Active Directory Attack Paths]] [[X.509 Certificates]] [[Privilege Escalation]]