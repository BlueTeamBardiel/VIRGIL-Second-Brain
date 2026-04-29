# CWE-798 Hard-coded Credentials

## What it is
Imagine a hotel that uses the same master key for every room and prints that key's serial number directly in the employee handbook — anyone who finds the handbook owns the building. Hard-coded credentials are authentication secrets (passwords, API keys, cryptographic keys) embedded directly in source code or binaries, identical across every deployment and essentially impossible to rotate without a new release.

## Why it matters
In 2016, researchers scanning GitHub found thousands of AWS secret keys committed directly in public repositories — attackers harvested these to spin up crypto-mining infrastructure and rack up six-figure bills on victims' accounts within hours. The core danger is that decompiling a binary or browsing a public repo immediately exposes credentials that cannot be revoked without patching and redeploying every affected instance.

## Key facts
- Hard-coded credentials are classified under **CWE-798** and are a child of CWE-344 (Use of Invariant Value in Dynamically Changing Context)
- OWASP ranks them under **A07:2021 – Identification and Authentication Failures**
- Static analysis tools (Bandit, Semgrep, truffleHog) specifically scan for entropy patterns and known credential formats to detect them
- Mitigation requires **externalized secrets management** — tools like HashiCorp Vault, AWS Secrets Manager, or environment variables pulled at runtime
- Hard-coded credentials in IoT firmware are a primary attack vector; the Mirai botnet exploited factory-default hard-coded Telnet passwords across thousands of devices

## Related concepts
[[Insecure Default Credentials]] [[Secrets Management]] [[Static Application Security Testing (SAST)]] [[CWE-259 Hard-coded Password]] [[Principle of Least Privilege]]