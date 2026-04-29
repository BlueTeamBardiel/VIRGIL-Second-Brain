# XI. Containment, Eradication, and Recovery

## What it is
Like a surgeon isolating a gangrenous limb before removing it and rehabilitating the patient, containment, eradication, and recovery is the structured middle phase of incident response where you stop the bleeding, cut out the infection, and restore normal operations. It follows detection and analysis, transforming reactive triage into deliberate remediation. These three steps are distinct and sequential — skipping containment before eradication is how attackers maintain persistence through overlooked footholds.

## Why it matters
During the 2017 NotPetya outbreak, organizations that immediately reimaged infected machines without first isolating them from the network allowed the worm to reinfect clean systems within minutes via SMB lateral movement. Proper containment — network segmentation, disabling affected VLANs — had to precede eradication. Recovery then required restoring from offline, verified backups because online backups were also encrypted.

## Key facts
- **Containment strategies** split into short-term (immediate isolation — pulling a NIC, blocking firewall rules) and long-term (applying patches, hardening configurations while maintaining forensic integrity)
- **Eradication** involves removing malware artifacts, closing exploited vulnerabilities, and deleting attacker-created accounts — validated through IOC sweeps across all potentially affected systems
- **Recovery** requires restoring from known-good backups, confirming system integrity via hash verification, and monitoring for re-compromise before declaring the incident closed
- **Segmentation** is the primary containment tool — isolating affected subnets, endpoints, or cloud instances prevents lateral spread without full shutdown
- On the **CySA+ exam**, recovery includes validating that patches are applied, monitoring is enhanced post-incident, and lessons-learned documentation feeds back into detection playbooks

## Related concepts
[[Incident Response Lifecycle]] [[Network Segmentation]] [[Indicators of Compromise]] [[Backup and Recovery Strategies]] [[Forensic Preservation]]