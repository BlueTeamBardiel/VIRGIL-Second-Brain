# App::UnPack

## What it is
Like a customs officer who opens every shipping container to inspect the contents regardless of what the label says, App::UnPack is a Perl module that extracts and unpacks data from binary or packed structures. Specifically, it provides a higher-level interface around Perl's built-in `unpack()` function, allowing analysts to parse binary file formats, network packets, or serialized data streams by declaratively defining expected data layouts.

## Why it matters
Malware analysts frequently encounter packed or obfuscated binaries where shellcode or configuration data is hidden inside structured binary blobs. Using a tool like App::UnPack, a defender can script the extraction of embedded payloads from a suspicious binary — for example, pulling a hardcoded C2 IP address out of a custom-packed PE file header — without manually reversing the entire packing routine. This accelerates triage during incident response when time is critical.

## Key facts
- App::UnPack wraps Perl's `unpack()` template system, which uses format strings (e.g., `N` for unsigned 32-bit big-endian, `A` for ASCII string) to parse binary data positionally
- It is commonly used in DFIR (Digital Forensics and Incident Response) scripting pipelines to automate parsing of proprietary binary formats
- Misuse or incorrect template strings can cause out-of-bounds reads in the parsing script itself — a reminder that even defensive tools carry implementation risk
- Because it operates on raw bytes, it is format-agnostic: usable against network captures, registry hive blobs, firmware images, or executable sections
- Understanding binary unpacking is foundational to recognizing how packers like UPX obscure malware from signature-based AV detection

## Related concepts
[[Binary Analysis]] [[Malware Packing and Obfuscation]] [[DFIR Scripting]] [[PE File Format]] [[Reverse Engineering]]