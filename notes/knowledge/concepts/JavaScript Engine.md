# JavaScript engine

## What it is
Like a sous-chef who takes a recipe written in plain English and furiously chops, preps, and cooks it into an actual meal in real time, a JavaScript engine takes human-readable JS code and compiles/interprets it into machine instructions the CPU can execute. Modern engines (V8 in Chrome/Node.js, SpiderMonkey in Firefox) use Just-In-Time (JIT) compilation to optimize code during runtime for speed.

## Why it matters
JIT compilation introduced a class of vulnerability called **JIT spraying**, where an attacker crafts JavaScript that causes the JIT compiler to emit predictable shellcode patterns into executable memory — bypassing ASLR because the attacker can *predict* where their payload lands. This technique was used against browser-based targets to achieve reliable remote code execution without needing a traditional memory leak first.

## Key facts
- **V8** (Chrome, Edge, Node.js) and **SpiderMonkey** (Firefox) are the two most security-relevant engines in enterprise environments
- JavaScript engines run in a **sandbox**, but engine vulnerabilities (type confusion, use-after-free) can escape that sandbox and compromise the host OS
- **JIT spraying** abuses the JIT compiler to place attacker-controlled bytes into executable (RX) memory pages, defeating DEP/NX protections
- **Type confusion bugs** — where the engine misidentifies an object's type — are the most common engine CVE category and frequently weaponized in APT campaigns
- Content Security Policy (**CSP**) with `script-src` directives can restrict *what* JS executes, reducing attack surface but not engine-level memory corruption

## Related concepts
[[JIT Spraying]] [[Sandboxing]] [[Content Security Policy]] [[Use-After-Free]] [[Browser Exploitation]]