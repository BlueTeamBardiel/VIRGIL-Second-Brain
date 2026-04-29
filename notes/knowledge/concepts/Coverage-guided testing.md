# Coverage-guided testing

## What it is
Like a spelunker marking every tunnel explored so they never retrace steps and always push deeper into unmapped caves, coverage-guided testing tracks which code paths a fuzzer has already executed and steers new inputs toward unexplored branches. Precisely: it is a dynamic testing technique where an instrumented target feeds back code coverage data (which functions, branches, or basic blocks were hit) to the fuzzer, which then mutates inputs that expand coverage rather than repeating known paths. AFL (American Fuzzy Lop) pioneered this approach by using compile-time instrumentation to measure edge coverage between basic blocks.

## Why it matters
In 2014, coverage-guided fuzzing with AFL discovered the **Heartbleed** vulnerability class — and since then, Google's OSS-Fuzz platform uses it continuously against open-source libraries, having found over 10,000 vulnerabilities in projects like OpenSSL, libpng, and the Linux kernel. Without coverage feedback, a fuzzer randomly hammers inputs and rarely reaches the deep parsing logic where memory corruption bugs hide; with it, the fuzzer systematically finds the exact 12-byte crafted packet that triggers a buffer overflow in rarely-executed error-handling code.

## Key facts
- AFL uses **shared memory bitmaps** to record branch transitions (from-block → to-block pairs), giving fine-grained path feedback with minimal overhead
- Coverage is typically measured at **basic block**, **branch**, or **edge** granularity — edge coverage is most common because it distinguishes loop iterations
- Instrumentation can be **compile-time** (source available, e.g., afl-clang) or **binary-only** (using QEMU or Intel PIN when source is unavailable)
- A "corpus" of seed inputs is maintained and trimmed; inputs that discover new coverage are added, creating a feedback loop that compounds path discovery
- **LibFuzzer** and **honggfuzz** are modern alternatives using sanitizers (AddressSanitizer, MemorySanitizer) alongside coverage guidance to both find and characterize bugs

## Related concepts
[[Fuzzing]] [[Dynamic analysis]] [[Memory corruption vulnerabilities]]