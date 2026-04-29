# Rust

## What it is
Like a bouncer who checks IDs at compile time rather than letting drunk guests cause chaos inside, Rust enforces strict memory ownership rules *before* your program ever runs. It is a systems programming language designed to eliminate entire classes of memory safety vulnerabilities—buffer overflows, use-after-free, and null pointer dereferences—through a compile-time ownership and borrowing model, with no garbage collector required.

## Why it matters
The NSA and CISA have formally recommended organizations migrate away from C/C++ toward memory-safe languages like Rust, citing that roughly 70% of Microsoft and Google's critical vulnerabilities trace back to memory unsafety. When the Android team rewrote components in Rust, memory safety vulnerabilities in those modules dropped to near zero. This makes Rust directly relevant to secure-by-design software development initiatives appearing in modern compliance frameworks.

## Key facts
- **Memory safety without a runtime**: Rust's borrow checker eliminates use-after-free and double-free bugs at compile time—bugs that historically enabled exploits like heap spraying and RCE.
- **No null pointers**: Rust uses `Option<T>` instead of null, eliminating null-dereference vulnerabilities entirely.
- **Adopted in critical infrastructure**: The Linux kernel began accepting Rust in 2022, and the Windows kernel team is actively rewriting components in Rust.
- **CISA "Secure by Design" alignment**: CISA's 2023 guidance explicitly names Rust as a recommended memory-safe language alongside Go, Swift, and Java.
- **Does not prevent logic bugs**: Rust eliminates memory errors but does *not* prevent SQL injection, authentication flaws, or business logic vulnerabilities—a common misconception.

## Related concepts
[[Buffer Overflow]] [[Memory Safety]] [[Secure Software Development Lifecycle]] [[Use-After-Free]] [[Defense in Depth]]