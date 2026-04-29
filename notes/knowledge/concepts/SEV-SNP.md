# SEV-SNP

## What it is
Imagine renting a safe-deposit box at a bank where even the bank employees cannot open it — that's SEV-SNP for virtual machines. AMD's Secure Encrypted Virtualization with Secure Nested Paging is a hardware-level technology that cryptographically isolates VM memory from the hypervisor, host OS, and other VMs, while also providing attestation that the VM hasn't been tampered with at launch.

## Why it matters
In a multi-tenant cloud environment, a malicious or compromised hypervisor could traditionally read any guest VM's memory — think credential theft, key extraction, or code injection. SEV-SNP defeats this class of attack by ensuring that even the cloud provider's own infrastructure cannot read or modify a tenant's VM memory, making it foundational to **confidential computing** workloads like processing medical records or financial data on untrusted cloud hardware.

## Key facts
- **Memory encryption**: Each VM gets a unique AES-128 encryption key managed by the AMD Secure Processor, invisible to the hypervisor.
- **Integrity protection**: SNP adds Reverse Map Table (RMP) enforcement, preventing hypervisor-controlled page remapping attacks that could corrupt or spy on guest memory.
- **Remote attestation**: SEV-SNP generates a cryptographically signed attestation report allowing a VM to *prove* its identity and integrity to a remote party before sensitive data is shared.
- **Protects against privileged attackers**: The threat model explicitly includes a malicious hypervisor (ring -1) — a stronger guarantee than traditional encryption or access controls.
- **Adopted by major clouds**: Microsoft Azure confidential VMs and Google Cloud Confidential VMs leverage SEV-SNP as a hardware root of trust.

## Related concepts
[[Trusted Execution Environment (TEE)]] [[Remote Attestation]] [[Confidential Computing]] [[Hypervisor Security]] [[Intel TDX]]