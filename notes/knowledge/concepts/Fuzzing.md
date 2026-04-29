# fuzzing

## What it is
Like a toddler mashing every button on a TV remote to see what breaks, fuzzing automatically bombards a program with malformed, unexpected, or random inputs to discover crashes, hangs, and vulnerabilities. Precisely defined, fuzzing (or fuzz testing) is a dynamic application security testing technique that feeds invalid or semi-random data into a target system while monitoring for unhandled exceptions, memory corruption, or unexpected behavior. It uncovers vulnerabilities that manual code review routinely misses.

## Why it matters
In 2014, the Heartbleed vulnerability in OpenSSL could have been detected earlier through proper fuzzing of the TLS handshake input handling — the bug involved a failure to validate a length field, exactly the class of flaw fuzzing excels at exposing. Defenders integrate fuzzing into CI/CD pipelines (a practice called continuous fuzzing) to catch memory corruption bugs like buffer overflows and use-after-free errors before attackers do. Google's OSS-Fuzz project has found over 10,000 vulnerabilities in critical open-source software using this approach.

## Key facts
- **Two main types**: dumb fuzzing (pure random input) vs. smart/coverage-guided fuzzing (uses feedback from code coverage to evolve inputs, e.g., AFL, libFuzzer)
- **Common targets**: file parsers, network protocol handlers, API endpoints, and input validation routines
- **Vulnerabilities found**: buffer overflows, format string bugs, integer overflows, null pointer dereferences, and race conditions
- **Mutation-based vs. generation-based**: mutation fuzzing modifies valid inputs; generation-based fuzzing constructs inputs from scratch using protocol/format knowledge
- **Relevant to CySA+**: fuzzing is a form of **dynamic analysis** and falls under **application security testing** in the software development lifecycle (SDLC)

## Related concepts
[[buffer overflow]] [[dynamic analysis]] [[static analysis]] [[software development lifecycle]] [[input validation]]