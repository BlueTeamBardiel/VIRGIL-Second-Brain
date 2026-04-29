# CWE-121: Stack-Based Buffer Overflow

## What it is
Imagine a parking lot with exactly 10 spaces — if 15 cars arrive, the extras crash into the neighboring building's wall and destroy whatever was inside. A stack-based buffer overflow occurs when a program writes more data to a fixed-size stack buffer than it was allocated to hold, overwriting adjacent stack memory including the saved return address, enabling an attacker to redirect execution flow.

## Why it matters
The Morris Worm (1988) exploited a stack-based buffer overflow in `fingerd` by sending an oversized string that overwrote the return address, redirecting execution to shellcode — one of the first self-propagating exploits in history. Modern exploitation of this vulnerability class commonly uses **ROP (Return-Oriented Programming)** chains to bypass non-executable stack protections like NX/DEP.

## Key facts
- The **return address** stored on the stack is the primary target — overwriting it lets attackers redirect execution to attacker-controlled code
- **Stack canaries** (GCC's `-fstack-protector`) place a random sentinel value before the return address; if modified, the program terminates before returning
- **ASLR (Address Space Layout Randomization)** randomizes stack addresses at runtime, making it harder to predict where injected shellcode lives
- Vulnerable functions in C include `gets()`, `strcpy()`, `sprintf()` — all lack bounds checking and are banned in secure coding standards (SEI CERT C)
- Distinct from **heap-based** overflow (CWE-122): stack overflows typically enable direct return-address hijacking, while heap overflows corrupt heap metadata or function pointers

## Related concepts
[[Stack Canaries]] [[Address Space Layout Randomization]] [[Return-Oriented Programming]] [[CWE-122 Heap-Based Buffer Overflow]] [[NX/DEP]]