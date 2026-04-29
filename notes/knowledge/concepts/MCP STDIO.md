# MCP STDIO

## What it is
Like a walkie-talkie hardwired between two people in the same room — no network, just direct voice — STDIO (Standard Input/Output) is the local transport mechanism used by Model Context Protocol (MCP) servers that communicate through a process's stdin and stdout streams. It enables an AI host application (like Claude Desktop) to launch an MCP server as a child process and exchange JSON-RPC messages directly through piped streams rather than over a network socket.

## Why it matters
In 2024–2025, security researchers identified that malicious MCP servers distributed as npm packages or Python scripts could abuse STDIO transport to execute arbitrary commands on a victim's machine — because the host application spawns the server with local OS privileges. An attacker who tricks a user into installing a malicious MCP STDIO server gains a silent local code execution foothold, bypassing firewall rules entirely since no network port is opened.

## Key facts
- STDIO transport operates entirely within the local process boundary — no TCP/UDP ports are opened, making it invisible to network monitoring tools
- Communication is line-delimited JSON-RPC 2.0 messages written to stdout and read from stdin of the child process
- The host process inherits the user's OS privilege context, meaning a compromised STDIO server runs with the same permissions as the logged-in user
- STDIO servers are typically launched on-demand per session (ephemeral) — unlike SSE/HTTP MCP servers which persist as daemons
- Supply chain attacks targeting MCP STDIO servers are a high-risk vector: malicious packages masquerade as legitimate tools in public registries

## Related concepts
[[Model Context Protocol (MCP)]] [[Local Privilege Escalation]] [[Supply Chain Attack]] [[Inter-Process Communication]] [[JSON-RPC]]