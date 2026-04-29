# agentscope

## What it is
Think of AgentScope like a stage manager coordinating multiple actors in a play — each "actor" is an AI agent with its own role, and the stage manager ensures they communicate, hand off tasks, and stay in their lanes. Precisely, AgentScope is an open-source multi-agent development framework (by Alibaba) that enables building, orchestrating, and deploying systems where multiple LLM-powered AI agents collaborate to complete complex tasks.

## Why it matters
Multi-agent frameworks like AgentScope create novel attack surfaces where a compromised or maliciously crafted agent can inject adversarial instructions into the shared message pipeline — a technique called **prompt injection via agent chaining**. An attacker could craft a document processed by one agent that secretly instructs a downstream agent (e.g., a code-execution agent) to exfiltrate data or escalate privileges within the automated pipeline.

## Key facts
- AgentScope uses a **message-passing architecture** where agents communicate through structured `Msg` objects — intercepting or tampering with these messages is an emerging threat vector
- The framework supports **tool use and code execution agents**, meaning a compromised agent pipeline can directly interface with system resources or external APIs
- **Trust boundary erosion** is a core risk: agents operating under assumed-trusted contexts may execute instructions from untrusted external inputs (web content, user files)
- Multi-agent systems expand the **attack surface for indirect prompt injection** — OWASP lists this as a top LLM risk (LLM02: Insecure Output Handling, LLM01: Prompt Injection)
- Securing AgentScope deployments requires **least-privilege agent design** — each agent should only access the tools and data scopes necessary for its specific role

## Related concepts
[[Prompt Injection]] [[Large Language Model Security]] [[API Security]] [[Least Privilege]] [[Supply Chain Attack]]