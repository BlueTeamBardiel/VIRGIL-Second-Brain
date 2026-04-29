# VMware vCenter

## What it is
Think of vCenter as the air traffic control tower for an entire fleet of virtual machines — one centralized cockpit that directs every takeoff, landing, and routing decision across dozens of ESXi hypervisor "runways." Precisely, VMware vCenter Server is a centralized management platform that allows administrators to provision, monitor, and control multiple VMware ESXi hypervisors and their guest virtual machines from a single interface. It sits above the hypervisor layer, making it infrastructure-critical rather than just convenient.

## Why it matters
In 2021, CVE-2021-21985 allowed unauthenticated remote code execution against vCenter Server via a vulnerable plugin — attackers who exploited it gained control of the management plane, meaning every VM across the entire environment was potentially compromised from a single HTTP request. This illustrates the "crown jewel" problem: compromise the management layer, and the entire virtualized infrastructure falls without touching individual machines. Defenders prioritize network-segmenting vCenter, applying patches immediately, and disabling unused plugins.

## Key facts
- vCenter communicates with ESXi hosts over **port 443 (HTTPS)** and **port 902 (ESXi agent traffic)**
- The **vCenter Server Appliance (VCSA)** is the Linux-based deployment model that replaced the Windows-based version as the preferred install
- Credential theft from vCenter is particularly damaging because vCenter often holds **stored credentials and SSH keys** for all managed hosts
- CVEs against vCenter frequently fall into **CVSS 9.0+** due to the blast radius of management-plane compromise
- Attackers targeting VMware environments often chain **vCenter RCE → ESXi ransomware deployment** (e.g., ESXiArgs campaign, 2023)

## Related concepts
[[Hypervisor Security]] [[Privilege Escalation]] [[Attack Surface Management]] [[Lateral Movement]] [[CVE Scoring (CVSS)]]