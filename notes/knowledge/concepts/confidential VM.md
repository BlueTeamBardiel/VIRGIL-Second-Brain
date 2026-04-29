# Confidential VM

## What it is
Like a bank vault inside a bank building — even the building's owner can't see what's inside — a Confidential VM encrypts a virtual machine's memory and CPU state so that even the cloud hypervisor and host OS cannot read it. Specifically, it uses hardware-based Trusted Execution Environments (TEEs) such as AMD SEV (Secure Encrypted Virtualization) or Intel TDX to cryptographically isolate the VM's workload at the silicon level.

## Why it matters
A malicious cloud insider or a compromised hypervisor could traditionally perform a cold-boot attack or memory dump to extract sensitive data — encryption keys, PII, financial records — from a running VM. Confidential VMs defeat this attack class because memory is encrypted with keys held inside the CPU itself, never exposed to the host software stack, making hypervisor-level snooping cryptographically futile.

## Key facts
- **Hardware root of trust**: Encryption keys are generated and managed inside the CPU's secure processor, never accessible to the host OS or VMM (Virtual Machine Monitor).
- **AMD SEV-SNP** adds memory integrity protection and prevents replay attacks on top of basic encryption, addressing earlier SEV vulnerabilities.
- **Remote attestation** allows tenants to cryptographically verify that their VM is running on genuine, unmodified TEE hardware before sending sensitive data.
- **Threat model boundary**: Confidential VMs protect against privileged software adversaries (hypervisor, cloud admin) but do NOT protect against vulnerabilities inside the guest OS itself.
- **Regulatory relevance**: Increasingly cited in GDPR and HIPAA compliance frameworks as a control for processing sensitive data in multi-tenant cloud environments.

## Related concepts
[[Trusted Execution Environment]] [[Remote Attestation]] [[Hypervisor Security]] [[Hardware Security Module]] [[Zero Trust Architecture]]