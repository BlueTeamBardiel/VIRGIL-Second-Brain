# Zen 5

## What it is
Like a new skyscraper built with the same city blueprint but taller floors and wider corridors, Zen 5 is AMD's fifth-generation CPU microarchitecture (2024), featuring a redesigned front-end, doubled AVX-512 throughput, and significant IPC (Instructions Per Clock) improvements over Zen 4.

## Why it matters
New microarchitectures introduce new attack surfaces. Zen 5's redesigned branch predictor and expanded execution units create fresh territory for speculative execution side-channel attacks — researchers must re-evaluate whether mitigations effective on Zen 4 (like retpoline for Spectre variant 2) remain sufficient, since microarchitectural changes can invalidate prior assumptions and reopen previously patched speculative execution windows.

## Key facts
- Zen 5 introduces a wider 21-stage pipeline and dual 512-bit AVX pipelines, increasing cryptographic operation throughput but also expanding the speculative execution attack surface
- New microarchitectures require **re-certification** of hardware-level mitigations; security teams should monitor CPU vendor microcode updates post-launch, as AMD typically patches speculative execution flaws via microcode
- AVX-512 acceleration on Zen 5 significantly speeds up AES-NI and SHA operations, benefiting both defenders (faster encryption) and attackers (faster password cracking with tools like Hashcat)
- AMD's **Secure Encrypted Virtualization (SEV-SNP)**, present in Zen 5 server variants, provides hardware-enforced VM memory isolation — relevant for cloud security and zero-trust architecture designs
- Side-channel research timelines: new architectures typically see academic disclosure of microarchitecture-specific vulnerabilities within 12–24 months of release, emphasizing proactive patch management

## Related concepts
[[Spectre and Meltdown]] [[Speculative Execution Attacks]] [[Secure Encrypted Virtualization (SEV)]] [[Side-Channel Attacks]] [[Microcode Updates]]