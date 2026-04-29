# Staging Environment

## What it is
Like a Broadway dress rehearsal on the same stage with the same lights before opening night, a staging environment is a near-perfect replica of production infrastructure used to test changes before they go live. It mirrors production systems in configuration, software versions, and network topology, but serves no real users or live data.

## Why it matters
In 2020, attackers compromised SolarWinds' **build pipeline** — the process that takes code from staging/testing into production — injecting malicious code into software updates before they ever reached customers. A properly isolated staging environment with integrity verification (code signing, hash validation) at each pipeline stage is a core defense against these supply chain attacks. If staging shares credentials or network access with production, attackers pivot directly from one to the other.

## Key facts
- **Credential separation is critical**: staging environments that share service accounts, API keys, or database credentials with production create a direct lateral movement path for attackers
- Staging environments frequently contain **real production data copies** (for realistic testing), making them high-value targets that require the same data protection controls as production
- **Configuration drift** — where staging diverges from production over time — is a common root cause of "it worked in staging" security failures when patches behave differently in production
- On Security+/CySA+, staging appears under **SDLC (Software Development Lifecycle)** concepts: the order is Development → Testing → Staging → Production
- Staging environments are a prime target for **credential harvesting** because developers often hardcode secrets or leave debug interfaces enabled, assuming the environment is "safe"

## Related concepts
[[Supply Chain Attack]] [[SDLC Security]] [[Separation of Environments]] [[Credential Management]] [[DevSecOps]]