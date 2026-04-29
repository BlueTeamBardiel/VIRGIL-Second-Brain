# RDMA

## What it is
Like a courier who bypasses the building's receptionist and delivers packages directly to your desk, RDMA (Remote Direct Memory Access) lets one machine read or write another machine's RAM directly — skipping the remote CPU and OS entirely. It's a high-speed networking technology that enables direct memory-to-memory transfers between systems without involving the target host's processor or kernel, dramatically reducing latency.

## Why it matters
In high-performance computing and cloud environments, RDMA-capable networks (like InfiniBand or RoCE) introduce a dangerous attack surface: an attacker with network access and sufficient privileges can read or write a target system's memory without triggering normal OS-level security controls or logging. CVE-style attacks against misconfigured RDMA clusters have demonstrated credential theft and memory scraping because the operations bypass standard intrusion detection hooks that monitor syscalls.

## Key facts
- RDMA operates at the **hardware/NIC level**, meaning OS-based security tools (EDR, auditd, kernel logs) often cannot observe RDMA transactions
- Three main implementations: **InfiniBand**, **RoCE (RDMA over Converged Ethernet)**, and **iWARP**
- Misconfigured RDMA deployments with **no authentication or encryption** allow unauthenticated memory access — a critical misconfiguration finding
- RDMA is widely used in **HPC clusters, financial trading systems, and cloud hypervisors** (e.g., Azure SmartNIC infrastructure)
- Defense requires **network segmentation**, RDMA-aware firewalls, and enabling **MACsec or IPsec** on RoCE links since RDMA itself has no built-in encryption by default

## Related concepts
[[Network Segmentation]] [[Side-Channel Attacks]] [[Hypervisor Security]] [[Kernel Bypass Networking]] [[Data Exfiltration]]