# Object-Oriented Programming Security

## What it is
Like a bank vault where each safe-deposit box has its own lock and the teller only knows how to *request* access — not pick the lock themselves — OOP organizes code into self-contained objects with private internals and controlled interfaces. Precisely: Object-Oriented Programming Security refers to security vulnerabilities and defensive patterns arising from OOP constructs like inheritance, encapsulation, polymorphism, and serialization. Misused, these constructs become attack surfaces; properly applied, they enforce least privilege at the code level.

## Why it matters
Insecure deserialization — a Top 10 OWASP vulnerability — directly exploits OOP serialization mechanisms. When Java applications deserialize untrusted data, attackers craft malicious serialized objects that execute arbitrary code upon reconstruction, bypassing authentication entirely. The 2017 Apache Struts breach exposing 147 million Equifax records was triggered by unsafe deserialization of a crafted object.

## Key facts
- **Insecure deserialization** occurs when applications reconstruct untrusted serialized objects without validation, enabling Remote Code Execution (RCE) — mapped to CWE-502
- **Broken encapsulation** happens when private fields are exposed via public getters/setters without validation, allowing attackers to inject malicious state
- **Inheritance-based privilege escalation**: a subclass can override security-critical methods in a parent class, weakening controls unless methods are declared `final`
- **Type confusion attacks** exploit polymorphism — casting an object to the wrong type to bypass type-based access checks (common in C++ vtable manipulation)
- **Defense**: apply input validation before deserialization, use allowlists of acceptable class types, and prefer composition over deep inheritance hierarchies to minimize attack surface

## Related concepts
[[Insecure Deserialization]] [[Input Validation]] [[Secure Coding Practices]] [[Memory Safety]] [[Principle of Least Privilege]]