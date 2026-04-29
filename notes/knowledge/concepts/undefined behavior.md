# undefined behavior

## What it is
Like a vending machine that, when given a coin with a hole in it, might dispense your snack, catch fire, or call the police — the spec simply never described that case. Undefined behavior (UB) in programming languages like C/C++ occurs when code violates language rules in ways the standard explicitly refuses to define, meaning the compiler can do *anything* — crash, silently corrupt memory, or produce exploitable results. Unlike a runtime error, UB gives no guaranteed signal that something went wrong.

## Why it matters
Integer overflow — a classic form of UB in C — enabled the 2002 OpenSSH heap overflow vulnerability (CAN-2002-0639), where a signed integer wrapped around during buffer-size calculation, causing `malloc()` to allocate far less memory than expected and enabling remote code execution. Compilers like GCC and Clang increasingly optimize *away* security checks by assuming UB never happens, which can silently delete bounds-checking code a developer thought was protecting them.

## Key facts
- **Compilers exploit UB legally**: when UB is present, a compiler may delete null-pointer checks, making exploitation *easier*, not just unpredictable
- **Common UB sources**: signed integer overflow, use-after-free, out-of-bounds array access, dereferencing null/wild pointers, and uninitialized variable reads
- **UBSan** (Undefined Behavior Sanitizer) is a compile-time instrumentation tool used during testing to detect UB at runtime before it ships
- **Time-of-check to time-of-use (TOCTOU)** bugs often stem from UB-adjacent assumptions about memory state
- Memory-safe languages (Rust, Go) eliminate most UB categories by design — a key architectural defense-in-depth argument

## Related concepts
[[buffer overflow]] [[integer overflow]] [[memory corruption]] [[use-after-free]] [[TOCTOU]]