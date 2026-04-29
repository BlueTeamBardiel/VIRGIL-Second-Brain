# heap buffer overflow

## What it is
Imagine a warehouse where workers keep stacking boxes past the designated storage zone, crushing whatever is stored in the adjacent bay. A heap buffer overflow occurs when a program writes data beyond the boundaries of a dynamically allocated memory region (the heap), corrupting adjacent heap chunks, metadata, or pointers. Unlike stack overflows, the heap holds runtime objects and allocator bookkeeping structures rather than return addresses.

## Why it matters
The 2014 Heartbleed vulnerability (CVE-2014-0160) in OpenSSL was a heap buffer over-read — a close cousin — that let attackers request up to 64KB of adjacent heap memory from a server, leaking private keys, session tokens, and credentials without leaving a trace in logs. Defenders responded by patching immediately and revoking potentially compromised TLS certificates globally, affecting roughly 17% of the internet's HTTPS servers at the time.

## Key facts
- Heap overflows target **dynamically allocated memory** (malloc/new), making exploitation more complex than stack overflows but often more powerful against modern systems
- Attackers can overwrite **heap metadata** (chunk headers, free-list pointers) to hijack control flow through a technique called *heap feng shui* or heap grooming
- Common mitigations include **heap canaries**, **safe unlinking checks**, **ASLR** (randomizes heap base address), and **Guard Pages** between allocations
- Languages like C and C++ are most vulnerable; memory-safe languages (Rust, Go) eliminate this class by design
- On Security+/CySA+ exams, heap overflows fall under **buffer overflow attacks** and are linked to **improper input validation** as their root cause CWE (CWE-122)

## Related concepts
[[buffer overflow]] [[use-after-free]] [[ASLR]] [[memory corruption]] [[fuzzing]]