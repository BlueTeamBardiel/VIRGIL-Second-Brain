# Fuzz Testing

## What it is
Imagine hiring a toddler to test your new blender by throwing random objects into it — batteries, shoes, spaghetti — to see what breaks it. Fuzz testing (fuzzing) works the same way: automated tools bombard a program with massive volumes of random, malformed, or unexpected inputs to trigger crashes, memory leaks, or undefined behavior. It's a dynamic analysis technique designed to uncover vulnerabilities that developers never thought to test for.

## Why it matters
Google's Project Zero team discovered critical vulnerabilities in image parsing libraries (like libpng and libjpeg) using fuzzing — flaws that had existed undetected for years and could be exploited via malicious image files. These bugs enabled remote code execution simply by getting a target to open an image. Fuzzing is now a standard phase in secure software development lifecycles (SDLC) at major tech companies.

## Key facts
- **Types of fuzzers:** Mutation-based (mutates valid inputs), generation-based (builds inputs from scratch using protocol knowledge), and coverage-guided (tracks code paths to maximize reach — AFL and libFuzzer use this approach)
- **Common findings:** Buffer overflows, use-after-free errors, integer overflows, and null pointer dereferences — all critical vulnerability classes
- **Fuzzing vs. penetration testing:** Fuzzing is automated and scales to millions of test cases; pen testing is manual, targeted, and contextual
- **Security+ relevance:** Fuzzing is categorized under **application security testing** and falls within the **vulnerability assessment** methodology
- **Sanitizers amplify fuzzing:** Tools like AddressSanitizer (ASan) catch memory errors that wouldn't visibly crash the program, dramatically increasing fuzzing effectiveness

## Related concepts
[[Buffer Overflow]] [[Static Code Analysis]] [[Penetration Testing]] [[Software Development Life Cycle (SDLC)]] [[Dynamic Analysis]]