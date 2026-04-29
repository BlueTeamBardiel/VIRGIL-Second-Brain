# Serverless FaaS Security

## What it is
Like renting a kitchen by the minute instead of owning a restaurant — you bring the recipe, someone else manages the ovens, pipes, and health inspections. Serverless Function-as-a-Service (FaaS) platforms (AWS Lambda, Azure Functions, Google Cloud Functions) execute discrete code snippets in ephemeral containers managed entirely by the cloud provider, abstracting away OS and infrastructure management from the developer.

## Why it matters
In 2021, attackers compromised a misconfigured Lambda function at a financial services firm by exploiting overly permissive IAM roles — the function had `s3:*` access, allowing lateral movement to exfiltrate customer data from unrelated buckets. The attack surface shifted entirely from network perimeter to identity permissions and code injection, illustrating how traditional firewall-focused defenses completely miss serverless threats.

## Key facts
- **Event injection** is the #1 serverless attack vector — malicious input passed through triggers (S3 events, API Gateway, SQS) can cause command injection or SSRF inside the function runtime
- **Overprivileged IAM roles** are the serverless equivalent of running everything as root — least privilege per function is critical, not per application
- **Cold start environments** are ephemeral but **environment variables** persist across warm invocations and are a common secret exfiltration target
- **Function execution time limits** (typically 15 minutes for Lambda) create a natural DoS vector — attackers can trigger expensive, long-running functions to inflate costs (billing DoS)
- **Shared runtime environments** across tenants mean vulnerable dependencies in your function package can be exploited even when the cloud provider patches the underlying host

## Related concepts
[[Cloud IAM and Privilege Escalation]] [[SSRF (Server-Side Request Forgery)]] [[Dependency and Supply Chain Security]]