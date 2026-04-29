# Serverless Architecture

## What it is
Think of it like ordering from a restaurant that only cooks your meal when you place the order — no idle kitchen staff waiting around. Serverless architecture is a cloud execution model where functions run on-demand in ephemeral containers managed entirely by the provider (AWS Lambda, Azure Functions, Google Cloud Run), with no persistent server infrastructure for the developer to manage. Billing and resources scale automatically per function invocation rather than per running instance.

## Why it matters
In 2019, Capital One's breach involved a misconfigured WAF and SSRF vulnerability — in serverless environments, the equivalent attack is **event injection**, where malicious input passed through triggers (S3 uploads, API Gateway events, SNS messages) executes arbitrary code inside a Lambda function. Because functions inherit IAM roles, a single over-privileged function can become a launchpad for lateral movement across an entire cloud account.

## Key facts
- **Ephemeral execution** means traditional host-based forensics fail — function instances spin up and die in seconds, leaving minimal local artifacts
- **Attack surface shifts** from OS/network hardening to input validation, dependency management, and IAM permission scoping
- **Event injection** is the serverless analog of SQL injection — untrusted data flowing through triggers can manipulate function logic
- **Shared responsibility model** still applies: the provider secures the runtime; the developer owns code, dependencies, and IAM roles
- **Cold start containers** reuse execution environments briefly, creating a **data residue risk** where environment variables (secrets, tokens) may persist between invocations

## Related concepts
[[Cloud Security]] [[IAM (Identity and Access Management)]] [[Injection Attacks]] [[SSRF (Server-Side Request Forgery)]] [[Zero Trust Architecture]]