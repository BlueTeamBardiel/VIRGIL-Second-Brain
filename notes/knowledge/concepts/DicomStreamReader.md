# DicomStreamReader

## What it is
Like a postal clerk who opens medical envelopes one piece at a time without needing the whole package first, DicomStreamReader is a streaming parser for DICOM (Digital Imaging and Communications in Medicine) files that processes medical imaging data incrementally as bytes arrive, rather than loading the entire file into memory. It is a software component found in DICOM libraries (such as fo-dicom or dcm4che) that reads tag-value pairs sequentially from a byte stream, enabling efficient handling of large radiological files like CT scans and MRIs.

## Why it matters
Attackers have exploited malformed DICOM streams to trigger buffer overflows and heap corruption in hospital imaging software — the 2019 discovery that DICOM files could embed executable PE headers (1,280 bytes of executable code before the valid DICOM preamble) demonstrated how stream parsers can be weaponized to deliver malware disguised as medical images. A vulnerable DicomStreamReader that fails to validate tag lengths or sequence boundaries becomes an entry point into critical healthcare infrastructure.

## Key facts
- DICOM files begin with a 128-byte preamble followed by the magic bytes `DICM` — a parser that skips preamble validation can be fed malicious pre-preamble payloads
- Improper handling of undefined-length sequences (VR = SQ with length `0xFFFFFFFF`) can cause infinite loops or memory exhaustion (DoS)
- CVE-class vulnerabilities in DICOM parsers frequently involve integer overflow when reading `uint32` tag lengths from untrusted streams
- Healthcare environments are governed by HIPAA; a compromised DICOM stream reader can expose PHI (Protected Health Information), triggering breach notification requirements
- Fuzzing DICOM stream readers is a recognized research technique; tools like Boofuzz have been used to discover parser vulnerabilities in radiology workstations

## Related concepts
[[Medical Device Security]] [[File Format Vulnerabilities]] [[Buffer Overflow]] [[Healthcare Data Breach]] [[Fuzzing]]