# C++

## What it is
Like a race car with no seatbelt — blazing fast but one wrong move and you crash catastrophically. C++ is a compiled, systems-level programming language that gives developers direct memory management control, meaning programs run close to the hardware with minimal abstraction between code and machine instructions.

## Why it matters
The majority of memory corruption vulnerabilities — buffer overflows, use-after-free, heap sprays — exist because legacy C++ code allows developers to manually allocate and free memory without automatic safety checks. The infamous 2014 Heartbleed vulnerability exploited a bounds-checking failure in OpenSSL (written in C), the same class of memory mismanagement endemic to C++ codebases powering browsers, operating systems, and embedded systems today.

## Key facts
- **Buffer overflow** attacks are directly enabled by C++'s lack of automatic bounds checking on arrays — writing past allocated memory can overwrite return addresses and redirect execution
- **Use-after-free** vulnerabilities occur when C++ code dereferences a pointer after the memory it points to has been freed — commonly exploited for remote code execution
- **ASLR, DEP/NX, and stack canaries** are OS/compiler mitigations specifically developed to combat C++ memory corruption attack patterns
- C++ is used in browsers (Chrome, Firefox), operating systems (Windows kernel), and embedded firmware — making C++ vulnerabilities high-impact targets
- **CVE scoring often reflects criticality** of C++ memory bugs; buffer overflows routinely score 9.0+ CVSS due to potential for arbitrary code execution

## Related concepts
[[Buffer Overflow]] [[Memory Corruption]] [[Use-After-Free]] [[Address Space Layout Randomization]] [[Secure Coding Practices]]