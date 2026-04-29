# AWS Lambda

## What it is
Think of Lambda like a vending machine for code: you deposit a trigger (a coin), and a pre-packaged function runs and dispenses a result — the machine exists only long enough to complete the transaction. Precisely, AWS Lambda is a serverless compute service that executes discrete functions in response to events (HTTP requests, S3 uploads, database changes) without requiring you to provision or manage underlying servers. Billing is per-millisecond of execution, and the environment is ephemeral — destroyed after each invocation.

## Why it matters
In 2019, attackers who compromised cloud credentials used Lambda to establish persistent backdoors — injecting malicious code into existing functions so every legitimate trigger also executed attacker-controlled logic, completely invisible to network-based monitoring. Defenders must treat Lambda function code as a critical attack surface, auditing IAM roles attached to functions (over-permissioned Lambdas can become a pivot point to S3, DynamoDB, or EC2 across the entire account).

## Key facts
- Lambda functions execute with an attached **IAM execution role** — if that role has excessive permissions, a compromised function grants lateral movement across AWS services
- Default **maximum execution timeout is 15 minutes**; functions are stateless by design — persistent data must use external storage (S3, DynamoDB)
- **Event injection** is a primary Lambda attack vector: malicious input in trigger events (e.g., crafted filenames in S3 events) can exploit code-level vulnerabilities like command injection
- Lambda runs inside AWS-managed containers; **cold starts** create brief initialization delays, which can be exploited in timing-based attacks or to infer infrastructure behavior
- **CloudTrail logs Lambda invocations** — absence of these logs (or log tampering) is a key indicator of compromise in cloud forensics

## Related concepts
[[Serverless Architecture Security]] [[IAM Roles and Policies]] [[Cloud Security Posture Management]] [[Injection Attacks]] [[Privilege Escalation]]