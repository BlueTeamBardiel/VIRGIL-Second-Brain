# MCP server

## What it is
Think of an MCP server like a power strip that lets AI models plug into real tools — file systems, APIs, databases — through a single standardized interface. Model Context Protocol (MCP) is an open protocol developed by Anthropic that defines how AI language models communicate with external data sources and services in a structured, bidirectional way. An MCP server exposes specific capabilities (called "tools") that an AI client can discover and invoke at runtime.

## Why it matters
In 2024–2025, security researchers demonstrated "prompt injection via MCP" attacks where a malicious document fed to an AI assistant caused its connected MCP server to exfiltrate files or execute unauthorized API calls — the AI became an unwitting insider threat. This matters for defenders because MCP servers often run with elevated local permissions, turning a compromised AI interaction into a lateral movement opportunity. Organizations deploying AI agents with MCP must treat MCP servers as privileged attack surfaces requiring the same controls as any API gateway.

## Key facts
- MCP uses a client-server architecture over JSON-RPC 2.0, running locally or remotely; local servers often inherit the host user's OS permissions
- **Tool poisoning**: malicious MCP servers can advertise deceptive tool descriptions that manipulate an AI into performing unintended actions — analogous to a malicious DLL in a search path
- MCP servers have three primitive types: **Tools** (executable functions), **Resources** (data sources), and **Prompts** (templated instructions) — each carries distinct risk profiles
- No native authentication standard existed in early MCP versions; unauthenticated local sockets were the default, creating SSRF and privilege escalation risks
- Supply chain risk: third-party MCP server packages distributed via npm/PyPI can be trojanized, similar to the event-stream npm attack vector

## Related concepts
[[Prompt Injection]] [[API Security]] [[Supply Chain Attack]] [[Privilege Escalation]] [[SSRF]]