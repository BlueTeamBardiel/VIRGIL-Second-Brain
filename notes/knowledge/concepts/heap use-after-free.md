# heap use-after-free

## What it is
Imagine a hotel room key that still opens the door after checkout — someone else has moved in, but your old key still works. A heap use-after-free vulnerability occurs when a program frees a block of dynamically allocated memory but retains a pointer to it, then later dereferences that pointer after the allocator may have given that memory to something else. The attacker's goal is to control what gets placed in that recycled memory slot to hijack program execution.

## Why it matters
The 2021 Chrome zero-day CVE-2021-21166 was a heap use-after-free in the Web Audio API — attackers crafted malicious audio graphs that triggered the freed pointer, achieving remote code execution in the renderer process. Browser sandboxing limited the blast radius, but chaining it with a sandbox escape delivered full compromise. This pattern — use-after-free leading to RCE — is one of the most common CVE classes in modern browsers and kernels.

## Key facts
- The vulnerability lives in the **heap** (dynamic memory via `malloc`/`new`), not the stack — making it harder to detect with simple stack canaries
- Exploitation typically works by spraying the heap with attacker-controlled data so it occupies the freed slot before the dangling pointer is used (a technique called **heap spraying**)
- Mitigations include **memory-safe languages** (Rust), **Address Sanitizer (ASan)** for detection, and **delayed/quarantined free lists** that prevent immediate reuse
- Windows implements **safe unlinking** and **heap metadata cookies** to make exploitation harder, but not impossible
- CVE severity is frequently **Critical (CVSS 9.0+)** when it leads to arbitrary code execution

## Related concepts
[[heap overflow]] [[memory corruption]] [[dangling pointer]] [[heap spraying]] [[address space layout randomization]]