# AWS KMS

## What it is
Think of it as a bank vault where you never touch the actual gold — you just tell the bank "lock this" or "unlock this," and they handle the keys. AWS Key Management Service (KMS) is a managed service that creates, stores, and controls cryptographic keys used to encrypt data across AWS services. You never export the raw key material; instead, you make API calls and KMS performs the cryptographic operations on your behalf.

## Why it matters
In the 2019 Capital One breach, misconfigured IAM roles allowed an SSRF attack to exfiltrate data from S3. Had S3 buckets used KMS Customer Managed Keys (CMKs) with tight key policies, even a compromised EC2 role couldn't have decrypted the stolen data without explicit `kms:Decrypt` permission — adding a critical second layer of defense. KMS CloudTrail logs would also have surfaced anomalous decrypt calls immediately.

## Key facts
- **Three key types**: AWS Managed Keys (automatic rotation, no cost control), Customer Managed Keys (CMKs — full policy control, ~$1/month), and Customer Provided Keys (BYOK via key import)
- **Envelope encryption**: KMS generates a Data Encryption Key (DEK); your data is encrypted with the DEK, and the DEK is encrypted by the CMK — the raw CMK never leaves the Hardware Security Module (HSM)
- **Key policies are the primary access control** — IAM policies alone cannot grant KMS access without a permissive key policy
- **Automatic annual rotation** is available for CMKs; AWS Managed Keys rotate every 3 years automatically
- **CloudTrail integration** logs every API call (GenerateDataKey, Decrypt, Encrypt), making KMS a forensic goldmine for detecting credential abuse

## Related concepts
[[Envelope Encryption]] [[IAM Policies]] [[Hardware Security Module]] [[CloudTrail]] [[S3 Server-Side Encryption]]