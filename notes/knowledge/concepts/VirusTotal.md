# VirusTotal

## What it is
Think of it as sending a suspicious package to 70+ forensic labs simultaneously and getting all their reports back in seconds. VirusTotal is a free online service owned by Google (Alphabet) that aggregates results from multiple antivirus engines, sandboxes, and threat intelligence tools to analyze files, URLs, domains, and IP addresses for malicious content.

## Why it matters
During incident response, an analyst discovers a suspicious executable on a compromised workstation. Rather than waiting for a single AV vendor's verdict, they submit the file hash to VirusTotal and immediately see that 43 out of 72 engines flag it as a known ransomware dropper — confirming the infection without executing the malware again. Conversely, attackers routinely test their malware samples against VirusTotal before deployment to verify they achieve low detection rates.

## Key facts
- Supports analysis via **file hash lookup** (MD5, SHA-1, SHA-256) so analysts can check reputation without uploading the actual file — critical for sensitive or proprietary data
- Files submitted publicly are **shared with all paying AV vendors**, meaning uploading confidential documents could expose them to third parties
- Provides **behavioral analysis** through integrated sandboxes that detonate files in isolated environments and report network connections, registry changes, and dropped files
- A **"0/72" result does not equal safe** — newly crafted or polymorphic malware routinely evades all engines initially (false negative risk)
- VirusTotal Intelligence (paid tier) enables **retrohunting** — searching historical submissions using YARA rules to find related malware families

## Related concepts
[[Indicator of Compromise]] [[Hash Functions]] [[Sandbox Analysis]] [[Threat Intelligence]] [[YARA Rules]]