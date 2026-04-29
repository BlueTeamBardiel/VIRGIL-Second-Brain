# heap spraying

## What it is
Imagine flooding a parking lot with identical cars so that no matter where a blindfolded valet walks, they'll almost certainly open *your* car — that's heap spraying. It's an exploitation technique where an attacker fills a process's heap memory with large quantities of malicious shellcode (wrapped in NOP sleds) to increase the probability that a corrupted pointer will land in attacker-controlled memory and execute the payload.

## Why it matters
In 2010, heap spraying was central to the Aurora attacks targeting Internet Explorer, where attackers exploited a use-after-free vulnerability. Because IE's heap was predictably laid out, spraying shellcode across it made reliable exploitation trivial — turning an uncertain memory corruption bug into a reliable drive-by download attack against Google and dozens of other companies.

## Key facts
- Heap spraying doesn't exploit a vulnerability by itself — it *increases the reliability* of another exploit (e.g., use-after-free, buffer overflow) by making shellcode land predictable.
- NOP sleds (sequences of no-operation instructions) are typically prepended to shellcode to create a wide "landing zone," so imprecise jumps still reach the payload.
- Modern mitigations include **ASLR** (randomizes heap base address) and **safe unlinking** in allocators, which significantly raise the cost of reliable spraying.
- JavaScript and ActionScript were historically the primary vehicles for heap spraying in browsers, since they allow fine-grained heap allocation control.
- **Heap feng shui** is an advanced variant where the attacker carefully shapes heap layout before spraying to achieve even more precise control.

## Related concepts
[[use-after-free]] [[buffer overflow]] [[address space layout randomization]] [[NOP sled]] [[drive-by download]]