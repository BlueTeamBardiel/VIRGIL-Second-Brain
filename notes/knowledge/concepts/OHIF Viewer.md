# OHIF Viewer

## What it is
Think of it as a web-based "Google Maps" for medical imaging — instead of navigating geography, clinicians navigate DICOM files (MRIs, CT scans, X-rays) directly in a browser. The Open Health Imaging Foundation (OHIF) Viewer is an open-source, JavaScript-based medical image viewer that connects to DICOM-compliant servers (like Orthanc or DCM4CHEE) via DICOMweb APIs. It requires no desktop installation, making it deployable in hospital portals and research environments at scale.

## Why it matters
In 2019, security researchers discovered that millions of DICOM medical images were exposed on unprotected PACS servers — OHIF Viewer deployments misconfigured without authentication allowed anyone with the URL to browse sensitive patient imaging data directly in a browser. An attacker performing passive reconnaissance could enumerate patient studies, download PHI-laden DICOM files, and violate HIPAA without exploiting a single vulnerability — just unauthenticated HTTP GET requests to DICOMweb endpoints.

## Key facts
- OHIF Viewer communicates with backends using **DICOMweb REST APIs** (WADO-RS, STOW-RS, QIDO-RS) — each endpoint can expose PHI if not access-controlled
- It is a **frontend-only application** — security entirely depends on the backend DICOM server's authentication and authorization implementation
- Common misconfiguration: deploying OHIF pointing to a **publicly accessible Orthanc instance** with default credentials or no auth enabled
- DICOM files embed extensive metadata (patient name, DOB, physician notes) — exposure constitutes a **HIPAA breach** regardless of image sensitivity
- OHIF supports **OAuth 2.0 / OIDC integration**, but it must be explicitly configured — it is NOT enabled by default

## Related concepts
[[DICOM Protocol]] [[PHI Exposure]] [[Unauthenticated API Endpoints]] [[HIPAA Security Rule]] [[Medical Device Security]]