# Quarantine

## What it is
Like a hospital isolation ward that keeps a contagious patient alive but behind sealed doors, quarantine moves a suspicious file to a restricted, encrypted container where it cannot execute, write, or communicate — but is preserved for analysis. It is a reversible containment action taken by antivirus or EDR tools when a file is flagged as potentially malicious, separating it from the live environment without permanently deleting it.

## Why it matters
During a ransomware investigation, a SOC analyst discovers that an endpoint's AV quarantined a PowerShell script 48 hours before encryption began — but the script itself was never deleted. Forensic teams can retrieve that quarantined artifact, extract its IOCs, and reconstruct the attacker's initial access vector. Without quarantine (if the AV had simply deleted the file), that evidence chain would be permanently destroyed.

## Key facts
- Quarantined files are typically encrypted and stored in a protected folder (e.g., `C:\ProgramData\<AV vendor>\Quarantine`) to prevent self-execution or recovery by malware.
- Quarantine is **reversible**; deletion is not — this distinction matters when a legitimate file is a false positive and needs restoration.
- On Security+/CySA+, quarantine is classified as a **containment** action within the incident response lifecycle (NIST SP 800-61).
- Endpoint Detection and Response (EDR) platforms can quarantine an entire **host** from the network, not just individual files — this is called network isolation or host quarantine.
- Quarantine logs serve as forensic evidence; retention policies must account for them during legal holds and e-discovery obligations.

## Related concepts
[[Antivirus]] [[Incident Response]] [[Endpoint Detection and Response (EDR)]] [[False Positive]] [[Containment]]