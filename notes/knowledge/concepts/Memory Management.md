# memory management

## What it is
Think of RAM like a hotel with numbered rooms — the OS is the front desk that assigns rooms to guests (processes) and reclaims them when guests check out. Memory management is the operating system's system for allocating, tracking, and releasing RAM to running processes, ensuring one process cannot read or write another's "room" without permission.

## Why it matters
Flawed memory management is the root cause of buffer overflow attacks — when a program fails to check input size, an attacker can write data past the end of an allocated buffer into adjacent memory, overwriting return addresses and hijacking execution flow. This class of vulnerability enabled exploits like the Morris Worm (1988) and remains a primary attack vector in modern malware. Defenses like ASLR (Address Space Layout Randomization) and DEP (Data Execution Prevention) exist specifically to make memory exploitation harder.

## Key facts
- **ASLR** randomizes where code, stack, and heap are loaded in memory, making it harder for attackers to predict target addresses for exploitation
- **DEP/NX bit** marks memory regions as either executable OR writable — never both — preventing shellcode injection into data segments
- **Use-after-free** vulnerabilities occur when a program accesses memory after it has been freed/deallocated, a common source of exploitable crashes
- **Heap vs. Stack**: Stack memory is function-scoped and auto-managed; heap is dynamically allocated and must be manually freed — heap bugs (like double-free) are notoriously dangerous
- **Memory leaks** (allocated memory never freed) don't cause direct compromise but can exhaust resources, enabling denial-of-service conditions

## Related concepts
[[buffer overflow]] [[address space layout randomization]] [[data execution prevention]]