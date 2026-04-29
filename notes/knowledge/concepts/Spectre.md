# Spectre

## What it is
Imagine a bank teller who, before checking your ID, starts mentally preparing your withdrawal — then stops when they realize you're unauthorized, but leaves the cash tray slightly disturbed. Spectre is a class of hardware vulnerability that exploits **speculative execution** — a CPU optimization where the processor guesses ahead on instruction paths — allowing an attacker to infer secret data by measuring side-effects (cache timing) even after the CPU discards the unauthorized result.

## Why it matters
In a cloud hosting environment, a malicious tenant VM can use Spectre to read memory belonging to the hypervisor or a neighboring VM — defeating the fundamental isolation guarantee of virtualization. This makes it particularly dangerous for shared infrastructure like AWS or Azure, where cryptographic keys or session tokens could leak across tenant boundaries without any traditional software vulnerability.

## Key facts
- Spectre was disclosed in January 2018 alongside Meltdown, by researchers including Google Project Zero
- Unlike Meltdown (which breaks user/kernel isolation), Spectre **poisons the branch predictor** to trick *victim* processes into speculatively leaking their own data — harder to patch
- Exploits the **CPU cache as a covert channel**: attacker measures memory access timing (FLUSH+RELOAD) to deduce secret values bit by bit
- Affects virtually all modern processors (Intel, AMD, ARM) because speculative execution is a universal performance feature
- Mitigations include **Retpoline** (compiler-level fix), microcode updates, and OS-level isolation — but all carry measurable performance penalties (5–30% in I/O-heavy workloads)

## Related concepts
[[Meltdown]] [[Side-Channel Attack]] [[Cache Timing Attack]] [[Speculative Execution]] [[Hypervisor Security]]