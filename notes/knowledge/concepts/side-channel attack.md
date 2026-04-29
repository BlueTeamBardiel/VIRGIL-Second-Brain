# side-channel attack

## What it is
Like a safecracker who ignores the combination lock and instead listens to the clicks and feels the resistance — a side-channel attack extracts secrets not by breaking the algorithm, but by observing *physical byproducts* of its execution. Instead of attacking cryptographic math directly, the attacker measures timing, power consumption, electromagnetic emissions, or even acoustic noise to infer secret keys or plaintext.

## Why it matters
In 2017, researchers demonstrated a cache-timing side-channel attack called **Meltdown/Spectre** that allowed unprivileged processes to read kernel memory by exploiting CPU speculative execution timing differences. This affected virtually every modern processor and required OS-level patches that temporarily degraded performance — showing that hardware-level side channels can invalidate software security guarantees entirely.

## Key facts
- **Timing attacks** exploit measurable differences in how long operations take (e.g., RSA private key operations that branch on bit values leak key bits through latency).
- **Power analysis attacks** (Simple/Differential Power Analysis — SPA/DPA) measure a device's power draw during cryptographic operations; DPA uses statistical analysis across many measurements to recover AES keys from smart cards.
- **Cold boot attacks** are a physical side-channel: RAM retains data for seconds to minutes after power loss, allowing encryption keys to be extracted from a "frozen" chip.
- **TEMPEST** is the NSA/NATO codename for standards that protect against electromagnetic emanation side-channels — shielded rooms and equipment reduce signal leakage.
- Countermeasures include **constant-time algorithms** (no secret-dependent branches), **masking/blinding** (randomizing intermediate values), and physical shielding.

## Related concepts
[[cryptographic attack]] [[cache poisoning]] [[hardware security module]] [[speculative execution]] [[covert channel]]