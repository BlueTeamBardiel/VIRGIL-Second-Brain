# static analysis

## What it is
Like a food inspector reading every ingredient label before tasting anything, static analysis examines code or binaries without ever executing them. It is the process of inspecting software artifacts — source code, bytecode, or compiled binaries — to identify vulnerabilities, malicious patterns, or structural weaknesses at rest. No program runs; the analysis is purely observational.

## Why it matters
When the Stuxnet worm was discovered, researchers used static analysis to reverse-engineer its payload and identify its four zero-day exploits without detonating it in a live environment. This is the core defensive value: analysts can safely dissect malware in tools like Ghidra or IDA Pro, extract strings, identify hardcoded C2 IP addresses, and reconstruct logic — all without risking infection or triggering anti-sandbox evasion routines.

## Key facts
- Static analysis tools include **disassemblers** (IDA Pro, Ghidra), **decompilers**, **linters**, and **SAST (Static Application Security Testing)** tools like Checkmarx or Bandit
- It can detect **hardcoded credentials**, **buffer overflows**, and **insecure function calls** (e.g., `strcpy`, `gets`) before deployment
- **Signature-based AV** is a primitive form of static analysis — matching byte patterns without execution
- Malware authors counter static analysis through **obfuscation**, **packing** (UPX), and **encryption** of payloads, which is why static analysis is often paired with dynamic analysis
- SAST is performed **early in the SDLC** (shift-left security), making it cheaper to fix flaws than post-deployment patching

## Related concepts
[[dynamic analysis]] [[reverse engineering]] [[SAST]] [[malware analysis]] [[code review]]