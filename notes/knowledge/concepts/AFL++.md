# AFL++

## What it is
Think of AFL++ as a tireless fuzzer that learns from its mistakes—like a security researcher who remembers every crash they triggered and uses that knowledge to find deeper bugs faster. AFL++ is a fork and modernization of American Fuzzy Lop that instruments binary code to track which inputs reach new execution paths, then mutates those inputs to systematically explore the program's behavior space and crash it.

## Why it matters
When Google's Project Zero discovered critical vulnerabilities in widely-deployed software (like ImageMagick or libpng), AFL++ was often the tool that found them first. Attackers use similar fuzzing techniques to discover exploitable bugs before vendors patch them; defenders use AFL++ to find and fix bugs proactively before deployment.

## Key facts
- Uses compile-time instrumentation to track code coverage—AFL++ knows when a mutation reaches a new branch, making it exponentially more efficient than blind fuzzing
- Supports multiple fuzzing strategies (libFuzzer integration, QEMU mode for closed-source binaries, persistent mode for network servers)
- Maintains a corpus of interesting test cases that trigger diverse behaviors, enabling incremental discovery of deep bugs
- Parallel fuzzing via `afl-sync` lets teams run thousands of fuzzer instances simultaneously, scaling vulnerability discovery
- Extremely low overhead (~5% slowdown) allows fuzzing long-running, complex programs like browsers and media parsers

## Related concepts
[[Fuzzing]] [[Coverage-guided testing]] [[Mutation testing]] [[QEMU mode]] [[libFuzzer]]