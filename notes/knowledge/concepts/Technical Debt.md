# Technical Debt

## What it is
Like a homeowner who patches a leaky roof with duct tape every winter instead of replacing the shingles — it works until it catastrophically doesn't — technical debt is the accumulated cost of shortcuts, deferred patches, and "we'll fix it later" decisions in software or infrastructure. Precisely: it is the gap between what was implemented for speed and what should have been implemented for correctness, security, and maintainability.

## Why it matters
In 2017, Equifax breached 147 million records partly because a known Apache Struts vulnerability (CVE-2017-5638) went unpatched for months — the organization's tangled, poorly documented legacy systems made patching feel too risky to do quickly. That hesitation *was* technical debt cashing its check. Security teams inheriting old codebases must treat unpatched dependencies, hardcoded credentials, and missing input validation as measurable, exploitable liabilities — not just "cleanup items."

## Key facts
- Technical debt is explicitly tracked in risk frameworks like NIST SP 800-53 under **SA-15 (Development Process, Standards, and Tools)** and surfaces in software supply chain risk assessments
- **End-of-life (EOL) software** is the most dangerous form: no patches exist, so debt becomes permanent and unresolvable
- Static Application Security Testing (SAST) and Software Composition Analysis (SCA) tools quantify technical debt by surfacing known-vulnerable libraries and insecure code patterns
- CySA+ candidates should recognize that a **vulnerability scan showing high mean time to remediate (MTTR)** is a direct metric for accumulated technical debt
- Technical debt increases **attack surface** over time — each deferred fix is a potential pivot point for lateral movement or privilege escalation

## Related concepts
[[Attack Surface]] [[Vulnerability Management]] [[End-of-Life Software]] [[Software Supply Chain Security]] [[Mean Time to Remediate]]