# Out-of-Bounds Write

## What it is
Imagine a parking lot attendant who, when lot 5 is full, starts parking cars in the fire lane next door — overwriting whatever was there. An out-of-bounds write occurs when a program writes data beyond the allocated boundaries of a buffer or array, corrupting adjacent memory regions it was never authorized to touch.

## Why it matters
The 2014 Heartbleed vulnerability (CVE-2014-0160) demonstrated a related memory mishandling pattern, but a cleaner example is CVE-2021-21985 in VMware vCenter — an out-of-bounds write allowed unauthenticated remote attackers to execute arbitrary code by overwriting function pointers in adjacent memory, achieving full server compromise. Defenders patch these by enforcing memory-safe languages (Rust, Go) or compiler mitigations like AddressSanitizer.

## Key facts
- **CWE-787** is the official classification for out-of-bounds write; it has ranked #1 or #2 on MITRE's CWE Top 25 Most Dangerous Software Weaknesses for multiple consecutive years
- Attackers exploit this to overwrite **return addresses**, **function pointers**, or **security flags** in adjacent memory, enabling arbitrary code execution or privilege escalation
- Common root causes include missing bounds checks, incorrect loop termination conditions, and unsafe C/C++ functions like `strcpy()` and `memcpy()`
- Mitigations include **stack canaries**, **ASLR** (Address Space Layout Randomization), **DEP/NX** (Data Execution Prevention), and compile-time bounds checking
- Distinguishable from **out-of-bounds read** (CWE-125): a read leaks data (like Heartbleed), while a write actively corrupts memory and is typically more severe

## Related concepts
[[Buffer Overflow]] [[Stack Canary]] [[Address Space Layout Randomization]] [[Memory Corruption]] [[Heap Overflow]]