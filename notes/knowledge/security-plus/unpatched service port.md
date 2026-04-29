# unpatched service port

## What it is
Like a door with a known broken lock that the building manager forgot to fix — anyone who knows about it can walk right in. An unpatched service port is a network port running a vulnerable version of a service (e.g., FTP, SMB, RDP) where the software has a known CVE but the security update has not been applied, leaving the exploit path wide open.

## Why it matters
The 2017 WannaCry ransomware outbreak spread globally by targeting port 445 (SMB) on unpatched Windows systems vulnerable to EternalBlue (MS17-010). Organizations that had applied Microsoft's patch released two months earlier were unaffected, while over 200,000 machines across 150 countries were compromised — illustrating that exposure time on an unpatched port is directly proportional to blast radius.

## Key facts
- **Nessus, OpenVAS, and Qualys** are common vulnerability scanners that identify unpatched services by banner grabbing and version comparison against CVE databases.
- A service running on a port doesn't need to be internet-facing to be dangerous — lateral movement within a network exploits internal unpatched ports just as effectively.
- **CVSS scores** help prioritize patching; a CVSS 9.8 on a listening port should be treated as a fire drill, not a backlog item.
- Security+ and CySA+ exams frequently test the **vulnerability management lifecycle**: discover → prioritize → remediate → verify, where unpatched ports are the primary discovery target.
- Port scanning with **Nmap** combined with `-sV` (version detection) is the standard technique to identify which services may be running vulnerable software versions.

## Related concepts
[[vulnerability scanning]] [[CVE]] [[patch management]] [[attack surface]] [[banner grabbing]]