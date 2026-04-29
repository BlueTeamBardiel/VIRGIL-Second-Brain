# bytecode

## What it is
Like sheet music that no instrument can play directly — it needs a musician (interpreter) to perform it — bytecode is an intermediate compiled format that sits between human-readable source code and native machine instructions. It is executed by a virtual machine (e.g., the JVM for Java, or the CLR for .NET) rather than directly by the CPU. This abstraction enables platform independence but introduces a distinct attack surface.

## Why it matters
Attackers routinely decompile Java `.class` files or .NET assemblies back into near-perfect source code using tools like `javap`, `JD-GUI`, or `dnSpy` — a process far easier than reverse-engineering native binaries. This means sensitive logic, hardcoded credentials, or proprietary algorithms embedded in distributed applications are far more exposed than developers expect. Defenders counter this with obfuscators like ProGuard or ConfuserEx, but obfuscation is not encryption — it raises the cost of analysis, not an insurmountable wall.

## Key facts
- Java bytecode is stored in `.class` files; .NET uses Common Intermediate Language (CIL) stored in `.dll` or `.exe` assemblies — both are trivially decompilable.
- Malicious actors embed malware in bytecode targeting specific runtimes (e.g., malicious Java applets historically exploited JVM vulnerabilities CVE-2012-4681).
- Bytecode verification is a security layer: the JVM verifier checks bytecode before execution to prevent type confusion and memory corruption attacks.
- Mobile apps (Android `.dex` files, a form of bytecode) are a prime target — tools like `apktool` and `jadx` reconstruct readable Java from APKs.
- Supply chain attacks inject malicious bytecode into build artifacts (`.jar`, `.war` files) after source code review — the artifact is what gets deployed, not the source.

## Related concepts
[[reverse engineering]] [[obfuscation]] [[supply chain attack]]