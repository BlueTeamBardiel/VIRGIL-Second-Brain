# VMware Cloud Foundation

## What it is
Think of it as a pre-packaged LEGO set for building a private cloud — every brick (compute, storage, networking, management) snaps together in a validated, automated way. VMware Cloud Foundation (VCF) is an integrated software platform that bundles vSphere, vSAN, NSX, and vRealize into a single stack for deploying and managing Software-Defined Data Centers (SDDC). It can run on-premises, in public cloud, or as a hybrid environment.

## Why it matters
In 2021, a critical authentication bypass vulnerability (CVE-2021-22005) in vCenter Server — a core VCF component — allowed unauthenticated attackers to upload files and achieve remote code execution, hitting thousands of organizations running VCF environments. Because VCF consolidates compute, networking, and storage management under a single control plane, compromising one component can cascade across the entire infrastructure, making patch management and privilege segmentation in VCF deployments a high-priority security concern.

## Key facts
- VCF uses **SDDC Manager** as its central orchestration layer — compromise it and you control provisioning across the entire stack
- **NSX** (network virtualization component) enables micro-segmentation, which is a key Zero Trust defense available within VCF
- VCF supports **Workload Domains**, which isolate different organizational units — misconfigurations here can break intended network separation
- Common attack surface includes **vCenter Server**, **ESXi hypervisors**, and the **vSAN datastore** — all managed through VCF
- Hardening guidance follows **DISA STIG** and **CIS Benchmarks** specific to vSphere components; exam scenarios may test knowledge of principle of least privilege in hypervisor administration

## Related concepts
[[Hypervisor Security]] [[Micro-Segmentation]] [[Privileged Access Management]] [[Software-Defined Networking]] [[CVE Patch Management]]