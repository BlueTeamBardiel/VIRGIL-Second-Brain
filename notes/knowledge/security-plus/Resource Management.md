# Resource Management

## What it is
Like a restaurant kitchen that runs out of burners when too many orders pile up — systems have finite CPU, memory, file handles, and network connections that can be exhausted. Resource management is the discipline of allocating, tracking, and releasing system resources (memory, threads, handles, bandwidth) in a controlled way to prevent unintended exhaustion, leakage, or abuse.

## Why it matters
Poor resource management is the engine behind Denial-of-Service attacks. In a SYN flood, attackers send thousands of half-open TCP connection requests, consuming the server's connection table until legitimate users are rejected. Proper resource management countermeasures — like SYN cookies, connection rate limiting, and timeout tuning — prevent the table from filling permanently.

## Key facts
- **Memory leaks** occur when allocated memory is never freed; over time they degrade performance and can crash services, creating availability failures
- **File descriptor exhaustion** is a real attack vector — many Linux systems default to 1024 open file descriptors per process, and opening connections without closing them hits this ceiling
- **Resource exhaustion attacks** are classified under CWE-400 (Uncontrolled Resource Consumption) and are a root cause of many DoS vulnerabilities
- **RAII (Resource Acquisition Is Initialization)** is a secure coding pattern where resources are automatically released when a variable goes out of scope — reducing human error
- Security controls include **ulimits**, **quotas**, **timeouts**, and **circuit breakers** — these are defense-in-depth tools that appear in hardening checklists and CIS Benchmarks

## Related concepts
[[Denial of Service]] [[Memory Safety]] [[Input Validation]] [[Buffer Overflow]] [[Rate Limiting]]