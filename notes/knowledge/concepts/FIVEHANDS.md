# FIVEHANDS

## What it is
Like a locksmith who burns their own tools after opening a vault — leaving no trace of how they got in — FIVEHANDS is a memory-only ransomware variant that avoids touching disk storage to evade traditional detection. Precisely, it is a sophisticated ransomware family (successor to HELLOKITTY/DEATHRANSOM) that executes entirely in memory and uses a command-line argument to receive the attacker's public key, meaning the encryption key is never written to disk.

## Why it matters
In 2021, UNC2447, a financially motivated threat actor, deployed FIVEHANDS alongside SOMBRAT backdoors against North American and European organizations, exploiting a Pulse Secure VPN zero-day (CVE-2021-22893) for initial access. Defenders relying solely on signature-based endpoint tools found FIVEHANDS nearly invisible, demonstrating why behavioral detection and memory scanning are essential layers in a modern defense stack.

## Key facts
- FIVEHANDS is **fileless ransomware** — it runs entirely in memory (process injection), bypassing file-based AV signatures
- The encryption key is passed as a **command-line argument** at runtime, never persisted to disk, making forensic key recovery extremely difficult
- It replaced HELLOKITTY in UNC2447's toolkit around early 2021, indicating active threat actor tooling evolution
- Initial access vector in documented campaigns: **Pulse Secure VPN zero-day (CVE-2021-22893)** — a pre-auth remote code execution flaw
- FIVEHANDS uses **PUBLICKEY encryption** to protect a symmetric session key, a classic hybrid encryption ransomware pattern (RSA + AES)

## Related concepts
[[Fileless Malware]] [[Ransomware]] [[Living off the Land Attacks]] [[Memory Injection]] [[Zero-Day Exploit]]