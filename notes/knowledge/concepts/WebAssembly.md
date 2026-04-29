# WebAssembly

## What it is
Think of it like a universal electrical adapter — it lets code written in any language (C, C++, Rust) plug into any browser regardless of the underlying architecture. WebAssembly (Wasm) is a binary instruction format that runs in a sandboxed virtual machine inside web browsers at near-native speed, separate from but alongside JavaScript.

## Why it matters
Attackers have weaponized WebAssembly to run cryptomining malware (cryptojacking) directly in browsers — the Coinhive campaign embedded Wasm-based Monero miners into compromised websites, hijacking visitor CPU cycles without any download prompt. Because Wasm bytecode is compact and obscured compared to readable JavaScript, traditional signature-based security tools frequently miss it, making behavioral detection essential.

## Key facts
- Wasm runs in a **memory-sandboxed environment**, but supply chain attacks can deliver malicious Wasm modules through compromised npm packages or CDNs
- Unlike JavaScript, Wasm **cannot directly access the DOM** — it must call back through JavaScript bridges, which are themselves attack surfaces for confused deputy attacks
- Wasm modules are **not human-readable** in their binary `.wasm` format, complicating manual code review and static analysis
- Cryptojacking via Wasm is detectable through **anomalous CPU spike monitoring** and network calls to known mining pool endpoints (e.g., `pool.supportxmr.com`)
- Content Security Policy (CSP) headers can restrict Wasm execution using the `'unsafe-eval'` and `'wasm-unsafe-eval'` directives, providing a defensive control

## Related concepts
[[Cryptojacking]] [[Content Security Policy]] [[Supply Chain Attack]] [[Sandbox Escape]] [[JavaScript Security]]