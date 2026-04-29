# Philips PMSCT_RLE1

## What it is
Like a master key hidden inside a hospital's maintenance closet that staff forgot existed, PMSCT_RLE1 is a hardcoded credential (default username/password combination) embedded in Philips' Patient Monitoring System Communication software. It is a factory-set authentication bypass that grants privileged access to clinical network components without requiring legitimate credential issuance.

## Why it matters
In a hospital environment, an attacker on the clinical network segment could use PMSCT_RLE1 credentials to authenticate directly to Philips patient monitoring infrastructure, potentially altering alarm thresholds, disrupting telemetry feeds, or pivoting deeper into biomedical device networks. This is precisely the threat model that ICS-CERT Advisory ICSMA-15-246-01 warned about, classifying it as a critical vulnerability in healthcare operational technology.

## Key facts
- **CVE-2015-3938** documents this hardcoded credential vulnerability in Philips Patient Monitoring System Communication components
- Classified under **CWE-798** (Use of Hard-coded Credentials), a recurring weakness in embedded/OT medical devices
- CVSS v2 score was rated **10.0 (Critical)** — the maximum — due to network accessibility and no authentication requirement
- Affects devices operating on **clinical LAN segments**, making network segmentation the primary compensating control when patching is delayed
- Remediation required a **vendor-issued firmware/software patch**; interim mitigation relied on firewall rules isolating affected systems from general hospital networks

## Related concepts
[[Hardcoded Credentials]] [[CWE-798]] [[Medical Device Security]] [[ICS-CERT Advisory]] [[Network Segmentation]]