# AWS CloudTrail

## What it is  
Think of CloudTrail as a vigilant security guard that writes down every move made inside your AWS environment—who did what, when, and from where. Precisely, it’s a service that records AWS API calls and user actions across your account, delivering immutable logs of management and data events to CloudWatch Logs, S3, or both.

## Why it matters  
When a disgruntled engineer exfiltrates credentials by creating a rogue IAM user, CloudTrail logs capture the API call that created the user and the subsequent API calls that accessed secrets. Security teams can immediately spot the anomalous activity and revoke the compromised keys, preventing data loss and regulatory non‑compliance.

## Key facts  
- Trails can be configured for all regions, the global service endpoint, and optional data events (e.g., S3 object-level actions).  
- Log files are automatically encrypted at rest with SSE‑S3 or SSE‑KMS and can be stored in a highly durable S3 bucket.  
- Each event record contains the username, eventSource, eventName, requestParameters, responseElements, and a CloudTrail trace ID for correlation.  
- CloudTrail integrates with CloudWatch Logs for real‑time metrics, alarms, and dashboards.  
- Auditors use CloudTrail logs for