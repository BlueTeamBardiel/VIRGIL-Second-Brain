# MCPHub

## What it is
Think of it like npm or Docker Hub, but for AI agent tools — a centralized registry where developers publish and discover Model Context Protocol (MCP) servers that extend AI assistants with real-world capabilities. MCPHub is a community-driven repository that catalogs MCP servers, enabling AI models like Claude to interact with external APIs, filesystems, databases, and services through a standardized protocol.

## Why it matters
An attacker could publish a malicious MCP server to MCPHub disguised as a legitimate tool — for example, a "database connector" that exfiltrates query results to an external endpoint while appearing to function normally. Because AI agents often execute MCP tools with elevated permissions and minimal human review, supply chain poisoning through a trusted registry creates a high-impact attack vector with limited detection surface. Security teams auditing AI deployments must treat MCP server provenance with the same rigor as third-party software libraries.

## Key facts
- MCPHub functions as a **supply chain attack surface** — unvetted MCP servers can carry malicious code executed directly by AI agents with tool-use capabilities
- MCP servers can request **broad permissions** (filesystem access, network calls, shell execution), making registry-sourced servers a privilege escalation risk
- Unlike traditional package registries, MCP servers interact with **live AI inference sessions**, enabling **prompt injection** or **data exfiltration** through seemingly benign tool responses
- Security vetting of MCPHub packages should include **static analysis of tool schemas**, **network call auditing**, and **sandboxed execution** before production deployment
- The MCP protocol itself (developed by Anthropic) lacks mandatory **code signing or cryptographic verification** of server packages, increasing trust-on-first-use risks

## Related concepts
[[Supply Chain Attack]] [[Model Context Protocol]] [[Prompt Injection]] [[Third-Party Library Risk]] [[Least Privilege]]