# off-by-one

## What it is
Imagine counting fence posts: a 10-foot fence needs 11 posts, but a tired carpenter installs only 10 — one short. An off-by-one error is the same mistake in code: a loop or boundary check that miscounts by exactly one, using `<` instead of `<=` (or vice versa), causing a program to read or write one element beyond an allocated buffer's legitimate range.

## Why it matters
The 2014 OpenSSL Heartbleed vulnerability is the canonical example — a missing bounds check allowed an attacker to request up to 64KB of memory beyond what was legitimately allocated, leaking private keys, session tokens, and passwords from live server memory. A single off-by-one in the length validation of the HeartbeatRequest message exposed millions of servers to passive data exfiltration without triggering crashes or logs.

## Key facts
- Off-by-one errors are a subclass of **buffer overflow**, but the overflow is exactly one byte/element — enough to overwrite adjacent memory like a saved return address or heap metadata.
- They commonly arise from **incorrect loop bounds** (`i <= length` vs `i < length`) or **null terminator miscounting** in C-style strings.
- Can lead to **heap corruption** or **stack smashing**, enabling code execution, privilege escalation, or information disclosure depending on what occupies adjacent memory.
- Defenses include **address space layout randomization (ASLR)**, **stack canaries**, **bounds-checking compilers** (e.g., `-fsanitize=address` in Clang/GCC), and memory-safe languages like Rust.
- On Security+/CySA+ exams, off-by-one is categorized under **improper input validation** and associated with **memory management vulnerabilities** in the software vulnerability domain.

## Related concepts
[[buffer overflow]] [[heap spraying]] [[integer overflow]] [[memory-safe languages]] [[input validation]]