# MITRE ATT&CK T1537

## What it is
Like a thief who doesn't carry stolen goods out the front door but instead mails packages to themselves from a post office around the corner, adversaries using T1537 exfiltrate data by transferring it *within* the cloud provider's infrastructure to an attacker-controlled account — never touching the victim's perimeter. Formally, **Transfer Data to Cloud Account** describes exfiltration where an attacker moves data from a compromised cloud environment to a separate cloud account they control, exploiting native cloud features like AWS S3 bucket replication, Azure Blob snapshots, or GCP storage transfers.

## Why it matters
In the 2019 Capital One breach, the attacker exploited a misconfigured WAF to access AWS S3 buckets and exfiltrated data using cloud-native mechanisms — a precursor pattern to T1537. Defenders relying on traditional network egress monitoring completely miss this technique because the traffic never leaves the cloud provider's backbone; detection requires cloud audit logs (AWS CloudTrail, Azure Monitor) watching for cross-account data transfer operations.

## Key facts
- **Bypasses perimeter DLP tools** — data moves within the cloud provider's network, so traditional egress monitoring generates zero alerts
- **Common abuse vectors**: AWS S3 replication policies, EBS snapshot sharing, RDS snapshot exports to attacker-controlled accounts
- **Detection relies on cloud-native logging**: CloudTrail `PutBucketReplication`, `ModifySnapshotAttribute`, and `SharedSnapshotVolumeCreate` API calls are key indicators
- **Sub-technique of Exfiltration (TA0010)** — categorized under the Exfiltration tactic in the ATT&CK framework
- **Mitigation**: Enforce SCPs (Service Control Policies) in AWS Organizations to block cross-account resource sharing to unknown accounts, and apply least-privilege IAM roles

## Related concepts
[[Cloud Storage Exfiltration]] [[AWS IAM Misconfigurations]] [[Data Loss Prevention]] [[CloudTrail Logging]] [[Exfiltration Over Web Service T1567]]