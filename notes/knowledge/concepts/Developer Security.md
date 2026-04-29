# Developer Security

## What it is
Like a chef who washes hands, sanitizes surfaces, and checks ingredients *before* cooking rather than treating food poisoning afterward, developer security means baking security practices into the software development lifecycle from the very first line of code. It is the discipline of integrating security controls, testing, and awareness into the development process itself — not bolting them on at the end — through practices like secure coding standards, code review, and threat modeling.

## Why it matters
In 2021, the Log4Shell vulnerability was a textbook failure of developer security: developers used a widely trusted logging library (Log4j) without understanding its JNDI lookup feature could execute remote code, exposing millions of systems worldwide. A proper security review of third-party dependencies and secure coding training could have flagged this dangerous functionality before it shipped in production software.

## Key facts
- **SAST (Static Application Security Testing)** analyzes source code without executing it; **DAST (Dynamic Application Security Testing)** tests running applications — both are key exam topics for Security+
- **Input validation and output encoding** are the primary defenses against injection attacks (SQLi, XSS, command injection)
- The **OWASP Top 10** is the standard reference for common web application vulnerabilities developers must be trained to avoid
- **Least privilege** must be applied to code: applications should request only the permissions they need, avoiding overprivileged service accounts
- **Secrets management** (never hardcoding API keys, passwords, or tokens in source code) is a common exam scenario; tools like HashiCorp Vault or AWS Secrets Manager address this
- **Secure SDLC (SSDLC)** frameworks like Microsoft SDL integrate threat modeling, code review, and penetration testing at defined development phases

## Related concepts
[[Static Application Security Testing]] [[OWASP Top 10]] [[Threat Modeling]] [[Input Validation]] [[Software Supply Chain Security]]