# CWE-416 Use-After-Free

## What it is
Imagine handing your apartment key to a new tenant after you've moved out — then walking back in and rearranging furniture as if you still live there. Use-After-Free occurs when a program frees a block of memory but retains a pointer to it, then later dereferences that pointer after the memory may have been reallocated to something else. An attacker who controls what gets written into that recycled memory can hijack execution flow.

## Why it matters
CVE-2021-21166, a Use-After-Free in Google Chrome's audio component, was exploited in the wild before a patch existed. Attackers crafted malicious audio processing sequences that caused Chrome to free an object, then triggered reallocation of that memory with attacker-controlled data — effectively redirecting the instruction pointer and achieving remote code execution with renderer privileges. This class of bug is why browser sandboxing and heap isolation exist.

## Key facts
- **Root cause**: No nullification of dangling pointers after `free()` — the pointer still "knows" the old address but the allocator may hand that memory to someone else.
- **Impact tier**: Can lead to arbitrary code execution, privilege escalation, or information disclosure — ranked as High/Critical severity consistently by CVSS.
- **Mitigations**: Heap isolation, safe memory languages (Rust), setting pointers to `NULL` after freeing, and Address Sanitizer (ASan) during development catch many instances.
- **Exploitation technique**: Heap spraying is commonly paired with UAF — attackers flood the heap with shellcode/fake objects so the dangling pointer reliably lands on controlled data.
- **Detection**: Static analysis tools (Coverity, CodeQL) and fuzzing with memory sanitizers are primary detection strategies in SDL pipelines.

## Related concepts
[[CWE-476 Null Pointer Dereference]] [[Heap Spraying]] [[Memory-Safe Languages]] [[Buffer Overflow]] [[ASLR Bypass]]