# Log4j 1-to-Log4j 2 bridge

## What it is
Think of it like putting a new engine in an old car body — the exterior looks the same, but the internals are completely different. The Log4j 1-to-Log4j 2 bridge (`log4j-1.2-api`) is a compatibility shim that allows legacy applications coded against the Log4j 1.x API to run transparently on the Log4j 2 engine without rewriting application code.

## Why it matters
During the Log4Shell crisis (CVE-2021-44228), organizations scrambled to patch Log4j 2.x, but many discovered their applications used the bridge, creating a hidden dependency chain. A security team might scan for Log4j 2 vulnerabilities, find no direct usage, and miss that their legacy Log4j 1.x code was actually routing through a vulnerable Log4j 2 core — leaving them falsely confident while remaining fully exploitable.

## Key facts
- The bridge JAR (`log4j-1.2-api`) is an **official Apache component** provided by the Log4j 2 project, not a third-party shim
- Applications using the bridge still load the Log4j 2 core (`log4j-core`), meaning **CVE-2021-44228 applies** if that core is a vulnerable version (2.0-beta9 through 2.14.1)
- Log4j 1.x itself reached **end-of-life in 2015** and carries its own vulnerabilities (e.g., CVE-2019-17571 — SocketServer RCE)
- SBOMs (Software Bill of Materials) are the primary defense tool for detecting bridge dependencies hidden inside transitive dependency trees
- Mitigation requires patching **log4j-core**, not the bridge shim itself — teams that only removed the bridge shim without upgrading the core remained vulnerable

## Related concepts
[[Log4Shell (CVE-2021-44228)]] [[Software Bill of Materials (SBOM)]] [[Dependency Confusion Attack]] [[Java Deserialization Vulnerabilities]]