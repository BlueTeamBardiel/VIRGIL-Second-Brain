# RegExp

## What it is
Like a bloodhound trained to sniff out a very specific scent in a crowded room, a Regular Expression (RegExp) is a sequence of characters that defines a search pattern used to match, find, or manipulate strings of text. It is a formal pattern-matching language supported by virtually every programming language and security tool, enabling precise identification of structured data like IP addresses, email addresses, or malicious payloads within large datasets.

## Why it matters
In a SIEM environment, analysts write RegExp rules to detect SQL injection attempts in HTTP logs — for example, the pattern `(?i)(union|select|drop|insert)\s` flags suspicious keyword sequences regardless of letter casing. Attackers exploit this same mechanism through **ReDoS (Regular Expression Denial of Service)**, where a crafted input causes a poorly written RegExp to backtrack catastrophically, consuming 100% CPU and taking a web application offline without a single packet of a traditional attack.

## Key facts
- **ReDoS** is a CWE-1333 vulnerability caused by "evil regexes" with nested quantifiers (e.g., `(a+)+`) that exhibit exponential backtracking on adversarial input
- RegExp is used in IDS/IPS signature rules (Snort/Suricata) to match specific byte patterns or protocol anomalies in network traffic
- OWASP lists improper RegExp validation as a contributor to injection vulnerabilities — overly permissive patterns allow malicious characters to bypass input validation
- Many WAF bypass techniques exploit RegExp engine inconsistencies, using Unicode, null bytes, or encoding tricks to evade pattern matching
- In threat hunting, analysts use RegExp within tools like Splunk (`rex` command) or grep to extract IOCs from raw log data at scale

## Related concepts
[[Input Validation]] [[SIEM]] [[Denial of Service]] [[Injection Attacks]] [[Intrusion Detection System]]