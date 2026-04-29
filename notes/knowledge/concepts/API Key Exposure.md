# API Key Exposure

## What it is
Like leaving your house key taped to the front door with a note saying "this opens everything inside," an exposed API key hands attackers pre-authenticated access to a service without needing to crack a password. Precisely: API key exposure occurs when secret authentication tokens used to authorize programmatic access to services are accidentally disclosed in public repositories, client-side code, logs, or error messages.

## Why it matters
In 2022, a developer accidentally pushed AWS API keys to a public GitHub repository; within minutes, automated bots scraped the key and spun up thousands of EC2 instances for cryptomining, generating a $50,000 bill overnight. This illustrates the core danger: API keys carry no inherent MFA protection, and unlike passwords, they're often scoped to powerful cloud or payment service actions. Rotating the key immediately is the primary incident response action.

## Key facts
- **Git history is permanent by default** — deleting a committed key from the latest commit does not remove it from history; `git filter-repo` or a secret-scanning tool is required for full remediation.
- **Automated scanners** (TruffleHog, GitGuardian, GitHub Secret Scanning) continuously monitor public repos and can detect exposed keys within seconds of a push.
- **Principle of Least Privilege applies** — API keys should be scoped to minimum required permissions; a read-only key exposed causes far less damage than an admin key.
- **Keys in client-side JavaScript are always compromised** — anything shipped to a browser is publicly readable, regardless of obfuscation.
- **OWASP API Security Top 10** lists broken object-level authorization and improper asset management as key contributors to API credential exposure risks.

## Related concepts
[[Secrets Management]] [[Least Privilege]] [[Credential Stuffing]] [[OWASP API Security Top 10]] [[Static Application Security Testing]]