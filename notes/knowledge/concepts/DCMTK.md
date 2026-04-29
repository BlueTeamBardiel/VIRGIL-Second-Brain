# DCMTK

## What it is
Think of it as a Swiss Army knife that happens to speak the language of hospital scanners — DCMTK (DICOM Toolkit) is an open-source collection of libraries and utilities that implement the DICOM standard, the protocol used to store and transmit medical imaging data (MRI, CT, X-ray). It allows developers, researchers, and attackers alike to send, receive, query, and manipulate DICOM files and network services.

## Why it matters
Attackers have used DCMTK as a reconnaissance and exploitation tool against unprotected DICOM servers exposed to the internet. Because many DICOM implementations lack authentication by default, an attacker can use DCMTK's `findscu` utility to query a hospital's Picture Archiving and Communication System (PACS) and enumerate patient records, or use `storescu` to push malicious files — all without credentials. Researchers have demonstrated full patient data exfiltration from misconfigured PACS servers using nothing but DCMTK commands.

## Key facts
- DCMTK implements DICOM network services including C-FIND, C-STORE, C-MOVE, and C-ECHO — each queryable with built-in command-line tools
- DICOM servers traditionally operate on **TCP port 104** (or 11112 for TLS-wrapped DICOM)
- DCMTK can be weaponized for **patient data enumeration** without authentication due to legacy DICOM's reliance on Application Entity (AE) titles rather than passwords
- CVE-2019-1010228 is a known buffer overflow vulnerability discovered in DCMTK itself, demonstrating that the toolkit is also an attack surface
- HIPAA violations can result from exposed DICOM servers — making DCMTK-based pentesting a legitimate healthcare security assessment technique

## Related concepts
[[DICOM Protocol]] [[PACS Security]] [[Medical Device Security]] [[Unauthenticated Network Services]] [[Healthcare Data Breaches]]