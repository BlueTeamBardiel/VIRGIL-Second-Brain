# kernel.org

## What it is
Think of it as the official post office for the Linux operating system's source code — every legitimate Linux kernel ships from this address. kernel.org is the canonical, authoritative distribution point for Linux kernel source code, maintained by the Linux Kernel Organization, a nonprofit that hosts and distributes the kernel to developers and vendors worldwide.

## Why it matters
In 2011, kernel.org itself was compromised: attackers gained root access to multiple servers using a stolen credential and a trojanized SSH binary (a rootkit named "Phalanx2"), potentially allowing malicious modifications to kernel source before distribution. Although no source code tampering was confirmed, the incident illustrated the catastrophic supply chain risk of compromising a trusted upstream source — every downstream Linux distribution and device could theoretically receive poisoned code. This is a textbook example of a **supply chain attack** targeting software distribution infrastructure.

## Key facts
- kernel.org hosts signed kernel releases using **GPG (GNU Privacy Guard)** — always verify signatures before building from source
- The 2011 breach was detected via a **Trojanized SSH daemon** that logged credentials; forensic analysis found the rootkit `Phalanx2`
- Compromise of kernel.org represents a **Tier-1 supply chain threat** because thousands of Linux distributions pull source directly from it
- Kernel releases follow a **versioning scheme**: `major.minor.patch` (e.g., 6.8.2), with stable, longterm (LTS), and mainline branches
- Integrity verification uses **SHA-256 checksums + PGP-signed tags** in the Git repository — skipping this step is a critical operational security failure

## Related concepts
[[Supply Chain Attack]] [[Code Signing]] [[Rootkit]] [[Integrity Verification]] [[Software Bill of Materials (SBOM)]]