# Windsurf

## What it is
Like a sailor who reads both the wind and the water simultaneously, Windsurf is an AI-powered IDE (Integrated Development Environment) developed by Codeium that pairs a code editor with an agentic AI assistant capable of autonomously reading, writing, and executing code across an entire project. It represents a class of "agentic coding tools" where the AI doesn't just suggest completions — it takes multi-step actions on your behalf.

## Why it matters
From a security perspective, agentic IDEs like Windsurf introduce a new attack surface called **prompt injection via codebase**. An attacker who plants malicious comments or strings inside a dependency or third-party library could manipulate the AI agent into writing insecure code, exfiltrating secrets, or modifying build pipelines — all without the developer noticing. Security teams auditing CI/CD pipelines now must consider not just human developers but AI agents as threat actors with write access.

## Key facts
- Windsurf's "Cascade" agent can autonomously browse files, run terminal commands, and modify code — expanding the blast radius if the AI is manipulated or misconfigured
- AI coding tools have been shown to reproduce vulnerable code patterns from training data, increasing risk of CWE-89 (SQL Injection) and CWE-79 (XSS) appearing in generated output
- Secrets and API keys stored in project files (`.env`) are within scope of the agent's context window, creating accidental data exposure risk
- Supply chain attacks targeting AI coding assistants represent an emerging threat vector under MITRE ATT&CK T1195 (Supply Chain Compromise)
- Organizations should apply least-privilege principles to AI agent tool permissions, restricting file system and network access where possible

## Related concepts
[[Prompt Injection]] [[Supply Chain Attack]] [[Secrets Management]] [[AI Security]] [[Insecure Code Generation]]