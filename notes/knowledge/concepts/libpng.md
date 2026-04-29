# libpng

## What it is
Think of libpng as the universal translator that every application uses to decode PNG images — like a shared town interpreter everyone trusts implicitly. It is an open-source C library that handles reading, writing, and manipulating PNG (Portable Network Graphics) files, and it is bundled into browsers, operating systems, image editors, and embedded devices worldwide.

## Why it matters
In 2011, a heap overflow vulnerability (CVE-2011-3026) in libpng allowed attackers to trigger remote code execution by crafting a malicious PNG file — simply opening an image in a vulnerable browser was enough to compromise a system. This is a textbook supply chain risk: one vulnerable shared library propagated into Chrome, Firefox, iOS, and Android simultaneously, requiring coordinated emergency patching across the entire industry.

## Key facts
- **Integer overflow vulnerability class**: Many libpng CVEs stem from integer overflows during chunk size calculations, leading to heap buffer overflows — a classic unsafe C pattern.
- **Widely embedded**: libpng is a transitive dependency in countless applications; a single flaw becomes a multi-platform emergency requiring mass patching.
- **Malicious file as attack vector**: No network service needed — a crafted PNG delivered via email, web page, or USB can trigger exploitation (file-format attack vector).
- **Memory corruption primitives**: Exploits typically yield heap corruption, enabling ACE (Arbitrary Code Execution) or at minimum a denial-of-service crash.
- **Defense**: Mitigations include ASLR, DEP/NX, stack canaries, and sandboxing image-parsing processes (Chrome uses renderer process isolation partly for this reason).

## Related concepts
[[Buffer Overflow]] [[Supply Chain Attack]] [[Integer Overflow]] [[Memory Safe Languages]] [[CVE]]