# lateral movement

## What it is
Like a burglar who breaks in through a basement window but then quietly moves room to room looking for the safe — lateral movement is what attackers do *after* initial access, traversing the network to reach higher-value targets. It is the set of techniques an adversary uses to progressively gain access to additional systems, credentials, and resources within a compromised environment without triggering alarms.

## Why it matters
In the 2020 SolarWinds supply chain attack, adversaries used lateral movement extensively after their initial foothold — leveraging stolen SAML tokens to pivot from on-premises systems into Azure cloud environments. Defenders who implemented network segmentation and monitored for abnormal service account behavior were better positioned to detect and contain the spread before critical assets were reached.

## Key facts
- **Common techniques include:** Pass-the-Hash (PTH), Pass-the-Ticket (Kerberos ticket reuse), RDP hijacking, and use of legitimate admin tools like PsExec or WMI — making it blend with normal traffic
- **MITRE ATT&CK Tactic TA0008** explicitly categorizes lateral movement as a distinct phase with sub-techniques including Remote Services, Exploitation of Remote Services, and Internal Spearphishing
- **Detection signal:** Unusual authentication patterns — such as a workstation authenticating to many other workstations — are a primary behavioral indicator (east-west traffic anomalies)
- **Privileged credentials are the fuel:** Attackers rely on credential dumping (e.g., Mimikatz against LSASS) to acquire hashes or tickets needed to authenticate laterally
- **Defense countermeasures:** Network segmentation, least privilege, disabling NTLM where possible, enabling Credential Guard, and deploying a SIEM to baseline normal authentication behavior

## Related concepts
[[Pass-the-Hash]] [[privilege escalation]] [[network segmentation]] [[credential dumping]] [[MITRE ATT&CK]]