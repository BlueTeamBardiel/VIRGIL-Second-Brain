# Integrity Checkers

## What it is
Like a wax seal on a medieval letter — if the seal is broken or looks different, you know someone tampered with the contents — an integrity checker creates a cryptographic baseline snapshot of files, directories, or system objects and alerts when anything deviates from that baseline. These tools use hashing algorithms (MD5, SHA-256) or digital signatures to detect unauthorized modifications to critical system files, configurations, or executables.

## Why it matters
During the 2020 SolarWinds supply chain attack, malicious code was inserted into legitimate software update packages. A robust integrity checker monitoring the build pipeline and distributed binaries could have flagged hash mismatches between expected and actual file signatures, potentially catching the trojanized DLL before mass deployment. This is why integrity checking is considered a core detective control in secure software development and endpoint defense.

## Key facts
- **Tripwire** is the classic host-based integrity checker; it creates a database of file hashes and metadata (permissions, timestamps, ownership) and alerts on any change.
- Integrity checkers operate as **detective controls**, not preventive — they identify that tampering occurred but don't stop it in real time.
- The **baseline** must be created from a known-good, clean system state; a compromised baseline renders the tool useless.
- File Integrity Monitoring (FIM) is **explicitly required** by PCI-DSS (Requirement 11.5) for cardholder data environments.
- Integrity checkers can detect **rootkit activity** when rootkits modify system binaries (e.g., `/bin/ls`, `/bin/ps`) to hide their presence.

## Related concepts
[[File Integrity Monitoring]] [[Hashing]] [[Host-Based Intrusion Detection System (HIDS)]] [[Rootkits]] [[Baseline Configuration]]