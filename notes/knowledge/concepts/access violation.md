# access violation

## What it is
Like a driver swerving off the road onto private property they have no right to enter, an access violation occurs when a process attempts to read from or write to a memory address it has not been allocated or permitted to use. The operating system detects this illegal memory reference and forcibly terminates the offending process, typically generating a segmentation fault (Linux) or a STATUS_ACCESS_VIOLATION exception (Windows).

## Why it matters
Attackers deliberately trigger and exploit access violations through techniques like buffer overflows — by overwriting memory boundaries, they can corrupt adjacent data, hijack instruction pointers, or redirect execution to shellcode. The 2003 SQL Slammer worm exploited a buffer overflow in Microsoft SQL Server that caused exactly this type of violation, spreading to 75,000 hosts in under 10 minutes.

## Key facts
- On Windows, access violations appear as exception code **0xC0000005** and are a primary indicator of memory corruption exploitation attempts
- Access violations are a core symptom of **buffer overflow, use-after-free, and null pointer dereference** vulnerabilities
- Modern OS defenses like **DEP (Data Execution Prevention)** and **ASLR (Address Space Layout Randomization)** are specifically designed to make access violations harder to exploit usefully
- Security tools like **Application Verifier** and fuzzing frameworks deliberately induce access violations during testing to discover vulnerabilities before attackers do
- Access violations appearing repeatedly in crash logs or EDR telemetry are a **red flag for active exploitation attempts** and should trigger incident investigation

## Related concepts
[[buffer overflow]] [[memory corruption]] [[data execution prevention]] [[ASLR]] [[segmentation fault]]