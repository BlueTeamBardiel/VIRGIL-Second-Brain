# SCAP

## What it is
Think of SCAP as a universal electrical outlet standard — instead of every country having incompatible plugs, SCAP gives security tools a common "socket" so they can all speak the same language about vulnerabilities, configurations, and compliance. Formally, the Security Content Automation Protocol (SCAP) is a NIST-defined framework of open standards that automates the verification of system configurations and vulnerability management across different tools and platforms.

## Why it matters
When a federal agency needs to prove its 10,000 Windows workstations comply with DISA STIGs before an audit, manually checking each machine is impossible. SCAP-enabled scanners like OpenSCAP or SCAP Workbench can ingest standardized XCCDF checklists and automatically assess every endpoint, generating audit-ready reports — turning a months-long manual process into an overnight automated sweep.

## Key facts
- SCAP bundles six core component standards: **CVE** (vulnerability naming), **CCE** (configuration naming), **CPE** (platform naming), **CVSS** (vulnerability scoring), **XCCDF** (checklist language), and **OVAL** (assessment language)
- SCAP is maintained by **NIST** and is mandatory for federal agencies under **FISMA** compliance requirements
- **XCCDF** (Extensible Configuration Checklist Description Format) is the human-readable benchmark language; **OVAL** is the machine-executable test logic underneath it
- SCAP content (benchmarks) is published by organizations like **CIS** (Center for Internet Security) and **DISA** as ready-to-use compliance packages
- SCAP version 1.3 is the current validated standard; tools must pass NIST validation testing to be called "SCAP-validated"

## Related concepts
[[CVE]] [[CVSS]] [[Vulnerability Scanning]] [[STIG]] [[FISMA]] [[Configuration Management]]