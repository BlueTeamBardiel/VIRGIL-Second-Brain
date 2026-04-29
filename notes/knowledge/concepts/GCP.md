# GCP

## What it is
Think of GCP (Google Cloud Platform) like renting space in Google's massive data center city — you get the building, the power, and the security guards at the gate, but you're responsible for locking your own apartment. GCP is Google's suite of cloud computing services offering compute, storage, networking, and security capabilities delivered over the internet. Like AWS and Azure, it operates on a shared responsibility model where Google secures the infrastructure, and customers secure their configurations and data.

## Why it matters
In 2020, misconfigured GCP storage buckets (Cloud Storage) exposed sensitive data from multiple organizations — a direct parallel to the S3 bucket exposure epidemic on AWS. Attackers routinely scan for publicly accessible GCP buckets using tools like `gsutil` or GrayhatWarfare, harvesting credentials, PII, and source code without ever exploiting a single vulnerability — just walking through an unlocked door.

## Key facts
- **IAM (Identity and Access Management)** is the primary access control mechanism; overly permissive service account keys are a top attack vector
- **Cloud Storage buckets** set to `allUsers` or `allAuthenticatedUsers` are publicly accessible — a common misconfiguration leading to data breaches
- **VPC Service Controls** act as a security perimeter around GCP resources, preventing data exfiltration even by authenticated users
- **Cloud Security Command Center (SCC)** is GCP's native SIEM-like tool for threat detection and security posture management
- **Metadata server** at `169.254.169.254` can be queried from compromised GCP instances to steal service account tokens — a critical SSRF target

## Related concepts
[[Cloud Security]] [[IAM]] [[SSRF]] [[Shared Responsibility Model]] [[Data Exposure]]