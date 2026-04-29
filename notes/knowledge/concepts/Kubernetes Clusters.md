# Kubernetes Clusters

## What it is
Think of a Kubernetes cluster like an airport operations center: a control tower (the control plane) coordinates hundreds of gates (nodes) where planes (containers) land, take off, and get rerouted automatically when a gate fails. Precisely, a Kubernetes cluster is a set of machines running containerized workloads, managed by a control plane that schedules containers, handles scaling, and maintains desired state across worker nodes. The control plane components — API server, etcd, scheduler, and controller manager — are the authoritative brain; worker nodes run the actual application pods.

## Why it matters
In 2020, attackers compromised Tesla's Kubernetes dashboard, which had been left exposed to the internet without authentication, and used it to deploy cryptomining malware inside the cluster. This illustrates how a misconfigured Kubernetes API server or dashboard becomes an open door: once inside the cluster, lateral movement to sensitive workloads, secrets stored in etcd, or cloud provider credentials via the metadata API is trivial.

## Key facts
- The **Kubernetes API server** listens on port 6443 by default; anonymous access enabled here is a critical misconfiguration
- **etcd** (port 2379) stores all cluster state including Secrets in base64 encoding — not encrypted by default unless encryption-at-rest is explicitly configured
- **RBAC (Role-Based Access Control)** must be enforced; overly permissive `ClusterRoleBindings` (e.g., binding to `cluster-admin`) are a top privilege escalation vector
- Kubernetes **Secrets** are only base64-encoded by default, not encrypted — treat them as plaintext unless envelope encryption is configured
- The **kubelet API** (port 10250) allows unauthenticated command execution in older or misconfigured deployments, enabling full node compromise

## Related concepts
[[Container Security]] [[RBAC]] [[Privilege Escalation]] [[Secrets Management]] [[Cloud Security Misconfiguration]]