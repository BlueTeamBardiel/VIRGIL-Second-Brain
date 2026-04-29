# Weasis

## What it is
Think of Weasis like a specialized microscope for medical images — it's a free, open-source DICOM viewer that lets clinicians examine X-rays, MRIs, and CT scans directly in a web browser or desktop environment. Precisely, Weasis is a Java-based medical imaging platform commonly deployed in healthcare environments to render and annotate DICOM (Digital Imaging and Communications in Medicine) files.

## Why it matters
In 2021, vulnerabilities in DICOM-handling software like Weasis became a focal point for healthcare ransomware attackers, who recognized that imaging servers are often poorly segmented from clinical networks. A threat actor who compromises a Weasis deployment gains access to a treasure trove of PHI (Protected Health Information), creating both HIPAA breach liability and potential pivot points into hospital infrastructure. Defenders use network segmentation and DICOM protocol filtering at the firewall to limit exposure of these imaging systems.

## Key facts
- Weasis uses **Java Web Start (JNLP)** for browser-launched deployments, a technology with a historically poor security track record and deprecated in modern JDKs, creating legacy risk.
- DICOM files can embed **executable code or malicious payloads** within metadata fields, making DICOM viewers like Weasis a potential attack surface.
- Healthcare environments running Weasis must comply with **HIPAA Security Rule** requirements for access controls and audit logging on any system handling ePHI.
- Weasis commonly integrates with **PACS (Picture Archiving and Communication Systems)**, meaning a compromise can propagate laterally across the entire radiology infrastructure.
- Default DICOM port **104** is frequently left open and unauthenticated on internal networks, making Weasis-connected servers discoverable via Shodan.

## Related concepts
[[DICOM Protocol]] [[PACS Security]] [[PHI Data Protection]] [[Healthcare Network Segmentation]] [[Java Web Start Vulnerabilities]]