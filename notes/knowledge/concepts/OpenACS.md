# OpenACS

## What it is
Think of it like a Swiss Army knife web framework from the early 2000s that shipped with the blade already unfolded — powerful but dangerously exposed by default. OpenACS (Open Architecture Community System) is an open-source web application framework built on AOLserver and PostgreSQL/Oracle, designed to rapidly deploy community-oriented web applications like forums, e-commerce, and content management systems.

## Why it matters
During a penetration test against a legacy educational portal, an assessor discovers the target runs OpenACS with default configuration files still present — exposing `/doc/` paths that reveal version information and internal directory structure. This reconnaissance goldmine lets the attacker fingerprint the exact version, cross-reference known CVEs (such as SQL injection vulnerabilities in older OpenACS packages), and escalate to database compromise. Legacy frameworks like OpenACS frequently persist in academia and government where upgrade cycles are slow.

## Key facts
- OpenACS runs on **AOLserver** (not Apache/Nginx), an often-overlooked attack surface unfamiliar to many defenders
- Default installations expose **`/doc/`** and **`/api-doc/`** endpoints, leaking version and API details — these should be disabled in production
- Older OpenACS versions (pre-5.x) contained **SQL injection vulnerabilities** in Tcl-based package procedures due to insufficient input sanitization
- The framework uses **Tcl scripting** throughout — attackers who compromise the app layer can potentially execute Tcl commands server-side
- Classified as a **legacy/niche technology** — its presence on a network is a strong indicator of deferred patching and poor asset lifecycle management

## Related concepts
[[SQL Injection]] [[Default Credentials]] [[Legacy System Vulnerabilities]] [[Web Application Fingerprinting]] [[Attack Surface Management]]