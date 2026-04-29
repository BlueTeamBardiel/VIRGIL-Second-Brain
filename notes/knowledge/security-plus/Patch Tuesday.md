# Patch Tuesday

## What it is
Like a scheduled garbage truck that comes every second Tuesday to haul away rotting vulnerabilities before they attract pests, Patch Tuesday is Microsoft's monthly release cycle for security updates. Formalized in 2003, it is the second Tuesday of each month when Microsoft (and Adobe, historically) batch-releases security patches for Windows, Office, and related products.

## Why it matters
Attackers actively reverse-engineer patches released on Patch Tuesday to identify the underlying vulnerability — a technique called "patch diffing" — then race to weaponize exploits before organizations can deploy the fix. This created the coined threat known as **Exploit Wednesday**, where CVEs with working exploits can appear within 24–72 hours of patch release, meaning slow-patching organizations hand adversaries a predictable attack window every single month.

## Key facts
- Patch Tuesday occurs on the **second Tuesday of each month**; Microsoft introduced this cadence in October 2003 to reduce update fatigue.
- **Emergency out-of-band patches** are released outside this cycle for critical zero-days (e.g., PrintNightmare in 2021 received an out-of-band fix).
- CVSS scores and **Microsoft's own Exploitability Index** (Exploitation More Likely / Less Likely) help administrators prioritize which patches to deploy first.
- The **WSUS (Windows Server Update Services)** tool allows enterprise administrators to control and stage Patch Tuesday deployments across managed endpoints.
- CySA+ expects candidates to understand **vulnerability management cycles** — Patch Tuesday feeds directly into scanning, prioritization, and remediation SLA workflows.

## Related concepts
[[Vulnerability Management]] [[CVE]] [[Zero-Day Exploit]] [[CVSS Scoring]] [[Windows Server Update Services]]