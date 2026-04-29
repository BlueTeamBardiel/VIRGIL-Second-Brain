# authentication gate

## What it is
Like a bouncer checking IDs at a club entrance before you can reach the bar, an authentication gate is a mandatory checkpoint that verifies identity before granting access to a system, resource, or network segment. It enforces the principle that identity must be proven before trust is extended, acting as the first enforced decision point in an access control chain.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors bypassed authentication gates by stealing valid SAML tokens, allowing them to move laterally through Microsoft 365 environments without ever triggering failed login alerts. This demonstrates that authentication gates are only as strong as the token validation and session management mechanisms behind them — a forged or stolen credential renders the gate meaningless.

## Key facts
- Authentication gates can use one or more factors: something you know (password), something you have (token), or something you are (biometric) — combining these is multi-factor authentication (MFA)
- A broken authentication gate is listed in OWASP's Top 10 as one of the most critical web application vulnerabilities
- Context-aware authentication gates adjust requirements based on risk signals (location, device posture, time of day) — this is the foundation of adaptive authentication
- A gate that fails **open** (grants access on error) is far more dangerous than one that fails **closed** (denies access on error); always design for fail-closed behavior
- Authentication gates differ from authorization controls: the gate confirms *who you are*, while authorization determines *what you can do* after passing through

## Related concepts
[[multi-factor authentication]] [[access control]] [[identity and access management]] [[zero trust architecture]] [[session hijacking]]