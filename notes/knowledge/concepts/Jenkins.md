# Jenkins

## What it is
Think of Jenkins as a robotic assembly line foreman — it automatically grabs fresh code off the conveyor belt, builds it, tests it, and ships it without anyone touching a button. Precisely: Jenkins is an open-source automation server used to implement CI/CD (Continuous Integration/Continuous Delivery) pipelines, orchestrating the build, test, and deployment of software.

## Why it matters
In 2019, attackers exploited unauthenticated Jenkins Script Console access on exposed instances to execute Groovy scripts and deploy cryptominers — a classic case of an internet-facing build server with no authentication becoming a full remote code execution foothold. Defenders must treat Jenkins as a high-value target because it typically holds source code, credentials, deployment keys, and direct access to production infrastructure.

## Key facts
- **Script Console RCE**: Jenkins includes a Groovy Script Console (`/script`) that executes arbitrary code on the server; if exposed without authentication, it's game over.
- **CVE-2019-1003000 series**: A chain of Jenkins deserialization vulnerabilities allowed unauthenticated RCE, highlighting the risk of running outdated Jenkins versions.
- **Credential sprawl**: Jenkins stores secrets (SSH keys, API tokens, cloud credentials) in its credential store — compromising Jenkins often means compromising every downstream system.
- **Default port 8080**: Jenkins listens on TCP 8080 by default; exposed instances are actively scanned and targeted by botnets.
- **Principle of Least Privilege applies**: Jenkins agents should run with minimal OS permissions; a compromised agent with root access can pivot laterally across the entire build infrastructure.

## Related concepts
[[CI/CD Pipeline Security]] [[Remote Code Execution]] [[Credential Management]] [[Supply Chain Attack]]