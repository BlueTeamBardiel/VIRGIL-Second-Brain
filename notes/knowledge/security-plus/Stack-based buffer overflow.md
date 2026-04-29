# stack-based buffer overflow

## What it is
Imagine pouring a 2-liter soda into a 12-ounce cup — the overflow soaks into the tablecloth next to it, corrupting whatever was there. A stack-based buffer overflow occurs when a program writes more data into a fixed-size stack buffer than it can hold, overwriting adjacent memory — most critically, the saved return address that tells the CPU where to jump after a function completes.

## Why it matters
The 1988 Morris Worm exploited a buffer overflow in `fingerd` to propagate across the internet, marking the first widely recognized instance of this attack in the wild. Attackers overwrite the return address with a pointer to their own shellcode, hijacking execution flow entirely — turning a web server or VPN daemon into a remote command shell. Defenses like stack canaries (GS flag in MSVC), ASLR, and NX/DEP bits exist specifically to break this exploitation chain.

## Key facts
- The **return address** sits just above the stack frame's local variables; overwriting it is the classic goal of exploitation
- **Stack canaries** place a random sentinel value between the buffer and return address — if it's altered, the program terminates before the hijacked return executes
- **ASLR** (Address Space Layout Randomization) randomizes where the stack lives in memory, making it hard to predict where to redirect execution
- **NX/DEP** marks the stack as non-executable, preventing injected shellcode from running even if the return address is overwritten
- **Unsafe C functions** like `strcpy()`, `gets()`, and `sprintf()` have no bounds checking and are the most common root cause — their safe replacements (`strncpy`, `fgets`) are a fundamental remediation

## Related concepts
[[ASLR]] [[DEP/NX bit]] [[stack canary]] [[shellcode]] [[return-oriented programming]]