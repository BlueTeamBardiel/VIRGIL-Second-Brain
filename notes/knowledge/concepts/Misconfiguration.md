# misconfiguration

## What it is
Like a bank vault left unlocked because the manager assumed someone else set the combination, a misconfiguration is a security weakness born from incorrect or incomplete system settings rather than flawed code. Precisely: a misconfiguration occurs when a system, service, or application is deployed with insecure default or improper settings that expose it to attack. Unlike vulnerabilities requiring a software patch, misconfigurations are fixed through proper hardening and configuration management.

## Why it matters
In 2017, an AWS S3 bucket misconfiguration exposed 198 million American voter records — the bucket was set to public read access when it should have been private. An attacker needed zero exploit code; they simply browsed to the URL. This is why CIS Benchmarks and STIG guides exist: to define the *correct* configuration state before deployment, not after a breach.

## Key facts
- **OWASP Top 10 (2021)** ranks Security Misconfiguration as #5, appearing in ~90% of applications tested
- Common examples include: default credentials left unchanged, unnecessary services enabled, verbose error messages exposing stack traces, and open cloud storage buckets
- **Least privilege violations** are a subset of misconfiguration — over-permissioned accounts and roles are configurations, not code bugs
- Security Content Automation Protocol (**SCAP**) and tools like OpenSCAP, Nessus, or CIS-CAT can automatically audit systems against secure baseline configurations
- Cloud environments are especially prone because **shared responsibility model** confusion leads organizations to assume the provider secured settings that are actually the customer's responsibility

## Related concepts
[[hardening]] [[attack surface]] [[vulnerability scanning]] [[principle of least privilege]] [[baseline configuration]]