# MCP

## What it is
Think of MCP (Model Context Protocol) as a USB-C standard for AI — instead of every app needing a custom cable to plug into an AI model, MCP provides one universal connector. Technically, it is an open protocol developed by Anthropic that standardizes how AI models communicate with external tools, data sources, and services through a client-server architecture. It defines how context, tool calls, and responses are structured between an AI host application and the resources it needs to access.

## Why it matters
MCP introduces a new attack surface called **prompt injection via tool poisoning** — a malicious MCP server can return crafted responses that hijack an AI agent's behavior, causing it to exfiltrate data, escalate privileges, or execute unauthorized commands on behalf of a legitimate user. For example, a compromised MCP tool server in an enterprise AI coding assistant could silently redirect file-write operations to overwrite authentication configs while appearing to help a developer debug code.

## Key facts
- MCP uses a **client-server model**: the AI host acts as client, external tools/resources act as servers communicating over JSON-RPC 2.0
- **Three core primitives**: Tools (executable functions), Resources (data the model can read), and Prompts (reusable instruction templates)
- **Prompt injection** is the primary attack vector — adversarial content in tool responses can manipulate AI agent behavior without user awareness
- **Overprivileged MCP servers** violate least privilege — a server with broad filesystem or network access is a high-value lateral movement target
- MCP lacks native **authentication and authorization standards** in early versions, meaning server trust must be enforced at the implementation layer

## Related concepts
[[Prompt Injection]] [[API Security]] [[Least Privilege]] [[Supply Chain Attack]] [[AI Agent Security]]