# InfiniBand

## What it is
Think of InfiniBand as a private expressway between servers — no traffic lights, no shared lanes, just direct point-to-point connections running at blistering speed. Precisely, InfiniBand is a high-speed, low-latency network interconnect technology used primarily in HPC (High Performance Computing) clusters and data centers to enable direct memory access (RDMA) between systems. It bypasses the traditional TCP/IP stack, allowing machines to read and write each other's memory directly with minimal CPU involvement.

## Why it matters
In 2014, researchers demonstrated that InfiniBand's RDMA capability could be exploited to exfiltrate data from remote server memory without triggering standard OS-level monitoring or logging — because the CPU is essentially bypassed. This makes InfiniBand fabrics a blind spot in security architectures that rely on host-based detection tools like EDR agents, since malicious memory reads may leave no process-level footprint. Defenders must implement InfiniBand-specific subnet management controls and monitor the Subnet Manager for unauthorized topology changes.

## Key facts
- **RDMA (Remote Direct Memory Access)** is InfiniBand's defining feature — it lets one host read/write another host's RAM without involving the remote CPU or OS, creating forensic blind spots
- InfiniBand uses a **Subnet Manager (SM)** to control network topology; compromising the SM gives an attacker full control over routing and can enable traffic interception
- Default InfiniBand deployments often **lack encryption and authentication**, making them vulnerable to rogue device injection if physical or hypervisor access is obtained
- InfiniBand operates on its own fabric — **separate from Ethernet** — meaning traditional firewall rules and IDS sensors are blind to its traffic
- Commonly found in **AI training clusters, financial HPC, and cloud provider backends** (AWS, Azure use RDMA variants like RoCE), expanding its attack surface

## Related concepts
[[RDMA]] [[Side-Channel Attacks]] [[Network Segmentation]]