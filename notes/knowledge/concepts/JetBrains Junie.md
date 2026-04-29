# JetBrains Junie

## What it is
Like having a junior developer sitting at your keyboard who can read, write, and execute code autonomously inside your IDE — Junie is JetBrains' AI coding agent that operates directly within IntelliJ-based environments, performing multi-step tasks like refactoring, testing, and debugging with minimal human prompting. Unlike simple autocomplete, it takes autonomous actions within the development environment using tool-calling and agentic workflows.

## Why it matters
Agentic AI tools like Junie introduce a new attack surface called **prompt injection via codebase poisoning** — an attacker who can commit malicious comments or README content into a repository could manipulate Junie's actions when a developer asks it to "understand and improve this project," causing it to exfiltrate secrets or introduce backdoors. This is a concrete supply chain risk where the IDE itself becomes the exploitation vector, bypassing traditional perimeter defenses entirely.

## Key facts
- Junie runs as an **agentic AI** with file read/write and terminal execution capabilities inside JetBrains IDEs, making it a high-privilege local process
- It is susceptible to **indirect prompt injection** — malicious instructions embedded in source files, comments, or docs can hijack its behavior without user awareness
- Operates under the developer's local credentials, meaning compromised Junie actions inherit **all filesystem and secrets access** available to that user
- JetBrains positions it as distinct from JetBrains AI Assistant — Junie is task-oriented and **autonomous**, not conversational
- From a CySA+ perspective, Junie represents an **insider threat amplifier**: even a well-intentioned developer can unknowingly execute attacker-controlled logic through AI delegation

## Related concepts
[[Prompt Injection]] [[Supply Chain Attack]] [[AI-Assisted Threat Vectors]] [[Least Privilege]] [[Insider Threat]]