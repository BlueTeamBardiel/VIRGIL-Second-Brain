# Trust Modification

## What it is
Like a corrupt notary who secretly changes whose signature gets treated as valid on legal documents, trust modification is when an attacker alters the trust relationships a system uses to decide what software, certificates, or identities are considered legitimate. Precisely, it refers to the unauthorized manipulation of trust stores, certificate authorities, Group Policy trust settings, or authentication configurations to make malicious entities appear trusted.

## Why it matters
During the 2011 DigiNotar breach, attackers compromised a Dutch Certificate Authority and issued fraudulent SSL certificates for Google.com — effectively modifying the global trust chain so that rogue servers were treated as legitimate. Browsers and operating systems trusted DigiNotar-signed certificates by default, meaning victims' encrypted traffic was intercepted without obvious warnings until DigiNotar was manually removed from trust stores worldwide.

## Key facts
- Attackers can add rogue root certificates to a Windows trust store via `certutil`, registry edits, or malicious Group Policy Objects (GPOs), making self-signed malware appear legitimately signed
- On Linux, dropping a fake CA cert into `/usr/local/share/ca-certificates/` and running `update-ca-certificates` silently expands the system's trusted roots
- Trust modification is a key technique in SSL/TLS interception (man-in-the-middle) attacks, especially in corporate proxy environments and nation-state surveillance
- MITRE ATT&CK maps this under **T1553.004 – Subvert Trust Controls: Install Root Certificate**
- Defense includes monitoring certificate store changes via EDR tooling, enforcing Certificate Transparency (CT) logs, and using HPKP or certificate pinning in critical applications

## Related concepts
[[Certificate Authority]] [[Man-in-the-Middle Attack]] [[Code Signing]] [[Group Policy Object]] [[MITRE ATT&CK]]