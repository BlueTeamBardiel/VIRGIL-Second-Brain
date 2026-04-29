# Contractor Security

## What it is
Like a guest with a temporary key card who can access the lobby but shouldn't wander into the server room, contractors are third-party workers granted limited, time-bound access to organizational systems. Contractor security refers to the policies, controls, and monitoring practices used to manage the risks posed by external personnel who have legitimate but restricted access to internal resources.

## Why it matters
The 2013 Target breach originated through an HVAC contractor whose credentials were compromised, giving attackers a foothold into Target's payment network. This demonstrates that even non-IT contractors with network access can become critical attack vectors if their permissions aren't scoped and monitored properly.

## Key facts
- Contractors should operate under **least privilege** — granted only the minimum access required for their specific task, for the duration of that task only
- **Offboarding is critical**: credentials, badges, and VPN access must be revoked immediately upon contract end; lingering accounts are a common finding in audits
- Third-party risk is governed by **vendor/supplier agreements** (SLAs, MOU, NDA, BAA) that define security requirements and liability
- Contractors should be placed in **separate network segments** (VLANs) to limit lateral movement if their credentials are compromised
- Background checks and **security awareness training** should be required before granting access, mirroring what's required for full-time employees in equivalent roles

## Related concepts
[[Third-Party Risk Management]] [[Least Privilege]] [[Access Control]] [[Network Segmentation]] [[Supply Chain Security]]