# Kubernetes

## What it is
Think of Kubernetes like an air traffic controller for containers — it decides which planes (containers) land on which runways (nodes), reroutes traffic when a runway closes, and scales operations during a storm. Precisely: Kubernetes is an open-source container orchestration platform that automates deployment, scaling, and management of containerized applications across a cluster of machines. It groups containers into logical units called Pods and manages their lifecycle through a control plane.

## Why it matters
In 2018, Tesla's Kubernetes dashboard was left exposed to the internet without authentication, allowing attackers to hijack the cluster and mine cryptocurrency using Tesla's cloud infrastructure. The attack succeeded because the etcd datastore (which holds all cluster secrets and configs) was accessible, and no RBAC policies were enforced — a misconfiguration still devastatingly common today.

## Key facts
- **RBAC (Role-Based Access Control)** must be explicitly configured; default installations historically granted overly permissive access to the API server
- The **etcd** database stores all cluster state including Secrets — if etcd is compromised, the entire cluster is compromised; it should be encrypted at rest
- **Pod Security Admission (PSA)** replaced PodSecurityPolicies in K8s 1.25+ and controls what privileges containers can request at runtime
- The **Kubernetes API server** (port 6443) is the primary attack surface — exposed API servers are actively scanned and exploited by threat actors
- **Namespaces** provide logical isolation but NOT security boundaries; a misconfigured ClusterRoleBinding can grant cross-namespace privilege escalation

## Related concepts
[[Container Security]] [[Privilege Escalation]] [[Cloud Misconfiguration]] [[Role-Based Access Control]] [[Secrets Management]]