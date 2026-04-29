# Continuous Integration

## What it is
Like a factory assembly line with a quality inspector at every station — not just at the end — Continuous Integration (CI) is the practice of automatically merging, building, and testing code changes into a shared repository multiple times per day. Each commit triggers an automated pipeline that validates the code before it ever reaches production, catching defects early when they're cheapest to fix.

## Why it matters
In 2020, the SolarWinds supply chain attack succeeded partly because malicious code was injected into the build pipeline itself — the CI/CD environment was compromised, not just the source code. A hardened CI pipeline with integrity checks, signed builds, and isolated build environments could have detected or prevented the tampered artifacts from reaching downstream customers. This is why securing the CI pipeline is now treated as critical infrastructure, not just a developer convenience.

## Key facts
- CI pipelines are high-value attack targets — compromising a build server gives attackers code execution across every product that pipeline touches
- Static Application Security Testing (SAST) and Software Composition Analysis (SCA) tools are commonly integrated into CI pipelines as automated security gates
- Build artifacts should be cryptographically signed to ensure integrity from build to deployment (artifact signing)
- The principle of least privilege applies to CI service accounts — a build runner should never have production write access
- Secrets (API keys, credentials) hardcoded in repositories are frequently exposed through CI logs; tools like truffleHog scan for this automatically

## Related concepts
[[Supply Chain Attack]] [[DevSecOps]] [[Static Application Security Testing]] [[Software Bill of Materials]] [[Secrets Management]]