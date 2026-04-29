# LocalFolderExtractor

## What it is
Like a postal worker who quietly photocopies every letter passing through a mailroom, a LocalFolderExtractor is a tool or malware component designed to systematically enumerate, copy, and exfiltrate files from local directories on a compromised host. It typically walks a directory tree, applies filters (by extension, size, or age), and stages or transmits matching files to an attacker-controlled location.

## Why it matters
During the 2020 SolarWinds intrusion, threat actors used similar file-harvesting techniques to collect credentials and sensitive documents from compromised endpoints before exfiltrating them via encrypted channels to C2 infrastructure. A defender monitoring for bulk file reads, unusual staging directories (e.g., `%TEMP%` or `AppData`), and anomalous archive creation can detect this behavior before data leaves the network.

## Key facts
- **Staging pattern**: Extracted files are often compressed (`.zip`, `.7z`) and renamed with innocuous labels before exfiltration to evade DLP controls.
- **Common targets**: Browser credential stores, SSH keys (`~/.ssh/`), configuration files, and documents matching keywords like "password," "vpn," or "confidential."
- **Detection artifact**: Generates high-volume file read events visible in Windows Security Event Log (Event ID 4663) or EDR telemetry.
- **MITRE ATT&CK mapping**: Falls under **T1005 – Data from Local System**, a sub-technique of the Collection tactic.
- **Defense control**: Application whitelisting and file integrity monitoring (FIM) can flag unauthorized processes accessing sensitive directories.

## Related concepts
[[Data Exfiltration]] [[MITRE ATT&CK T1005]] [[File Integrity Monitoring]] [[Data Loss Prevention]] [[Credential Access]]