# Mutation testing

## What it is
Like a doctor injecting a weakened pathogen to see if your immune system responds, mutation testing deliberately introduces small bugs ("mutants") into source code to verify that your test suite actually catches them. If your tests pass despite the injected flaw, the tests are inadequate — they're not really guarding the code. It's a technique for measuring test suite *effectiveness*, not just coverage.

## Why it matters
During a secure SDLC audit, a development team may boast 95% code coverage yet still ship vulnerable code — mutation testing can expose that those tests never actually validate security-critical conditions like input sanitization or authentication checks. For example, if mutating `if (user.isAuthenticated())` to `if (!user.isAuthenticated())` doesn't kill any tests, the authentication logic is effectively untested and a bypass vulnerability could go undetected.

## Key facts
- A **mutant is "killed"** when at least one test fails after the code change; surviving mutants reveal test suite blind spots.
- Common mutation operators include **boundary changes** (`>` → `>=`), **logical negations** (`&&` → `||`), and **statement deletion** — all maps to real-world off-by-one and logic vulnerabilities.
- **Mutation score** = (killed mutants / total mutants) × 100%; a score below ~80% is generally considered weak coverage quality.
- Mutation testing is distinct from **fuzzing**: fuzzing tests running software with random inputs; mutation testing tests the *test suite itself* against modified source code.
- Relevant to **CySA+** under secure coding practices and software assurance within the SDLC; helps satisfy verification requirements in frameworks like NIST SP 800-218 (SSDF).

## Related concepts
[[Fuzzing]] [[Static Code Analysis]] [[Secure SDLC]] [[Code Coverage]] [[Software Assurance]]