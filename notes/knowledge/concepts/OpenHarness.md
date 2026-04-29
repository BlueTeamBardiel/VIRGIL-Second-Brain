# OpenHarness

## What it is
Like a universal docking adapter that lets any spaceship connect to any space station, OpenHarness is a standardized framework for connecting AI/ML models to external tools, APIs, and data sources in a controlled, observable way. Specifically, it is an open-source orchestration harness designed to manage how large language models (LLMs) invoke external functions and plugins while providing security telemetry around those interactions. It sits between the model and the outside world, acting as a monitored gateway.

## Why it matters
When an LLM is given access to tools like web search, code execution, or database queries, an attacker can craft malicious prompts that hijack those tool calls — a technique known as prompt injection leading to tool abuse. OpenHarness-style frameworks provide the logging and policy enforcement layer that lets defenders detect when an AI agent is being manipulated into making unauthorized API calls or exfiltrating data through permitted-but-abused tool channels.

## Key facts
- OpenHarness provides **structured logging of tool invocations**, enabling forensic reconstruction of AI agent behavior — critical for incident response in agentic AI deployments
- It enforces **allowlisting of permitted tool calls**, reducing the attack surface exposed to prompt injection attacks
- Supports **sandboxed execution environments** for code-generating models, limiting blast radius of malicious code generation
- Relevant to **AI supply chain security** — verifies tool/plugin integrity before execution, analogous to code signing
- Aligns with emerging frameworks like **OWASP Top 10 for LLMs**, particularly LLM08 (Excessive Agency) by constraining what actions an AI can autonomously take

## Related concepts
[[Prompt Injection]] [[AI Agent Security]] [[Tool Poisoning]] [[Least Privilege]] [[API Security]]