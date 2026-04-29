# GDCM

## What it is
Like a master key that unlocks filing cabinets stuffed with X-rays and MRI scans, GDCM (Grassroots DICOM Library) is an open-source C++ library used to read, write, and manipulate DICOM files — the standard format for storing and transmitting medical imaging data in healthcare environments.

## Why it matters
In 2019, researchers demonstrated that DICOM files could be weaponized to embed executable code inside the 128-byte preamble of a file while remaining a valid medical image — a technique dubbed "DICOM malware." An attacker with access to a PACS (Picture Archiving and Communication System) could push a maliciously crafted DICOM file that exploits vulnerable GDCM parsing, potentially executing code on radiologist workstations or medical devices across an entire hospital network.

## Key facts
- DICOM files have a 128-byte preamble that is technically unused by the standard — attackers can embed PE executables (Windows .exe files) here while keeping the file medically valid
- GDCM is commonly deployed in PACS servers, DICOM viewers, and medical IoT devices, making vulnerabilities in the library high-impact across healthcare infrastructure
- CVE-2019-11687 is a notable GDCM vulnerability involving improper handling of certain DICOM files, enabling denial-of-service or potential code execution
- Healthcare systems running unpatched GDCM are relevant under HIPAA risk analysis requirements — exploitation could constitute a reportable breach of ePHI
- GDCM-related attacks fall under the broader category of file format vulnerabilities and are relevant to CySA+ topics covering vulnerability management in specialized/embedded environments

## Related concepts
[[DICOM Protocol]] [[PACS Security]] [[File Format Vulnerabilities]] [[Medical Device Security]] [[CVE Exploitation]]