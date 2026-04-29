# Use After Free

## What it is
Imagine returning a library book, then the librarian hands it to someone else — but you still have a bookmark in it and keep writing notes in what you think is "your" copy. Use After Free (UAF) is a memory corruption vulnerability where a program continues to reference a memory address after that memory has been freed and potentially reallocated to another object, causing unpredictable or attacker-controlled behavior.

## Why it matters
CVE-2021-21166, a UAF vulnerability in Google Chrome's audio component, was actively exploited in the wild before a patch existed. Attackers crafted malicious web pages that triggered the freed memory to be reallocated with attacker-controlled data, achieving remote code execution — effectively hijacking the browser by poisoning the recycled memory slot.

## Key facts
- **Root cause:** Programs using C/C++ manually manage memory; failing to null out a pointer after `free()` leaves a "dangling pointer" that can be exploited
- **Exploitation chain:** Attacker triggers the free, then uses a second allocation to fill the freed region with shellcode or a fake object, then triggers the dangling pointer dereference
- **Impact:** Can lead to arbitrary code execution, privilege escalation, or information disclosure — often rated Critical (CVSS 9+)
- **Mitigations:** Address Space Layout Randomization (ASLR), heap isolation (e.g., Chrome's PartitionAlloc), memory-safe languages (Rust), and pointer nullification after `free()`
- **Detection:** Fuzzing tools like AddressSanitizer (ASan) are specifically designed to catch UAF bugs during development by poisoning freed memory regions

## Related concepts
[[Buffer Overflow]] [[Heap Spraying]] [[Memory-Safe Languages]] [[ASLR]] [[Dangling Pointer]]