# memory corruption

## What it is
Like a careless librarian who scribbles over existing book entries when adding new ones, memory corruption occurs when a program writes data outside its allocated memory region, overwriting adjacent memory with unintended values. Precisely: it is any condition where a program modifies memory in a way not intended by the programmer, leading to undefined behavior, crashes, or exploitable vulnerabilities.

## Why it matters
The 2021 Chromium V8 engine exploit (CVE-2021-21224) used a type confusion bug — a form of memory corruption — to achieve remote code execution inside the browser sandbox. Attackers who can corrupt memory can overwrite function pointers, return addresses, or security-critical variables to hijack program control flow entirely.

## Key facts
- **Buffer overflow** is the most common type: writing beyond array bounds overwrites adjacent stack or heap memory
- **Use-after-free** bugs occur when code dereferences a pointer after the memory it points to has been freed — a major source of modern browser exploits
- **Heap spraying** is an attacker technique that floods heap memory with shellcode to increase the likelihood that a corrupted pointer lands on malicious data
- **ASLR (Address Space Layout Randomization)** and **DEP/NX (Data Execution Prevention)** are the primary OS-level mitigations, randomizing memory layout and marking data regions non-executable respectively
- Memory corruption vulnerabilities account for ~70% of Microsoft and Google's critical CVEs annually, making them the dominant class of critical software flaws

## Related concepts
[[buffer overflow]] [[use-after-free]] [[ASLR]] [[DEP/NX]] [[heap spraying]]