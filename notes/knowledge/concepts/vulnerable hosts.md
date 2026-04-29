# vulnerable hosts

## What it is
Like a house with a broken lock, cracked windows, and no alarm system — a vulnerable host is any networked device that contains unpatched software, misconfigured services, or weak credentials that an attacker can exploit. Precisely: a vulnerable host is an endpoint (workstation, server, IoT device) with one or more exploitable weaknesses that could be leveraged to gain unauthorized access, escalate privileges, or pivot deeper into a network.

## Why it matters
During the 2017 WannaCry ransomware outbreak, hundreds of thousands of Windows hosts running unpatched SMBv1 became attack vectors — infected machines spread the worm laterally without any user interaction. Organizations that had applied MS17-010 (the EternalBlue patch) were immune, demonstrating that timely patching directly determines whether a host becomes a liability or a hardened asset.

## Key facts
- Vulnerability scanners (Nessus, OpenVAS, Qualys) assign CVSS scores to findings on hosts; a CVSS score ≥ 7.0 is considered High severity and typically requires urgent remediation
- A host can be vulnerable even when fully patched if it is *misconfigured* — e.g., running an unnecessary service like Telnet or using default credentials
- Legacy/end-of-life operating systems (Windows XP, Server 2003) are permanently vulnerable hosts because no patches will ever be released for new CVEs
- Attack surface on a host is reduced through hardening: disabling unused ports/services, applying CIS benchmarks, and enforcing least privilege
- In threat hunting and incident response, identifying the **patient zero** host — the first vulnerable machine exploited — is critical for scoping a breach

## Related concepts
[[attack surface]] [[patch management]] [[vulnerability scanning]] [[CVE]] [[network hardening]]