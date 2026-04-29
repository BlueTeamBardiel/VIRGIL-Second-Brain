# Tripwire

## What it is
Like a fishing line stretched across a forest path that rings a bell when disturbed, Tripwire is a file integrity monitoring (FIM) tool that detects unauthorized changes to files and directories by comparing their current cryptographic hashes against a trusted baseline. Any modification, deletion, or addition triggers an alert — even changes a single byte wide.

## Why it matters
After attackers compromise a Linux web server, they often plant a backdoor by modifying `/etc/passwd` or replacing a system binary like `ls` with a Trojanized version. A properly configured Tripwire deployment would immediately flag the altered hash of that binary, exposing the attacker's persistence mechanism before they can leverage it further.

## Key facts
- Tripwire generates a **baseline database** of hash values (SHA-256, MD5) for specified files at install time — this baseline must be stored securely, offline if possible, to prevent tampering.
- It operates in **policy mode**: administrators define which files to monitor and what changes (permissions, size, timestamp, hash) constitute a violation.
- Tripwire is a core example of a **host-based intrusion detection system (HIDS)**, relevant to both Security+ and CySA+ exams.
- The tool distinguishes between **integrity checking** (has this file changed?) and **intrusion detection** (why did it change?) — it answers the first, and analysts answer the second.
- On Security+, Tripwire appears under the category of **configuration and change management controls** and FIM tools, alongside alternatives like AIDE (Advanced Intrusion Detection Environment) and OSSEC.

## Related concepts
[[File Integrity Monitoring]] [[Host-Based Intrusion Detection System]] [[Baseline Configuration]] [[Hashing]] [[Change Management]]