# SEV

## What it is
Like a bank vault inside a bank — even if a robber gets past the guards (the hypervisor), each safety deposit box (VM) remains independently locked. AMD Secure Encrypted Virtualization (SEV) is a hardware-level feature in AMD EPYC processors that encrypts the memory of each virtual machine with a unique key managed by a dedicated on-chip security processor. Even a compromised or malicious hypervisor cannot read plaintext guest VM memory.

## Why it matters
In a cloud environment, a rogue cloud administrator or a hypervisor vulnerability (like CVE-2021-26311) could theoretically allow one tenant's VM to read another tenant's memory — exposing cryptographic keys, passwords, or PII. SEV directly mitigates this threat by ensuring guest memory remains encrypted at rest in DRAM, so even a successful hypervisor compromise yields only ciphertext. This is critical for regulated workloads (HIPAA, PCI-DSS) running on shared infrastructure.

## Key facts
- SEV uses a per-VM 128-bit AES encryption key generated and stored entirely within the AMD Secure Processor (AMD-SP), never exposed to the hypervisor
- SEV-ES (Encrypted State) extends protection to CPU register state, preventing the hypervisor from reading register values during VM exits
- SEV-SNP (Secure Nested Paging) adds memory integrity protection, defending against replay and remapping attacks that could bypass plain SEV
- SEV is a **Confidential Computing** technology — part of the broader industry push (alongside Intel TDX and ARM CCA) to protect data-in-use
- Known attack: "CVMmap" and similar research demonstrated that without SNP, an attacker controlling the hypervisor could manipulate page mappings to extract data despite SEV encryption

## Related concepts
[[Trusted Execution Environment]] [[Hypervisor Security]] [[Confidential Computing]] [[Hardware Security Module]] [[Virtual Machine Escape]]