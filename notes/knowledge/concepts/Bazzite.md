# Bazzite

## What it is
Think of Bazzite like a pre-hardened gaming console OS baked into a Linux shell — it comes with sensible defaults locked in before you ever touch it. Bazzite is an immutable, image-based Linux distribution built on Fedora Atomic (formerly Silverblue), specifically designed for gaming on desktops and Steam Deck hardware. Because the core operating system is read-only and delivered as verified container images, system tampering is structurally constrained by design.

## Why it matters
From a defense-in-depth perspective, Bazzite's immutable architecture means that even if malware lands on the system, it cannot persistently modify core OS files — a rebase or reboot to a known-good image effectively evicts most persistence mechanisms. This makes it a compelling case study for how immutable infrastructure principles (common in cloud/DevSecOps environments) can translate to endpoint security, reducing the attack surface that rootkits and bootkits typically exploit.

## Key facts
- **Immutable root filesystem**: The `/usr` directory is read-only at runtime; attackers cannot drop malicious binaries into standard system paths without bypassing significant controls.
- **Cryptographic image verification**: OS updates are delivered as signed OCI container images, supporting supply chain integrity — aligns with concepts tested under CySA+ supply chain risk topics.
- **Layered package model**: User-installed packages are layered separately from the base image, compartmentalizing risk between OS and user-space.
- **Automatic atomic updates**: Updates apply transactionally and are rolled back automatically on failure, supporting availability and integrity goals in the CIA triad.
- **Built on rpm-ostree/bootc**: Uses composefs with fs-verity for image integrity verification, providing tamper evidence at the filesystem layer.

## Related concepts
[[Immutable Infrastructure]] [[Supply Chain Security]] [[Secure Boot]] [[Defense in Depth]] [[Integrity Monitoring]]