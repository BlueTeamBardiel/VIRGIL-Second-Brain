# Orthanc

## What it is
Think of Orthanc as a Swiss Army knife for medical imaging — a lightweight, open-source DICOM server that lets hospitals store, retrieve, and share patient scan data (X-rays, MRIs, CT scans) over a network. Precisely, Orthanc is a self-contained REST API-driven PACS (Picture Archiving and Communication System) server that speaks the DICOM protocol and can be embedded in clinical or research environments with minimal setup.

## Why it matters
Orthanc instances exposed to the internet without authentication have been discovered by attackers using Shodan, allowing unauthenticated access to thousands of real patient medical images — a direct HIPAA violation with serious legal and reputational consequences. Defenders must treat Orthanc like any sensitive internal service: firewall it from public exposure, enforce authentication plugins, and audit REST API access logs for unauthorized enumeration of patient studies.

## Key facts
- Orthanc exposes a **REST API on port 8042** by default; unauthenticated access is enabled out of the box in older versions, meaning zero credentials are needed to pull patient data
- Communicates via **DICOM protocol on port 104** (standard) — the same legacy protocol notorious for weak or absent authentication
- Supports **plugins** (e.g., PostgreSQL backend, viewer plugins), expanding attack surface if plugins are unpatched or misconfigured
- Shodan queries like `"Orthanc"` or `"DICOM"` routinely surface hundreds of publicly exposed instances globally — a favorite target in healthcare-focused threat actor campaigns
- Falls under **HIPAA Security Rule** requirements — failure to secure PHI in DICOM format can result in fines up to $1.9 million per violation category per year

## Related concepts
[[DICOM Protocol]] [[PACS Security]] [[Healthcare Data Breach]] [[Shodan Reconnaissance]] [[REST API Security]]