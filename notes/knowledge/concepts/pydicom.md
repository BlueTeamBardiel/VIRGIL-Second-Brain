# pydicom

## What it is
Think of pydicom as a universal translator for hospital imaging machines — it reads the secret language that MRI scanners, CT machines, and X-ray systems use to store patient data. Precisely, pydicom is an open-source Python library for parsing, modifying, and creating DICOM (Digital Imaging and Communications in Medicine) files, the standard format for medical imaging data. It exposes every tag, pixel array, and embedded patient metadata field programmatically.

## Why it matters
Medical imaging systems are a high-value attack surface because DICOM files embed patient PII (name, DOB, SSN, physician notes) directly in file headers alongside the image data — not encrypted, often transmitted in cleartext over hospital networks. Researchers have demonstrated that pydicom can be used to silently modify tumor visibility in CT scans, injecting or removing nodules without altering file hashes if metadata timestamps are also manipulated. Defenders use it forensically to audit whether DICOM archives have been tampered with or to build pipelines that strip PHI before sharing imaging data externally.

## Key facts
- DICOM files contain hundreds of metadata **tags** (e.g., `PatientName`, `PatientID`) stored in plaintext; pydicom exposes all of them with a single `dcmread()` call
- Legacy DICOM transmission uses **port 104** over unencrypted TCP (DICOM Standard); TLS-wrapped DICOM runs on **port 2762**
- Unauthorized modification of DICOM files to alter diagnostic outcomes qualifies as **healthcare fraud** under HIPAA and potentially criminal tampering
- pydicom is routinely used in **PHI data exfiltration** scenarios because it can batch-extract patient records from PACS (Picture Archiving and Communication Systems)
- DICOM pixel data can be used as a **steganographic carrier** — attackers have hidden malware inside the pixel arrays of valid DICOM files to evade AV detection

## Related concepts
[[HIPAA]] [[PHI Data Protection]] [[Medical Device Security]] [[Steganography]] [[Data Exfiltration]]