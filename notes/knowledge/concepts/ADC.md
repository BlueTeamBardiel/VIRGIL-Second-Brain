# ADC

## What it is
Think of an ADC (Active Directory Certificate) like a government ID card issued by Active Directory—it proves who you are within a Windows network. Technically, ADC is a digital certificate bound to a user or computer object in Active Directory, issued by an enterprise Certificate Authority (CA), and used for authentication, encryption, and code signing within a domain environment.

## Why it matters
Attackers exploit weak ADC configurations to perform certificate-based attacks. A classic scenario: an attacker compromises a low-privileged user account, requests a certificate with an overly permissive template (like one that allows Subject Alternative Names to be specified), and uses it to impersonate a domain admin or service account. This bypasses traditional password-based protections and can lead to lateral movement or privilege escalation across the entire domain.

## Key facts
- ADCs are issued by enterprise CAs and stored in Active Directory; they're automatically discovered and trusted by domain machines
- Vulnerable certificate templates (ESC1-ESC8) allow attackers to request certs for arbitrary identities they don't own
- PKINIT (Public Key Cryptography for Initial Authentication) lets attackers use stolen certs to request Kerberos TGTs, completely bypassing passwords
- The Certify tool automates enumeration and exploitation of misconfigured AD CS environments
- Certificate validity periods can extend attack windows—a stolen cert might work for months undetected

## Related concepts
[[Active Directory]] [[Certificate Authority]] [[Kerberos]] [[Privilege Escalation]] [[ESC Attacks]]