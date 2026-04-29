# divide-by-zero

## What it is
Imagine a librarian asked to split a stack of books evenly among zero people — the request is nonsensical, and the librarian freezes up entirely. A divide-by-zero error occurs when software attempts a division operation with a denominator of zero, causing the CPU to throw an exception that, if unhandled, crashes the program or triggers undefined behavior. Attackers can deliberately craft inputs that force this condition to cause denial of service or exploit the resulting unstable program state.

## Why it matters
In 2019, a divide-by-zero vulnerability in the Linux kernel's XFS filesystem driver (CVE-2018-13093) allowed a local attacker to mount a crafted filesystem image and crash the kernel — a local denial-of-service via privilege escalation pathway. Proper input validation before arithmetic operations would have prevented the malicious input from ever reaching the vulnerable calculation.

## Key facts
- Divide-by-zero is classified as a **CWE-369** (Divide By Zero) weakness in the MITRE CWE taxonomy
- Most commonly weaponized as a **Denial of Service (DoS)** vector by crashing services or kernels with crafted input
- In languages like C/C++, integer divide-by-zero causes a **hardware exception (SIGFPE signal)**; floating-point divide-by-zero may silently produce `Inf` or `NaN` instead of crashing
- Fuzzing tools (e.g., AFL, libFuzzer) actively seek divide-by-zero bugs by feeding boundary values like `0` to numeric inputs
- Defense requires **input validation and sanitization** before arithmetic, plus structured exception handling to fail safely rather than crash

## Related concepts
[[integer-overflow]] [[denial-of-service]] [[fuzzing]] [[input-validation]] [[exception-handling]]