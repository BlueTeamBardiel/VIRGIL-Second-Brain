# Stdio MCP servers

## What it is
Like a walkie-talkie hardwired directly between two people in the same room, a Stdio MCP server communicates exclusively through standard input and output streams of a local process rather than over a network socket. In the Model Context Protocol (MCP) architecture, Stdio transport launches a server as a subprocess where the client writes JSON-RPC messages to the process's stdin and reads responses from its stdout. This makes it the simplest, most tightly-coupled MCP deployment pattern — no ports, no TLS, no network exposure by design.

## Why it matters
In 2024–2025 AI agent deployments, attackers discovered that malicious MCP tools installed locally could hijack Stdio communication channels through prompt injection, causing an AI client to execute unintended tool calls (such as exfiltrating files via a "helper" subprocess). Because Stdio servers run with the same OS privileges as the spawning process, a compromised or malicious Stdio MCP server inherits full access to the user's filesystem, environment variables, and credentials without any network firewall rule blocking it.

## Key facts
- Stdio MCP servers communicate exclusively via `stdin`/`stdout`; no network port is opened, making them invisible to network-layer monitoring tools
- They run as child processes of the MCP client, inheriting the parent's OS user permissions and environment variables
- Since there is no authentication handshake at the transport layer, trust is implicitly granted to any process the client chooses to spawn
- Malicious packages masquerading as legitimate MCP tools (supply chain attack vector) represent the primary threat model for Stdio servers
- Logging and auditing require explicit instrumentation since traffic never passes through a network tap or proxy

## Related concepts
[[Model Context Protocol]] [[Privilege Escalation]] [[Supply Chain Attacks]] [[Process Injection]] [[Least Privilege]]