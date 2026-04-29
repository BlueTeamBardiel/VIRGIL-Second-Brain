# FQDN

## What it is
Like a postal address that includes street, city, state, and country — rather than just "42 Main St" — an FQDN gives the complete, unambiguous location of a host on the internet. A Fully Qualified Domain Name specifies every level of the DNS hierarchy from the specific hostname down to the root, such as `mail.example.com.` (note the trailing dot representing the DNS root). Unlike a partial hostname, an FQDN can be resolved without relying on a local DNS search suffix to fill in the gaps.

## Why it matters
Attackers exploit ambiguous hostnames through a technique called **DNS search suffix abuse**: if a corporate workstation has `corp.local` as its DNS search suffix, a request for `payroll` resolves to `payroll.corp.local` — an attacker on the internal network who controls that name can intercept traffic. Using FQDNs in configuration files and scripts eliminates this ambiguity, forcing resolution to the exact intended host and cutting off this lateral movement vector.

## Key facts
- An FQDN includes the hostname, domain, and all parent domains ending at the root — e.g., `www.example.com.` (trailing dot = DNS root)
- Maximum FQDN length is **253 characters** total; each label (section between dots) is limited to **63 characters**
- Certificate validation depends on FQDNs — TLS certificates bind to specific FQDNs, so a mismatch triggers browser warnings and can indicate a MITM or misconfiguration
- In Active Directory environments, the FQDN of a domain controller is critical for Kerberos ticket issuance; incorrect FQDNs break authentication
- FQDNs are used in **Subject Alternative Names (SANs)** in X.509 certificates to specify which hostnames a cert is valid for

## Related concepts
[[DNS Spoofing]] [[TLS Certificate Validation]] [[Kerberos Authentication]] [[Active Directory]] [[Public Key Infrastructure]]