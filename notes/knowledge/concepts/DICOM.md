# DICOM

## What it is
Think of DICOM as the universal electrical outlet standard for medical imaging — if every country used different plugs, MRI machines couldn't share images with radiologists across hospitals. DICOM (Digital Imaging and Communications in Medicine) is a network protocol and file format standard that governs how medical imaging devices (MRI, CT, X-ray) store, transmit, and display patient image data. It operates primarily over TCP, typically on port 104, and bundles image data together with patient metadata in a single file.

## Why it matters
In 2019, a ProPublica investigation found over 600 medical servers exposing 24 million patient imaging records globally via unprotected DICOM servers — no authentication required, directly browsable from the public internet. An attacker could not only view sensitive PHI embedded in DICOM metadata but also potentially inject malicious executables, since some DICOM files have been shown to contain embedded PE (Windows executable) payloads that antivirus tools may miss because they scan for known extensions, not DICOM's `.dcm` format.

## Key facts
- DICOM uses port **104 (unencrypted)** and port **2762 (TLS-secured)** — many deployments skip TLS entirely
- Every DICOM file embeds **PHI metadata tags** (patient name, DOB, SSN) alongside image pixels — exposure violates HIPAA
- The standard predates modern security design; it has **no built-in authentication** in its base specification
- DICOM files can contain **embedded executables** (PE32 headers), making them a malware smuggling vector that bypasses extension-based AV
- Covered under **HIPAA's Technical Safeguards** — improper DICOM exposure constitutes a reportable breach

## Related concepts
[[PHI Data Protection]] [[Healthcare Security]] [[Port Scanning]] [[Unencrypted Protocols]] [[Malware Obfuscation]]