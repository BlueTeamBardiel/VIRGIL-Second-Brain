# CWE-94

## What it is
Imagine handing a chef a recipe card, but the diner secretly rewrote part of it to add "and then burn the kitchen down." Code Injection (CWE-94) occurs when an attacker supplies input that an application interprets and executes as code rather than treating it as inert data — the application loses the ability to distinguish instructions from information.

## Why it matters
In 2021, the Log4Shell vulnerability (CVE-2021-44228) demonstrated a catastrophic real-world instance: attackers injected JNDI lookup strings into log messages, causing the Log4j library to fetch and execute remote Java classes. This single flaw allowed unauthenticated remote code execution across millions of servers worldwide, from enterprise systems to Minecraft servers.

## Key facts
- **Distinct from Command Injection (CWE-78):** CWE-94 targets the application's own language runtime (Python `eval()`, PHP `eval()`, Node.js `vm` module), while CWE-78 targets the OS shell.
- **Template injection is a subclass:** Server-Side Template Injection (SSTI) in Jinja2, Twig, or Freemarker engines falls under CWE-94 and can escalate to full RCE.
- **`eval()` is the canonical red flag:** Any use of `eval()`, `exec()`, `compile()`, or `pickle.loads()` on user-controlled input is a near-automatic CWE-94 finding.
- **Prevention requires input never touching the interpreter:** Input validation, allowlisting, and sandboxed execution environments (not just escaping) are required mitigations.
- **CVSS scores frequently hit 9.0+:** Because successful exploitation typically yields full code execution under the application's privilege context, CWE-94 findings are critical severity by default.

## Related concepts
[[CWE-78 OS Command Injection]] [[Server-Side Template Injection]] [[CWE-20 Improper Input Validation]] [[Remote Code Execution]] [[Deserialization Vulnerabilities]]