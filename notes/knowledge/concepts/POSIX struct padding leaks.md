# POSIX struct padding leaks

## What it is
Like a moving company that packs boxes with crumpled newspaper to fill gaps — the CPU inserts silent filler bytes between struct fields to keep data aligned in memory, and those filler bytes are never zeroed out. Precisely: POSIX struct padding leaks occur when kernel or userspace code copies a C struct to userspace (e.g., via `ioctl` or `read`) without first zeroing the struct, leaving uninitialized stack or heap bytes — the "newspaper" — readable by the user.

## Why it matters
The classic exploit is leaking kernel stack memory through poorly initialized structs passed to userspace via syscalls. In CVE-2010-3081 (Linux `compat` layer), padding bytes in a copied struct exposed kernel stack contents, enabling an attacker to defeat KASLR by recovering kernel addresses from the leaked bytes, then chaining with a privilege escalation exploit.

## Key facts
- Padding bytes are inserted by the compiler to satisfy CPU alignment requirements (e.g., a `char` followed by an `int` gets 3 pad bytes on x86).
- The correct mitigation is `memset(struct, 0, sizeof(struct))` before populating fields — or using `__attribute__((packed))` cautiously (introduces unaligned access penalties).
- Linux kernel enforces `CONFIG_INIT_STACK_ALL` (Clang) or `CONFIG_GCC_PLUGIN_STRUCTLEAK` to auto-zero structs before use.
- These leaks are an **information disclosure** vulnerability class — they don't directly give code execution but are critical for defeating ASLR/KASLR.
- `copy_to_user()` does not zero padding — the burden is on the developer to sanitize before calling it.

## Related concepts
[[information disclosure vulnerability]] [[kernel ASLR bypass]] [[memory initialization flaws]] [[stack data leakage]] [[ioctl attack surface]]