# modelscope agentscope

## What it is
Like a stage director handing scripts to actors who then improvise dangerously off-book, AgentScope is Alibaba's open-source multi-agent framework built on ModelScope that orchestrates multiple LLM-powered agents to collaborate on complex tasks autonomously. It provides structured pipelines for agent communication, tool use, and workflow coordination across distributed AI models.

## Why it matters
In a red team scenario, an attacker could exploit AgentScope's inter-agent messaging bus to inject adversarial prompts into one agent's output, poisoning downstream agents in the pipeline — a cascading prompt injection that's far harder to detect than a single-model attack. Defenders must treat each agent-to-agent communication channel as an untrusted boundary requiring input validation, just like any API endpoint.

## Key facts
- AgentScope uses a **message-passing architecture** where agents exchange structured JSON-like objects — each message boundary is a potential injection or tampering point
- The framework supports **tool-use agents** that can call external APIs, execute code, and access filesystems — dramatically expanding the attack surface beyond text generation
- **Prompt injection** via upstream agent output is the primary threat vector; downstream agents inherit no trust-verification mechanism by default
- AgentScope's **distributed mode** allows agents to run across different machines, introducing network-level threats including man-in-the-middle and replay attacks on agent communications
- From a **supply chain security** perspective, ModelScope-hosted models loaded into AgentScope pipelines may contain malicious fine-tuning or backdoors that activate under specific trigger inputs

## Related concepts
[[Prompt Injection]] [[Supply Chain Attack]] [[API Security]] [[Large Language Model Security]] [[Agentic AI Attack Surface]]