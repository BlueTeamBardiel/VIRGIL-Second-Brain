# DICOM protocol

## What it is
Think of DICOM as the postal system for hospital imaging — every MRI scan, X-ray, and CT image gets wrapped in a standardized envelope with patient metadata, routing instructions, and content all bundled together. Formally, DICOM (Digital Imaging and Communications in Medicine) is a network protocol and file format standard used by medical devices to transmit, store, and retrieve medical imaging data. It runs typically over TCP port 104 (or 11112 for secure variants) and has been the healthcare imaging backbone since the 1990s.

## Why it matters
In 2019, researchers discovered over 590 million patient records exposed globally because DICOM servers were left internet-facing with no authentication — the protocol was designed for trusted internal networks and includes no built-in access control by default. An attacker could query an exposed DICOM server using free tools like `findscu` to pull complete patient records including names, birthdates, Social Security Numbers, and diagnostic images, representing a catastrophic HIPAA violation with zero exploitation complexity.

## Key facts
- DICOM uses a client-server model called **SCU/SCP** (Service Class User / Service Class Provider) — no credentials required in the base protocol
- Default port **104/TCP** is unencrypted; TLS-wrapped DICOM runs on **2762/TCP** but is rarely implemented in legacy environments
- DICOM files embed **patient PII directly in image metadata tags** (e.g., tag 0010,0010 = Patient Name), making every image a potential data breach
- A **C-FIND** command lets any connected host query patient records; **C-MOVE** retrieves full imaging datasets — both weaponizable without authentication
- Under HIPAA, medical images are PHI (Protected Health Information), so exposed DICOM servers trigger mandatory breach notification requirements

## Related concepts
[[HIPAA compliance]] [[medical device security]] [[unencrypted protocols]] [[network segmentation]] [[data exfiltration]]