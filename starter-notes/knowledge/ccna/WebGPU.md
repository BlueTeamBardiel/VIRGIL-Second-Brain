# WebGPU

## What it is
Like handing a web page the keys to a factory floor full of parallel assembly lines instead of a single worker at a desk — WebGPU is a browser API that grants web applications direct, low-level access to the GPU for high-performance graphics and general-purpose computation. It succeeds WebGL with a modernized architecture mirroring native APIs like Vulkan and Metal, enabling compute shaders to run thousands of threads simultaneously inside the browser sandbox.

## Why it matters
Attackers have weaponized WebGPU's massive parallelism to run password-cracking workloads entirely within a victim's browser tab — no malware download required. A malicious website can silently spin up GPU-accelerated hash-cracking (bcrypt, MD5) or cryptocurrency mining using the visitor's hardware, achieving speeds previously requiring installed software. This makes client-side resource hijacking (cryptojacking) significantly harder to detect than traditional CPU-based browser mining.

## Key facts
- WebGPU enables **GPU compute shaders** from JavaScript, making browser-based cryptojacking 10–100× faster than WebGL-based equivalents
- It operates within the **browser sandbox**, but cross-origin isolation and permission models are still maturing, creating attack surface
- **Timing side-channel attacks** are a documented concern — GPU execution timing can leak information about co-resident workloads, echoing Spectre-class vulnerabilities
- WebGPU is **enabled by default** in Chrome 113+ and Firefox Nightly, significantly expanding the attack surface on end-user machines
- Defenders should monitor for **runaway GPU utilization** in browser processes as an indicator of cryptojacking or abuse

## Related concepts
[[Cryptojacking]] [[Cross-Origin Resource Policy]] [[Side-Channel Attacks]] [[Content Security Policy]] [[Browser Sandbox Escapes]]
