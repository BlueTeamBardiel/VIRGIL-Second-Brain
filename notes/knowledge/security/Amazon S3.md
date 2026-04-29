---
domain: "cloud-infrastructure"
tags: [cloud-storage, aws, object-storage, s3, data-security, misconfiguration]
---
# Amazon S3

**Amazon Simple Storage Service (S3)** is a scalable [[Object Storage]] service provided by [[Amazon Web Services (AWS)]] that allows users to store and retrieve arbitrary amounts of data from anywhere on the internet. Launched in 2006, S3 operates on a flat **bucket-and-object** model and has become the de facto standard for cloud object storage, underpinning everything from static website hosting to data lake architectures. Its ubiquity in production environments makes it a frequent target in [[Cloud Security]] assessments and a critical topic for the [[CompTIA Security+ SY0-701]] exam.

---

## Overview

Amazon S3 stores data as **objects** inside containers called **buckets**. Unlike a traditional [[File System]] with hierarchical directories, S3 uses a flat namespace where each object is identified by a globally unique key within a bucket. The illusion of folders is created by using forward-slash delimiters in key names (e.g., `logs/2024/01/access.log`), but the underlying storage model is non-hierarchical. Each object can range from 0 bytes to 5 terabytes in size and is associated with metadata, an access control configuration, and an optional version history.

S3 was designed around the principles of durability, availability, and scalability. AWS guarantees **99.999999999% (11 nines) of durability** for objects stored in standard storage classes by redundantly storing data across a minimum of three Availability Zones within a region. This is achieved through automatic replication and error-correction mechanisms that operate transparently to the user. Availability SLAs vary by storage class, with S3 Standard offering 99.99% availability.

Access to S3 resources is controlled through multiple overlapping mechanisms: **IAM policies** (identity-based), **bucket policies** (resource-based), **Access Control Lists (ACLs)**, and **S3 Block Public Access** settings. These mechanisms interact in ways that can produce unexpected exposure when misconfigured—a problem so widespread that AWS introduced Account-level Block Public Access controls in 2018 to help administrators prevent accidental public exposure.

S3 integrates deeply with the broader AWS ecosystem. It serves as the backbone for services including [[AWS Lambda]] (event-driven compute), [[AWS CloudFront]] (CDN), [[AWS Athena]] (serverless SQL queries on S3 data), and [[AWS Glacier]] (archival storage). Data pipelines, ML training datasets, application backups, compliance archives, and static web assets are all commonly hosted in S3, making it one of the highest-value targets for attackers who gain any foothold in an AWS environment.

Pricing follows a pay-as-you-go model based on storage volume, number of API requests, data transfer out of AWS, and optional features like replication or lifecycle management. Storage classes include S3 Standard, S3 Intelligent-Tiering, S3 Standard-IA (Infrequent Access), S3 One Zone-IA, S3 Glacier Instant Retrieval, S3 Glacier Flexible Retrieval, and S3 Glacier Deep Archive—each offering different cost-latency tradeoffs.

---

## How It Works

### Core API and Protocol

S3 exposes a RESTful HTTP/HTTPS API. All operations are performed over **TCP port 443** (HTTPS) in production environments, with HTTP on port 80 technically supported but strongly discouraged. The base URL format for bucket access is:

```
https://<bucket-name>.s3.<region>.amazonaws.com/<key>
```

For example:
```
https://my-company-logs.s3.us-east-1.amazonaws.com/2024/01/15/access.log
```

A path-style URL format (legacy) also exists:
```
https://s3.<region>.amazonaws.com/<bucket-name>/<key>
```

### Authentication and Request Signing

Requests to non-public S3 resources must be authenticated using **AWS Signature Version 4 (SigV4)**. This process involves:

1. **Creating a canonical request** — Normalizing the HTTP method, URI, query string, headers, and hashed payload.
2. **Creating a string to sign** — Combining the algorithm identifier, timestamp, credential scope, and hash of the canonical request.
3. **Calculating the signature** — Using HMAC-SHA256 with the derived signing key (computed from the secret access key, date, region, and service).
4. **Adding the signature to the request** — Via the `Authorization` header or as query string parameters (presigned URLs).

The AWS CLI and SDKs handle this process automatically.

### Common AWS CLI Operations

**Configure credentials:**
```bash
aws configure
# Enter: AWS Access Key ID, Secret Access Key, Region, Output format
```

**Create a bucket:**
```bash
aws s3 mb s3://my-secure-bucket --region us-east-1
```

**Upload a file:**
```bash
aws s3 cp /local/path/file.txt s3://my-secure-bucket/folder/file.txt
```

**List bucket contents:**
```bash
aws s3 ls s3://my-secure-bucket/ --recursive
```

**Sync a directory:**
```bash
aws s3 sync ./local-dir s3://my-secure-bucket/backup/ --delete
```

**Download an object:**
```bash
aws s3 cp s3://my-secure-bucket/folder/file.txt ./downloaded-file.txt
```

**Delete an object:**
```bash
aws s3 rm s3://my-secure-bucket/folder/file.txt
```

**Generate a presigned URL (temporary access):**
```bash
aws s3 presign s3://my-secure-bucket/secret-report.pdf --expires-in 3600
```

### Bucket Policy (JSON)

Bucket policies are JSON documents attached directly to a bucket. They specify principals, actions, resources, and conditions:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyUnencryptedObjectUploads",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::my-secure-bucket/*",
      "Condition": {
        "StringNotEquals": {
          "s3:x-amz-server-side-encryption": "aws:kms"
        }
      }
    }
  ]
}
```

### Object Lifecycle

1. Client sends authenticated PUT request with object data and optional metadata.
2. S3 receives the object, computes an MD5 checksum (ETag), and stores the object redundantly across multiple devices and AZs.
3. S3 returns HTTP `200 OK` with the ETag in the response headers.
4. For versioned buckets, a new version ID is generated rather than overwriting the existing object.
5. Lifecycle policies can automatically transition objects to cheaper storage classes or expire them after a defined number of days.

### Storage Classes and Transitions

```
Standard → Standard-IA (after 30 days) → Glacier Instant Retrieval (after 90 days) → Glacier Deep Archive (after 180 days)
```

Lifecycle rules are defined in XML or via the console/CLI and execute automatically based on object age or prefix/tag filters.

---

## Key Concepts

- **Bucket**: A top-level namespace container for S3 objects. Bucket names must be globally unique across all AWS accounts and regions, follow DNS naming conventions, and be 3–63 characters long. Each bucket is created in a specific AWS region.

- **Object**: The fundamental storage unit in S3, consisting of the object data (payload), a key (unique identifier within the bucket), metadata (system and user-defined key-value pairs), a version ID (if versioning is enabled), and an access control configuration.

- **Object Key**: The full path-like identifier for an object within a bucket (e.g., `images/profile/user123.jpg`). The key combined with the bucket name uniquely identifies an object globally within AWS.

- **Versioning**: An optional bucket-level feature that preserves multiple variants of an object by assigning unique version IDs to each PUT operation. Once enabled, versioning can only be suspended (not fully disabled). Critical for protecting against accidental deletion and ransomware.

- **Block Public Access**: A set of four independent account-level and bucket-level controls that override bucket policies and ACLs to prevent public exposure. The four settings are: `BlockPublicAcls`, `IgnorePublicAcls`, `BlockPublicPolicy`, and `RestrictPublicBuckets`. All four are enabled by default for new buckets since April 2023.

- **Server-Side Encryption (SSE)**: S3 supports three encryption modes: **SSE-S3** (AWS-managed AES-256 keys), **SSE-KMS** (customer-controlled keys via [[AWS KMS]]), and **SSE-C** (customer-provided keys). As of January 2023, all new objects in S3 are encrypted at rest by default using SSE-S3.

- **Presigned URL**: A time-limited URL generated by an authenticated user that grants temporary access to a specific S3 object without requiring the requester to have AWS credentials. Presigned URLs carry the requesting user's permissions at generation time.

- **S3 Access Points**: Named network endpoints attached to buckets that allow you to define distinct access policies for different applications or user groups accessing the same bucket, simplifying permission management at scale.

- **Multipart Upload**: For objects larger than 100 MB, S3 recommends (and above 5 GB, requires) multipart upload, which splits the object into parts uploaded independently and then assembled by S3. This improves throughput and allows resuming interrupted uploads.

---

## Security Implications

### Public Bucket Exposure (Chronic Industry Problem)

The most historically significant S3 security issue is **unintentional public bucket exposure**. Misconfigured S3 buckets have led to some of the largest data breaches in cloud history:

- **2017 – Booz Allen Hamilton**: A publicly exposed S3 bucket contained classified NSA files and credentials for government systems.
- **2017 – Verizon**: 14 million customer records exposed in a misconfigured bucket operated by a vendor (NICE Systems).
- **2019 – Capital One**: Attacker Paige Thompson exploited a misconfigured [[Web Application Firewall]] to obtain [[AWS IAM]] credentials via [[Server-Side Request Forgery (SSRF)]], then listed and downloaded 100+ million records from S3 buckets. This breach resulted in a $190 million settlement.
- **2020 – Twitch**: Internal source code and creator payout data were exposed via misconfigured S3 access.

### Attack Vectors

**1. Unauthenticated bucket enumeration:**
Attackers use tools like `awsbucketdump`, `s3scanner`, `bucket-finder`, and `trufflehog` to discover publicly accessible buckets by guessing names based on company names, product names, and common patterns.

```bash
# Example using s3scanner
s3scanner scan --bucket target-company-backup
```

**2. SSRF to IMDS credential theft:**
Attackers exploit SSRF vulnerabilities in web applications hosted on EC2 to reach the **Instance Metadata Service (IMDS)** at `169.254.169.254`, retrieve temporary IAM role credentials, then use those credentials to access S3 buckets the role has permission to access.

**3. Overpermissive IAM roles:**
Applications running in AWS environments are often granted `s3:*` on `*` (all buckets, all actions). Compromising the application then grants full S3 access.

**4. Bucket policy misconfiguration:**
Setting `"Principal": "*"` without appropriate conditions in a bucket policy makes resources publicly accessible. This is surprisingly easy to introduce through Infrastructure as Code errors.

**5. Cross-account confused deputy:**
A bucket policy granting access to another AWS account without an `aws:SourceAccount` condition can enable [[Confused Deputy Attack]] scenarios.

**6. Ransomware via S3:**
Attackers with `s3:PutObject` and `s3:DeleteObject` permissions (or the ability to disable versioning) can encrypt or delete data held in S3 buckets as a ransomware attack.

**7. Data exfiltration via presigned URLs:**
Leaked or stolen presigned URLs (e.g., in application logs, browser history, or API responses) can allow unauthorized access to objects for their validity duration.

### CVEs and AWS Security Advisories

- **CVE-2020-9284** (not S3 directly but related): Various AWS SDK path traversal issues affecting S3 key handling in certain languages.
- AWS Security Bulletin for **S3 Block Public Access bypass** (2020): A specific condition involving legacy ACL grants from pre-2018 bucket creation could bypass newer Block Public Access controls in edge cases—patched by AWS.

---

## Defensive Measures

### 1. Enable Block Public Access at the Account Level

The single most impactful control. Apply this to every AWS account:

```bash
aws s3control put-public-access-block \
  --account-id 123456789012 \
  --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,\
  BlockPublicPolicy=true,RestrictPublicBuckets=true
```

### 2. Enforce Encryption in Transit

Use bucket policies to deny HTTP (unencrypted) access:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyHTTP",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::my-bucket",
        "arn:aws:s3:::my-bucket/*"
      ],
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
```

### 3. Enable Server-Side Encryption with KMS

Use SSE-KMS for buckets containing sensitive data to enable audit trails via [[AWS CloudTrail]] on all key usage:

```bash
aws s3api put-bucket-encryption \
  --bucket my-secure-bucket \
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "aws:kms",
        "KMSMasterKeyID": "arn:aws:kms:us-east-1:123456789012:key/KEY-ID"
      },
      "BucketKeyEnabled": true
    }]
  }'
```

### 4. Enable Versioning and MFA Delete

Versioning protects against accidental deletion and ransomware. MFA Delete requires a second factor to permanently delete object versions:

```bash
aws s3api put-bucket-versioning \
  --bucket my-secure-bucket \
  --versioning-configuration Status=Enabled,MFADelete=Enabled \
  --mfa "arn:aws:iam::123456789012:mfa/root-account-mfa-device 123456"
```

### 5. Enable S3 Access Logging and CloudTrail Data Events

S3 server access logs record all requests made to a bucket. For higher-fidelity logging including the IAM principal making each request, enable CloudTrail S3 data events:

```bash
aws cloudtrail put-event-selectors \
  --trail-name my-trail \
  --event-selectors '[{
    "ReadWriteType": "All",
    "IncludeManagementEvents": true,
    "DataResources": [{
      "Type": "AWS::S3::Object",
      "Values": ["arn:aws:s3:::my-secure-bucket/"]
    }]
  }]'
```

### 6. Use AWS Config Rules for Continuous Compliance

AWS Config provides managed rules to detect common S3 misconfigurations:

- `s3-bucket-public-read-prohibited` — Detects publicly readable buckets
- `s3-bucket-public-write-prohibited` — Detects publicly writable buckets
- `s3-bucket-server-side-encryption-enabled` — Ensures default encryption
- `s3-bucket-ssl-requests-only` — Verifies HTTPS-