# Content Scanning

## What it is
Like a postal inspector opening packages to check for contraband before delivery, content scanning inspects data payloads in transit or at rest to identify malicious, sensitive, or policy-violating material. It is the process of analyzing the content of files, emails, web traffic, or network streams against known signatures, patterns, or behavioral rules to detect threats before they reach their destination.

## Why it matters
In 2017, the NotPetya attack spread partially through organizations that lacked proper email content scanning — malicious attachments containing macro-enabled documents slipped through unexamined. A robust content scanning solution (like a secure email gateway inspecting attachments in a sandbox) would have flagged the document's embedded payload before execution, breaking the infection chain at the perimeter.

## Key facts
- **DLP (Data Loss Prevention)** relies heavily on content scanning to detect sensitive data patterns (SSNs, credit card numbers via regex) leaving the network
- Content scanning occurs at multiple layers: email gateways, web proxies, endpoint agents, and cloud access security brokers (CASBs)
- **MIME type inspection** catches attackers who rename `.exe` files as `.jpg` — scanning checks actual file headers (magic bytes), not just extensions
- Signature-based content scanning matches against known malware hashes or patterns; **heuristic/behavioral scanning** catches zero-days by analyzing code intent
- Many content scanning engines integrate with **threat intelligence feeds** to update detection rules in near real-time, reducing the window between discovery and detection

## Related concepts
[[Data Loss Prevention]] [[Secure Email Gateway]] [[Intrusion Detection System]] [[CASB]] [[Sandboxing]]