# Open permissions

## What it is
Imagine leaving your filing cabinet unlocked with a sign that says "Everyone welcome — read, edit, delete freely." Open permissions occur when access controls on files, directories, shares, or services are misconfigured to grant excessive rights — typically read, write, or execute — to unauthorized users or groups (e.g., "Everyone" or "Authenticated Users") who should have no such access.

## Why it matters
In the 2017 WannaCry outbreak, attackers leveraged SMB shares with overly permissive configurations to propagate laterally across networks at devastating speed. A single misconfigured network share with write access to "Everyone" allowed the ransomware to encrypt files across thousands of connected systems — a failure that proper least-privilege controls would have contained.

## Key facts
- The **principle of least privilege** is the direct countermeasure: users and processes should receive only the minimum permissions necessary to perform their function.
- Common misconfigurations include world-writable directories (`chmod 777` on Linux), SMB shares set to "Full Control" for Everyone, and S3 buckets left publicly accessible.
- Open permissions are a top finding in penetration tests and vulnerability scans; tools like **Nessus**, **BloodHound**, and **PowerSploit** specifically enumerate excessive share and AD object permissions.
- On Windows, permissions are evaluated through a combination of **NTFS permissions** and **share permissions** — the most restrictive of the two applies.
- OWASP lists broken access control (which includes open permissions) as the **#1 web application security risk** in the 2021 Top 10.

## Related concepts
[[Least Privilege]] [[Access Control Lists]] [[Discretionary Access Control]] [[Misconfiguration]] [[Lateral Movement]]