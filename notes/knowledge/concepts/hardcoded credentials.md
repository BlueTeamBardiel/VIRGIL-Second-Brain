# hardcoded credentials

## What it is
Imagine a master key to a building that's permanently welded into the lock — you can't swap it out, and anyone who finds a copy owns every door forever. Hardcoded credentials are usernames, passwords, API keys, or cryptographic secrets embedded directly in source code or firmware, rather than loaded from a secure external configuration at runtime. They cannot be changed without recompiling or re-flashing the software itself.

## Why it matters
In 2016, researchers discovered that Fortinet's FortiOS SSH daemon contained a hardcoded backdoor password ("FGTAbc11*xy+Qqz27") allowing root access to any affected firewall — attackers with this single string could silently own enterprise network perimeters worldwide. Defenders respond by scanning source code repositories with tools like truffleHog or GitHub's secret scanning to detect committed credentials before they reach production.

## Key facts
- Hardcoded credentials violate the principle of **least privilege** and **separation of secrets from code**, a core secure coding requirement in OWASP and NIST guidelines
- They are catalogued under **CWE-798** (Use of Hard-coded Credentials) and frequently appear in IoT firmware, making mass-exploitation trivial
- Default/hardcoded credentials in commercial products are explicitly flagged by **CVE** entries and are a primary IoT attack vector (Mirai botnet exploited default creds at massive scale)
- **Static application security testing (SAST)** tools are the primary automated countermeasure for detecting them during the SDLC
- Remediation requires rotating to **secrets management solutions** (e.g., HashiCorp Vault, AWS Secrets Manager) and environment variables rather than in-code literals

## Related concepts
[[default credentials]] [[secrets management]] [[static code analysis]] [[CWE/CVE]] [[supply chain attacks]]