---
domain: "application-security"
tags: [attack, memory-corruption, exploitation, application-security, security-plus, vulnerabilities]
---
# Buffer Overflows

A **buffer overflow** (also called a *buffer overrun*) is a [[Memory Corruption|memory corruption vulnerability]] in which a program writes data beyond the allocated boundary of a fixed-size region of memory, trampling adjacent memory and potentially allowing an attacker to hijack program execution. First weaponized at scale by the 1988 [[Morris Worm]], buffer overflows remain one of the most consequential classes of software vulnerability, sitting at the root of countless [[Remote Code Execution|remote code execution]] exploits against C- and C++-based software. They exist because languages like **C** and **C++** expose raw pointers and perform no automatic bounds checking on array or pointer operations.

---

## Overview

Buffer overflows arise when a program copies more bytes into a fixed-size region of memory than that region was allocated to hold. In memory-safe languages — Java, C#, Go, Python, and Rust's safe subset — the runtime or compiler enforces bounds checking, and a write past the end of an array raises an exception or a panic at runtime. In C and C++, primitives like `strcpy`, `strcat`, `sprintf`, `gets`, and `memcpy` perform no such check; extra bytes silently overwrite whatever memory happens to sit adjacent to the target buffer. That neighboring memory may hold other local variables, frame pointers, saved return addresses, function pointers, heap allocator metadata, or C++ virtual-table pointers — any of which an attacker can manipulate to redirect control flow.

Historically, buffer overflows are the single most destructive class of software vulnerability ever cataloged. The **Morris Worm (1988)** exploited a stack overflow in the BSD `fingerd` daemon caused by an unchecked call to `gets()`. **Code Red (2001)** spread via a stack overflow in Microsoft IIS's ISAPI Indexing Service extension, infecting 359,000 hosts in 14 hours. **SQL Slammer (2003)** used a single 376-byte UDP packet targeting a stack overflow in Microsoft SQL Server's resolution service (UDP/1434) to double its infection count every 8.5 seconds, blanketing 75,000 hosts in minutes. **EternalBlue (CVE-2017-0144)** — later weaponized by WannaCry and NotPetya — exploited a pool overflow in Windows SMBv1. All of these share the same root cause: unbounded memory writes.

The vulnerability class is closely related to several cousin bugs: [[Integer Overflow|integer overflows]] that produce undersized allocations, [[Use After Free|use-after-free]] on the heap, [[Off-by-One Errors|off-by-one fencepost errors]], and [[Format String Vulnerabilities|format string bugs]]. Together, these are termed **memory-safety vulnerabilities**. Modern analysis from Microsoft's Security Response Center, Google's Project Zero, and the U.S. [[CISA]] consistently finds that roughly **70% of severe security bugs** in large C/C++ codebases are memory safety issues, forming the basis for industry-wide pushes toward memory-safe languages.

Buffer overflows divide into two primary families by memory region. A **stack-based overflow** targets automatic (local) variables stored on the call stack; the classic goal is overwriting the saved return address so that `ret` transfers control to attacker-controlled code or a ROP chain. A **heap-based overflow** targets dynamically allocated memory from `malloc` or `new`; it typically corrupts heap allocator metadata, adjacent object fields, or vtable pointers to achieve an arbitrary write primitive or hijack an indirect call. Heap exploits are generally more complex because they depend on allocator internals — glibc's ptmalloc, Windows' Low Fragmentation Heap, jemalloc — but yield the same end result.

Even with modern mitigations making naive stack exploitation difficult, buffer overflows remain the *starting primitive* for sophisticated [[Return-Oriented Programming|ROP chains]], [[Jump-Oriented Programming|JOP]] attacks, and multi-stage exploits used in kernel, browser, and hypervisor compromises. The fundamental bug has not changed in 40 years; what has changed is the complexity required to weaponize it.

---

## How It Works

### The Stack Layout

Consider a canonical vulnerable C function:

```c
#include <stdio.h>
#include <string.h>

void vulnerable(const char *input) {
    char buffer[64];
    strcpy(buffer, input);          // no bounds check — root cause
    printf("You said: %s\n", buffer);
}

int main(int argc, char **argv) {
    if (argc > 1) vulnerable(argv[1]);
    return 0;
}
```

When `vulnerable()` is called on an x86-64 Linux system, the call stack (growing downward toward lower addresses) is arranged roughly as follows:

```
High addresses
┌──────────────────────┐
│  caller's frame      │
├──────────────────────┤
│  saved return addr   │  ← 8 bytes — overwriting this hijacks RIP
├──────────────────────┤
│  saved RBP           │  ← 8 bytes
├──────────────────────┤
│  char buffer[64]     │  ← strcpy writes here, upward toward return addr
└──────────────────────┘
Low addresses
```

If an attacker supplies a 200-byte argument, `strcpy` copies all 200 bytes: the first 64 fill `buffer`, the next 8 overwrite saved RBP, and the following 8 overwrite the saved return address. When `vulnerable()` executes `ret`, the CPU pops that attacker-controlled value into **RIP** and jumps to it.

### Classic Exploitation: NOP Sled + Shellcode

The payload structure of a 1990s-era exploit:

```
[NOP sled ~100 bytes] [shellcode] [padding] [address pointing into NOP sled]
```

- The **NOP sled** (`0x90 0x90 ...`) is a landing zone; any imprecise guess at the buffer's address that lands within it slides execution into the shellcode.
- The **shellcode** is position-independent machine code, typically calling `execve("/bin/sh", NULL, NULL)`.
- The **return address** overwrites the saved RIP with an address pointing somewhere into the NOP sled.

### Demonstrating the Overflow

```bash
# Compile with all mitigations disabled to see the raw bug
gcc -g -O0 -fno-stack-protector -z execstack -no-pie vuln.c -o vuln_unsafe

# Disable system-wide ASLR temporarily
echo 0 | sudo tee /proc/sys/kernel/randomize_va_space

# Confirm the crash
./vuln_unsafe $(python3 -c "print('A'*200)")
# → Segmentation fault (core dumped)
# dmesg shows RIP = 0x4141414141414141 ("AAAAAAA")
```

### Finding the Offset with pwntools

```python
from pwn import *
# Generate a De Bruijn cyclic pattern — every 8-byte subsequence is unique
pattern = cyclic(200)
# Run under GDB, observe the RIP value at crash, then:
offset = cyclic_find(0x6161616c6161616b)   # paste the value from RIP
print(f"Return address at offset: {offset}")  # e.g., 72
```

### Why Modern Exploits Are More Complex

Three OS/compiler mitigations raise the cost of exploitation significantly:

| Mitigation | How It Blocks the Naive Exploit |
|---|---|
| **Stack Canary** | Random sentinel between buffer and return address; `__stack_chk_fail` aborts if changed |
| **NX / DEP** | Stack mapped `rw-` (no execute); jumping to shellcode faults immediately |
| **ASLR + PIE** | Stack, heap, libraries, and binary base randomized each run; fixed addresses are useless |

Modern exploiters defeat these through: *information leaks* to defeat ASLR; **ROP chains** built from existing executable code to defeat NX; and *off-by-one* or partial overwrites that bypass canaries, or targeting the heap where no canary exists.

---

## Key Concepts

- **Stack-Based Buffer Overflow** — Overflow of an automatic variable on the call stack. The classic target is the saved return address (RIP/EIP), but modern targets include local function pointers and exception-handler records (SEH on Windows).
- **Heap-Based Buffer Overflow** — Overflow of a `malloc`-allocated buffer. Targets include glibc ptmalloc chunk metadata (enabling the "unlink" or tcache-poisoning attacks), adjacent C++ vtable pointers, and function pointer fields in data structures.
- **Off-by-One Error** — A single-byte overflow, often from `<=` instead of `<` or from forgetting a null terminator. Despite being tiny, a one-byte overwrite of heap chunk size fields or a frame pointer can be catastrophic. CVE-2012-0809 (sudo) is a classic example.
- **Buffer Over-Read** — Reading *past* the end of a buffer, disclosing adjacent memory without corrupting it. **CVE-2014-0160 (Heartbleed)** — a two-byte over-read of the OpenSSL TLS heartbeat length field — disclosed private keys from millions of servers with no code execution needed.
- **Shellcode** — Position-independent machine code delivered as the overflow payload, typically spawning a local shell or establishing a reverse TCP connection. Generated by tools like `msfvenom`, `pwntools.shellcraft`, or hand-authored for constrained character sets.
- **NOP Sled** — A sequence of no-op instructions (`0x90` on x86) prepended to shellcode to widen the effective target area for an imprecise jump. Largely obsolete on modern systems due to ASLR and NX.
- **Return-Oriented Programming (ROP)** — Chaining short instruction sequences ("gadgets") ending in `ret` that already exist in the program's legitimate code pages, computing arbitrary behavior without injecting new code. Directly defeats NX/DEP.
- **Stack Canary (Stack Cookie)** — A random sentinel value placed between local buffers and the saved return address by the compiler; verified on function exit and raises `SIGABRT` if corrupted. Introduced by Crispin Cowan's **StackGuard** (1998), standardized as `-fstack-protector`.
- **ASLR / PIE** — Address Space Layout Randomization randomizes library, heap, and stack bases at the OS level; Position-Independent Executable extends randomization to the main binary load address, denying the attacker stable target addresses.
- **Control-Flow Integrity (CFI)** — Compile-time and runtime enforcement that indirect calls and `ret` instructions target only legitimate destinations in the program's control-flow graph. Windows ships **Control Flow Guard (CFG)** and **Intel CET** shadow stacks; Clang provides `-fsanitize=cfi`.

---

## Exam Relevance

Buffer overflows appear in **CompTIA Security+ SY0-701 Objective 2.3 – Explain various types of vulnerabilities** (application attack category). Key exam angles:

- **Root cause:** The exam consistently ties buffer overflows to *lack of input validation* and *unsafe programming practices* in languages like C/C++. If a question asks what causes a buffer overflow, the answer is missing or insufficient bounds checking / input validation.
- **Defensive pairings:** Memorize the mitigation → mechanism pairs: ASLR defeats predictable addresses; DEP/NX defeats code injection on the stack; stack canaries detect overwrites before `ret`. Input validation and using memory-safe languages are the preferred *preventive* controls.
- **Distinguishing from similar attacks:** Don't confuse buffer overflow (memory bounds violation) with **integer overflow** (arithmetic wraparound, may *cause* an undersized allocation), **memory leak** (resource exhaustion, not corruption), or **injection attacks** (SQL/command injection). If a scenario describes overwriting memory or redirecting execution, it is a buffer overflow.
- **Heartbleed gotcha:** Heartbleed is a *buffer over-read*, not a write overflow. It disclosed data but did not directly execute arbitrary code. The exam may treat it as a buffer overflow variant; know both terms.
- **Common question pattern — scenario-based:** "A developer's application crashes when a user submits a 500-character name into a 64-byte field. What type of attack is this?" → Buffer overflow. The signature is: input size > buffer size → crash / behavior change.
- **DEP vs. ASLR:** DEP (Data Execution Prevention) prevents *execution* of data memory; ASLR prevents *finding* targets. The exam tests whether you know which mitigation addresses which threat.

---

## Security Implications

Buffer overflows are rated **Critical** (CVSS 9.0–10.0) when they are pre-authentication, remotely exploitable, and yield arbitrary code execution with elevated privileges. They remain among the most weaponized vulnerability classes in nation-state and criminal toolkits.

### Notable Real-World CVEs

| CVE | Year | Product | Type | Impact |
|---|---|---|---|---|
| *(none — pre-NVD)* | 1988 | BSD `fingerd` | Stack | Morris Worm; ~6,000 hosts |
| CVE-2001-0500 | 2001 | Microsoft IIS | Stack | Code Red worm; 359K hosts in 14 h |
| CVE-2002-0649 | 2002 | MS SQL Server | Stack | SQL Slammer; ~75K hosts in 10 min |
| CVE-2003-0352 | 2003 | Windows DCOM | Stack | Blaster worm |
| CVE-2014-0160 | 2014 | OpenSSL | Over-read | Heartbleed; private key disclosure |
| CVE-2017-0144 | 2017 | Windows SMBv1 | Heap (pool) | EternalBlue → WannaCry / NotPetya |
| CVE-2019-0708 | 2019 | Windows RDP | Heap | BlueKeep; pre-auth, wormable |
| CVE-2021-3156 | 2021 | Linux `sudo` | Heap | Baron Samedit; local root, every major distro |
| CVE-2023-44487 | 2023 | Various HTTP/2 | Logic | (HTTP/2 Rapid Reset — adjacent, not BOF) |

### Attack Vectors

- **Network services** parsing attacker-controlled input: HTTP headers, DNS responses, SMB packets, VPN handshakes.
- **File format parsers** in browsers, office suites, image libraries (ImageMagick, libpng, libtiff), and antivirus engines — triggered by opening a malicious file.
- **IPC endpoints** exposed by privileged local daemons (D-Bus handlers, `setuid` binaries, kernel drivers).
- **Embedded / IoT firmware**: Many devices run C without ASLR, NX, or canaries. Tools like `binwalk` + `checksec` reveal missing protections instantly.

### Detection Approaches

- **Static analysis:** Coverity, CodeQL, Semgrep, `cppcheck`, and Clang's `-Wall -Wextra -Wformat-security` catch many classic unsafe function patterns.
- **Dynamic / runtime analysis:** **AddressSanitizer (ASan)**, **Valgrind/memcheck**, and **Dr. Memory** instrument allocations and report overflows at runtime during QA.
- **Fuzzing:** **AFL++**, **libFuzzer**, and **honggfuzz** generate malformed inputs and detect crashes; paired with ASan they are the industry gold standard for finding buffer overflows before attackers do.
- **Runtime telemetry:** EDR platforms detect stack-pivot and ROP-chain patterns (Windows Defender Exploit Guard, CrowdStrike Falcon). Kernel audit of clustered `SIGSEGV` signals from the same process can detect exploitation attempts in production.

---

## Defensive Measures

### Compiler and Linker Hardening (Linux/GCC/Clang)

```bash
gcc -O2 \
    -fstack-protector-strong \
    -D_FORTIFY_SOURCE=2 \
    -fPIE -pie \
    -Wl,-