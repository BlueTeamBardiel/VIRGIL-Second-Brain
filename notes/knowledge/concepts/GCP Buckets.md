# GCP Buckets

## What it is
Think of a GCP Bucket like a labeled cardboard box in a publicly accessible warehouse — anyone with the address can look inside if the owner forgot to lock it. Precisely, a Google Cloud Storage Bucket is an object storage container on Google Cloud Platform used to store files, backups, logs, application assets, and datasets at scale. Access is controlled through IAM policies and ACLs at both the bucket and object level.

## Why it matters
In 2021, misconfigured GCP Buckets exposed millions of records from organizations including healthcare and financial firms — attackers simply ran enumeration tools to guess bucket names (often predictable: `company-name-backup`, `company-prod-logs`) and found them set to `allUsers` with read access. A single misconfigured ACL allowing public read or write access can expose sensitive data or allow an attacker to plant malicious files that internal systems later execute.

## Key facts
- **Public access control**: Buckets can be set to `allUsers` (internet-facing) or `allAuthenticatedUsers` (any Google account) — both are dangerous defaults to audit
- **Uniform vs. Fine-Grained ACLs**: Uniform bucket-level access enforces IAM only; fine-grained allows per-object permissions, increasing misconfiguration risk
- **Bucket enumeration**: Tools like `GCPBucketBrute` automate discovery of exposed buckets using wordlists — bucket names are globally unique and guessable
- **Signed URLs**: Temporary access tokens granting time-limited bucket access; if leaked or long-lived, they function as stolen credentials
- **Cloud Audit Logs**: `Data Access` audit logs must be explicitly enabled — they are OFF by default, meaning unauthorized reads may go completely undetected

## Related concepts
[[Cloud Storage Misconfigurations]] [[IAM Policies]] [[S3 Bucket Security]] [[Object Storage Enumeration]] [[Cloud Audit Logging]]