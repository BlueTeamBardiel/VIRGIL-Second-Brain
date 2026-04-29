# yara

## What it is
Think of YARA like a metal detector on a beach — you describe the shape and material of what you're hunting, and it tells you exactly where it's buried. YARA is a pattern-matching tool used by malware researchers to create rules that identify and classify malware samples based on textual or binary patterns within files. Rules can match on strings, byte sequences, file metadata, or logical combinations of these.

## Why it matters
During incident response after a ransomware outbreak, an analyst can write a YARA rule targeting the unique mutex name or hardcoded C2 URL embedded in the ransomware binary, then scan every endpoint across the network to find infected or staged machines before the payload detonates. This turns a reactive cleanup into a proactive hunt, compressing attacker dwell time significantly.

## Key facts
- YARA rules consist of three sections: **meta** (descriptive info), **strings** (the patterns to match — hex, text, or regex), and **condition** (the logical Boolean trigger)
- Rules can match on **any file type** — executables, PDFs, Office documents, memory dumps, or raw network captures
- YARA is natively integrated into tools like **VirusTotal, Cuckoo Sandbox, and Velociraptor**, making it a universal malware triage language
- The **condition block** supports operators like `all of`, `any of`, `filesize`, and `at` — allowing precise, low-false-positive detections
- CySA+ expects you to recognize YARA as a **threat intelligence operationalization tool** — turning IOCs into actionable automated detection signatures

## Related concepts
[[Threat Intelligence]] [[Indicators of Compromise]] [[Malware Analysis]] [[SIEM]] [[Incident Response]]