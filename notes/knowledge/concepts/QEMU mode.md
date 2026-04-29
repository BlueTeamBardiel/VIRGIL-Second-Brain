# QEMU mode

## What it is
Think of QEMU mode like a universal travel adapter that lets you plug any foreign device into your wall socket — it lets binaries compiled for one CPU architecture run on a completely different one. Precisely, QEMU mode in AFL++ (and similar fuzzers) uses QEMU's user-space emulation layer to instrument and fuzz closed-source or cross-architecture binaries *without* requiring source code or recompilation. It intercepts execution at the basic-block level, injecting coverage feedback that the fuzzer uses to guide mutation.

## Why it matters
Security researchers reverse-engineering IoT firmware (say, a MIPS-based router running on an x86 workstation) use QEMU mode to fuzz proprietary binaries they can't recompile — discovering memory corruption bugs like buffer overflows in network parsing routines without ever touching source code. This technique was used to uncover vulnerabilities in embedded device firmware that vendors considered "safe" because their binaries were opaque.

## Key facts
- AFL++ QEMU mode runs at roughly **2–5× slower** than source-instrumented fuzzing due to dynamic translation overhead
- It operates in **user-space emulation**, not full system emulation — meaning it handles single processes, not entire OS environments
- QEMU mode supports multiple architectures including **ARM, MIPS, PowerPC, and x86** — critical for IoT/embedded security testing
- Coverage tracking is implemented by **patching translation blocks (TBs)** at runtime rather than at compile time
- It is a form of **grey-box fuzzing** — the binary remains closed-source, but execution feedback is still collected dynamically

## Related concepts
[[Fuzzing]] [[AFL++]] [[Binary Analysis]] [[Dynamic Instrumentation]] [[Firmware Analysis]]