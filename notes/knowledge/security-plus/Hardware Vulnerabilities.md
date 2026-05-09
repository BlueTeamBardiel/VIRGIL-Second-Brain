# Hardware Vulnerabilities

## What it is

In Among Us, the Impostor doesn't have to hack the crew — they just crawl through the vents the ship was built with. The vents aren't a bug; they're literally part of the hull. That's exactly what hardware vulnerabilities do — they're flaws baked into the physical components themselves, so no software patch fully seals them.

A **hardware vulnerability** is a weakness in firmware, silicon, peripheral, or embedded device design that an attacker can exploit at a layer below the operating system, often persisting through reinstalls and evading software-based defenses.

## Why it matters

Hardware flaws survive what software cannot kill: reformats, OS reinstalls, and most EDR tools. A compromised [[BIOS]], [[UEFI]] bootloader, or [[BMC]] gives an attacker pre-boot persistence — the malware loads before your antivirus even exists. Compliance frameworks like [[PCI-DSS]], [[FIPS 140-3]], and federal supply-chain rules (NDAA Section 889) penalize organizations that fail to inventory and patch firmware.

**Exam angle:** SY0-701 Objective 2.3 lists *firmware*, *end-of-life*, and *legacy* as hardware-vulnerability categories. CompTIA's favorite trap: distinguishing **end-of-life** (vendor still ships it but plans to stop) from **legacy** (still in production use but no longer supported). Also expect questions where the "right answer" is *replace the device* because no patch exists.

## Key facts

### Categories CompTIA tests

| Category | Meaning | Example |
|---|---|---|
| **Firmware** | Software embedded in hardware ([[BIOS]]/[[UEFI]], NIC, drive controllers) | Unsigned firmware update accepting malicious image |
| **End-of-life (EOL)** | Vendor has announced or reached end of support | Windows Server 2012 hardware running no-longer-patched [[iLO]] |
| **Legacy** | Still in operational use but unsupported, often irreplaceable | SCADA controller from 2004 in a water plant |

### Firmware-level threats

- **[[Bootkit]]** — malware in the boot sector or [[UEFI]] firmware; survives OS reinstall. Defense: [[Secure Boot]], [[Measured Boot]], [[TPM]] attestation.
- **[[Rootkit]]** — kernel- or firmware-level concealment; ring 0 or below.
- **[[BMC]] / [[IPMI]] compromise** — out-of-band management chips on servers (iLO, iDRAC) with their own CPU and network stack. Often forgotten, rarely patched, fully owns the host.
- **Peripheral firmware attacks** — [[BadUSB]], malicious cable implants, NIC firmware backdoors.

### Silicon-level vulnerabilities

| Flaw | What it exploits | Mitigation |
|---|---|---|
| **[[Spectre]]** | Speculative execution / branch prediction | Microcode updates, compiler fixes |
| **[[Meltdown]]** | CPU privilege boundary bypass | KPTI / KAISER kernel patches |
| **[[Rowhammer]]** | DRAM bit-flipping by repeated row access | ECC memory, refresh-rate hardening |

These cannot be fully patched in software — they're physics meeting bad assumptions. Mitigations cost performance.

### Defenses to recognize

- **[[Secure Boot]]** — only signed bootloaders execute.
- **[[TPM]] (Trusted Platform Module)** — hardware root of trust; stores keys, performs attestation.
- **[[HSM]] (Hardware Security Module)** — dedicated cryptographic processor; tamper-evident.
- **[[Hardware Root of Trust]]** — immutable component that anchors all later trust decisions.
- **Firmware signing & update validation** — vendor signs, device verifies before flashing.
- **[[Asset Inventory]]** — you cannot patch what you do not know you own. EOL/legacy hunts begin here.
- **[[Compensating Controls]]** — when you can't replace the legacy SCADA box: network segmentation, [[jump server]] access only, strict ACLs.

### The exam-trap pattern

When the question describes an unsupported device that cannot be replaced (medical imaging, industrial control), the answer is rarely "patch it." It's **isolate it via segmentation** or **apply compensating controls**. Memorize this reflex.

## Related concepts

[[Firmware]] · [[UEFI]] · [[Secure Boot]] · [[TPM]] · [[HSM]] · [[Supply Chain Attack]] · [[End-of-Life Systems]] · [[Legacy Systems]] · [[Spectre]] · [[Meltdown]] · [[BadUSB]] · [[BMC]] · [[Compensating Controls]] · [[Patch Management]]

---
*Source: VIRGIL knowledge base — 2026-05-08*