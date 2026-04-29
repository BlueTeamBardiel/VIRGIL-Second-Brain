# Kubernetes Security

## What it is
Think of Kubernetes like a massive shipping port where containers are cargo — without proper manifests, access controls, and inspections, anyone could load or unload whatever they want. Kubernetes security is the discipline of hardening container orchestration clusters by controlling who schedules workloads, how pods communicate, what privileges containers hold, and how secrets are managed across nodes.

## Why it matters
In 2021, attackers compromised a misconfigured Kubernetes API server at a major cloud tenant, leveraging an unauthenticated endpoint to deploy cryptomining containers across hundreds of nodes — a technique now called "cryptojacking via exposed orchestrators." The API server is the single control plane for the entire cluster, meaning one misconfiguration can hand an attacker full cluster admin rights. Locking down RBAC policies and disabling anonymous authentication directly prevents this attack vector.

## Key facts
- **The API server is the crown jewel**: Exposing it publicly without authentication is the most common critical Kubernetes misconfiguration — always enforce TLS and disable anonymous access (`--anonymous-auth=false`)
- **RBAC over ABAC**: Kubernetes supports both, but Role-Based Access Control (RBAC) is the recommended model; principle of least privilege means binding service accounts only to namespaced roles, not cluster-wide roles
- **Pod Security Standards (PSS)** replaced the deprecated Pod Security Policies (PSP) — enforced via admission controllers to prevent privileged containers and host namespace sharing
- **Secrets are base64-encoded by default, not encrypted** — enabling etcd encryption at rest is a required hardening step for sensitive credential storage
- **Network Policies act as internal firewalls** — by default, all pods can communicate with all other pods; explicit ingress/egress policies must be written to enforce segmentation

## Related concepts
[[Container Security]] [[Role-Based Access Control]] [[Network Segmentation]] [[Secrets Management]] [[Cloud Security Posture Management]]