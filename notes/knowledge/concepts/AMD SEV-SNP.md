# AMD SEV-SNP

## What it is
Like a bank vault with a tamper-evident seal that proves *no one opened it* even while money was being counted inside — AMD SEV-SNP (Secure Encrypted Virtualization - Secure Nested Paging) is a hardware-level technology that encrypts virtual machine memory *and* cryptographically proves to the VM's owner that the hypervisor hasn't tampered with it. It extends earlier SEV by adding integrity protection and a hardware attestation report signed by AMD's root of trust.

## Why it matters
In a cloud datacenter, a malicious or compromised hypervisor could traditionally read or modify any guest VM's memory — a classic "evil maid" problem scaled to cloud infrastructure. With SEV-SNP, a financial institution can run workloads on Azure or AWS and receive a signed attestation report proving their VM launched unmodified and that memory pages haven't been remapped by the hypervisor — enabling true confidential computing even when the cloud provider itself is untrusted.

## Key facts
- **Reverse Map Table (RMP):** SNP introduces a hardware-enforced table that tracks which VM "owns" each memory page, preventing the hypervisor from secretly remapping guest memory to intercept data.
- **Attestation:** The VM can request a signed measurement report from the AMD Secure Processor (ASP), proving its initial state — this is the cryptographic receipt that enables zero-trust cloud deployments.
- **Integrity gap closed:** Earlier AMD SEV and SEV-ES encrypted memory but didn't prevent hypervisor replay or remapping attacks; SNP's RMP enforcement closes this specific vector.
- **Nested paging protection:** Guest page tables are validated against the RMP on every access, blocking page-fault injection attacks used to exfiltrate data.
- **Confidential Computing standard:** SEV-SNP is a core building block of the Confidential Computing Consortium's model alongside Intel TDX and ARM CCA.

## Related concepts
[[Trusted Execution Environment]] [[Remote Attestation]] [[Hypervisor Security]] [[Intel TDX]] [[Hardware Root of Trust]]