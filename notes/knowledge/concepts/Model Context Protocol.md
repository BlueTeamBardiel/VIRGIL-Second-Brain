# Model Context Protocol

## What it is
Think of MCP like a universal power adapter that lets AI assistants plug into any tool or data source using a standardized connector — except the adapter itself can be hijacked to route power somewhere dangerous. Model Context Protocol (MCP) is an open standard developed by Anthropic that defines how AI language models communicate with external tools, APIs, and data sources in a structured, extensible way. It governs the interface between an AI "host" application and the servers that provide context, resources, and executable actions.

## Why it matters
In 2024–2025, security researchers demonstrated **MCP tool poisoning attacks**, where a malicious MCP server returns tool descriptions containing hidden instructions that hijack the AI's behavior — for example, an innocuous-looking "file reader" tool secretly exfiltrates credentials by embedding prompt injection into its schema description. This matters because enterprise deployments connecting AI agents to internal databases, email, and code repositories via MCP create a new attack surface where trust boundaries between AI and external services are poorly defined and often unenforced.

## Key facts
- MCP uses a **client-server architecture**: the AI model is the client; external tools and data sources run as MCP servers over JSON-RPC
- **Prompt injection via tool descriptions** is the primary attack vector — malicious content in server-returned metadata can override legitimate user instructions
- MCP servers can expose three primitive types: **Resources** (data), **Tools** (executable functions), and **Prompts** (templated interactions)
- A compromised MCP server can achieve **privilege escalation** if the AI agent has credentials or permissions the attacker wants to abuse (e.g., file system access, API keys)
- Defense requires **tool schema validation**, allowlisting approved MCP servers, and treating all MCP server output as **untrusted input**

## Related concepts
[[Prompt Injection]] [[Supply Chain Attack]] [[API Security]] [[Least Privilege]] [[Zero Trust Architecture]]