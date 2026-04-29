# Object Storage

## What it is
Think of object storage like a giant post office warehouse where every package gets a unique tracking number and can be retrieved directly — no folders, no filing cabinets, just flat-addressed blobs. Technically, it's a data storage architecture where data is stored as discrete objects (data + metadata + unique identifier) in a flat namespace, rather than the hierarchical structure of file or block storage. Amazon S3, Azure Blob Storage, and Google Cloud Storage are the dominant implementations.

## Why it matters
Misconfigured S3 buckets have been responsible for some of the largest data breaches in history — Capital One (2019) exposed 100 million records when an SSRF vulnerability combined with overly permissive IAM roles allowed traversal into private bucket contents. Attackers actively scan for publicly accessible buckets using tools like GrayhatWarfare and AWS's own CLI to find unintentionally exposed sensitive data. Proper bucket policies, blocking public access settings, and server-side encryption are the defensive triad.

## Key facts
- **Public access misconfiguration** is the #1 risk: S3 buckets default to private, but legacy settings or IAM policy mistakes can expose data globally without authentication
- **Bucket enumeration** is a real attack vector — bucket names are globally unique and predictable naming conventions (e.g., `companyname-backups`) make them discoverable
- **Server-Side Encryption (SSE)** options include SSE-S3 (AWS-managed keys), SSE-KMS (customer-controlled via Key Management Service), and SSE-C (customer-provided keys)
- **Pre-signed URLs** grant temporary, time-limited access to private objects — if stolen or leaked, they can be replayed until expiration
- **Access logging and CloudTrail** integration provides audit trails for object-level operations, critical for detecting unauthorized access or exfiltration

## Related concepts
[[Cloud Security]] [[IAM Policies]] [[Data Exfiltration]] [[Server-Side Request Forgery]] [[Encryption at Rest]]