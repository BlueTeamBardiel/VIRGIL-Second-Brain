# heap spray

## What it is
Imagine filling a parking lot with identical rental cars so that no matter where a valet randomly walks, they'll find one you've rigged — that's heap spraying. It's an exploitation technique where an attacker floods a process's heap memory with repeated copies of malicious shellcode (often padded with NOP sleds), dramatically increasing the probability that a subsequent memory corruption vulnerability (like a use-after-free or buffer overflow) will redirect execution into attacker-controlled code.

## Why it matters
Heap spraying was central to a wave of browser-based drive-by download attacks in the mid-2000s through 2010s — notably exploits targeting Internet Explorer via malicious JavaScript that sprayed the heap before triggering an uninitialized memory vulnerability. Modern defenses like ASLR (Address Space Layout Randomization) and heap hardening in browsers directly emerged as countermeasures to make spray landing zones unpredictable.

## Key facts
- Heap spraying is **not an exploit by itself** — it's a reliability technique paired with a separate memory corruption vulnerability
- Classic spray pattern: large blocks of `NOP sled + shellcode` repeated thousands of times to saturate predictable heap addresses (e.g., targeting `0x0c0c0c0c` in 32-bit Windows processes)
- **JavaScript heap sprays** were dominant because browsers expose fine-grained memory allocation through scripting engines
- **ASLR** directly counters heap spraying by randomizing heap base addresses; however, **information leaks** can defeat ASLR and re-enable spraying
- Modern variants include **JIT spraying**, which abuses Just-In-Time compilers to place attacker-controlled constants into executable memory pages — bypassing DEP/NX protections

## Related concepts
[[buffer overflow]] [[use-after-free]] [[ASLR]] [[DEP (Data Execution Prevention)]] [[shellcode]]