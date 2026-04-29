# libFuzzer

## What it is
Like a toddler randomly mashing piano keys — except the toddler has perfect memory, learns which keys caused interesting sounds, and tries variations of those forever — libFuzzer is an in-process, coverage-guided fuzzing engine built into LLVM. It automatically generates and mutates inputs to a target function, tracking which code paths each input exercises to maximize coverage and surface crashes, memory corruption, and undefined behavior.

## Why it matters
Google's Project Zero and internal security teams use libFuzzer continuously against Chrome's media parsers and PDF renderers — the exact components attackers target with malicious files. In 2020, fuzzing campaigns using libFuzzer discovered dozens of heap buffer overflows in FreeType (CVE-2020-15999), one of which was actively exploited in the wild against Chrome users before a patch shipped. Without automated fuzzing catching these edge cases first, attackers find them through manual reverse engineering.

## Key facts
- **Coverage-guided**: Uses SanitizerCoverage instrumentation to track which code branches are hit, biasing future mutations toward unexplored paths rather than random noise
- **In-process execution**: Runs the target function in a loop within the same process, making it orders of magnitude faster than fork-based fuzzers like AFL
- **Sanitizer integration**: Pairs with AddressSanitizer (ASan) and UndefinedBehaviorSanitizer (UBSan) at compile time to catch memory errors that don't immediately crash
- **Corpus-driven**: Starts from a seed corpus of valid inputs and evolves them; a good seed corpus dramatically reduces time to meaningful coverage
- **Target requirement**: Requires writing a `LLVMFuzzerTestOneInput(data, size)` harness function — the quality of the harness determines fuzzing effectiveness

## Related concepts
[[Fuzzing]] [[AddressSanitizer]] [[AFL (American Fuzzy Lop)]] [[Buffer Overflow]] [[Static Analysis]]