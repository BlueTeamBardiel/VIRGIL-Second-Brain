# PersistentVolume

## What it is
Like a pre-provisioned USB drive sitting in a cabinet waiting to be checked out by a user, a PersistentVolume (PV) is a piece of storage in a Kubernetes cluster that exists independently of any individual pod's lifecycle. It is a cluster-level resource that abstracts underlying storage (NFS, AWS EBS, local disk) and persists data even after the pod that mounted it is deleted. A PersistentVolumeClaim (PVC) is the "checkout request" a pod submits to bind to that storage.

## Why it matters
In a 2023 cloud breach scenario, attackers who compromised a Kubernetes pod escalated their impact by accessing a PersistentVolume containing database credentials and backup files that survived pod restarts — data that would have been lost in ephemeral container storage was instead quietly exfiltrated. Defenders must apply least-privilege access controls and encryption-at-rest to PVs because sensitive data surviving the container lifecycle dramatically expands the blast radius of a container escape.

## Key facts
- PVs have **access modes**: ReadWriteOnce (single node), ReadOnlyMany (multiple nodes read), ReadWriteMany (multiple nodes write) — misconfigured ReadWriteMany PVs are a lateral movement risk
- **Reclaim policies** (Retain, Recycle, Delete) determine what happens to data after a PVC is released; `Retain` leaves sensitive data accessible to the next binding
- PVs exist at **cluster scope**, not namespace scope — a compromised cluster-admin can access all PVs regardless of namespace isolation
- Encryption-at-rest for PVs must be configured at the **storage provider level** (e.g., AWS EBS encryption); Kubernetes itself does not encrypt PV data by default
- **StorageClass** objects define dynamic provisioning — attackers with PVC creation rights can potentially spin up volumes and stage exfiltration data

## Related concepts
[[Kubernetes RBAC]] [[Container Escape]] [[Encryption at Rest]]