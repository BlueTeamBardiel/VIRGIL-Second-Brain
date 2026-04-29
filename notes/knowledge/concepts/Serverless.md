# Serverless

## What it is
Like renting a single parking spot by the hour instead of buying a whole garage — you only get compute resources for the exact milliseconds your code runs, with no persistent server to manage. Serverless computing (e.g., AWS Lambda, Azure Functions) executes event-driven functions in ephemeral containers spun up on demand. The cloud provider handles all infrastructure; you deploy only the function code.

## Why it matters
In 2019, attackers exploited misconfigured AWS Lambda functions with overly permissive IAM roles, using them to exfiltrate environment variables containing hardcoded API keys and database credentials. Because each function invocation is stateless and short-lived, traditional endpoint detection tools miss the attack entirely — logs are the primary forensic artifact, making CloudTrail monitoring critical.

## Key facts
- **Ephemeral execution** means no persistent filesystem; attackers cannot maintain traditional persistence mechanisms like cron jobs or backdoor binaries between invocations
- **Environment variables** are the #1 secrets-leakage vector in serverless — credentials stored there are visible to any code (or injected payload) running in that function context
- **Event injection** is the dominant attack class: malicious input in triggers (S3 events, API Gateway requests, SQS messages) can cause command injection or SSRF within the function
- **Excessive IAM permissions** (violating least privilege) are the root cause in most serverless breaches — a compromised function with broad permissions can pivot to S3, DynamoDB, or EC2
- **Cold start logging gaps** and short execution windows (default 15-minute max on Lambda) complicate incident response; SIEM integration with CloudWatch/CloudTrail is essential for visibility

## Related concepts
[[Cloud Security]] [[IAM (Identity and Access Management)]] [[Injection Attacks]] [[SSRF (Server-Side Request Forgery)]] [[Least Privilege]]