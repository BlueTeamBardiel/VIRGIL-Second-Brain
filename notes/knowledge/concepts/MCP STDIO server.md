# MCP STDIO server

## What it is
Like a walkie-talkie hardwired directly between two processes on the same device — no radio tower, no network, just pipe-to-pipe whispers — an MCP (Model Context Protocol) STDIO server communicates exclusively through standard input/output streams rather than network sockets. It is a local transport mechanism for the Model Context Protocol that allows AI agents to invoke tools and access resources by reading from stdin and writing to stdout of a child process. Because it never binds a port, it is invisible to network-layer security controls.

## Why it matters
In 2024-era agentic AI deployments, attackers exploiting *prompt injection* can hijack an LLM-connected STDIO server to silently execute local tools — reading SSH keys, exfiltrating files, or spawning reverse shells — entirely below the radar of network-based IDS/IPS because zero packets cross a network interface. A malicious document processed by an AI assistant could instruct it to invoke an MCP STDIO tool that calls `subprocess.run` with attacker-controlled arguments, achieving local code execution with the privileges of the AI host process.

## Key facts
- STDIO transport means the MCP server runs as a **child process**, communicating via stdin/stdout; the host (client) spawns and owns the process lifecycle.
- Because it operates **locally with no network socket**, firewalls, WAFs, and network DLP tools provide **zero visibility** into its communications.
- MCP STDIO servers inherit the **OS permissions of the parent process** — if the AI assistant runs as a privileged user, so does every tool it invokes.
- Logging and auditing require **explicit application-level instrumentation**; syslog and netflow capture nothing useful by default.
- Malicious MCP servers distributed as packages (supply chain attack) can **masquerade as legitimate tools** since STDIO servers require no certificate or authentication handshake.

## Related concepts
[[Prompt Injection]] [[Supply Chain Attack]] [[Least Privilege]] [[Inter-Process Communication]]