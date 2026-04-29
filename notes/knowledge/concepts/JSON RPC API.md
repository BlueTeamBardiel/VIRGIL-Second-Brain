# JSON RPC API

## What it is
Think of it like a waiter at a restaurant: you hand them a slip of paper naming the dish you want, they disappear into the kitchen, and return with exactly that result — the kitchen never sees you directly. JSON-RPC is a lightweight remote procedure call protocol that uses JSON-encoded messages to request named functions on a remote server over HTTP/HTTPS or WebSockets. Unlike REST, it uses a single endpoint and distinguishes operations by method name embedded in the request body.

## Why it matters
Ethereum nodes expose a JSON-RPC API (default port 8545) that, if left publicly accessible without authentication, allows attackers to call `eth_sendTransaction` and drain cryptocurrency wallets — a real attack pattern seen against misconfigured cloud-hosted blockchain nodes. Defenders must firewall this port and require API key authentication, since the protocol itself provides no built-in auth mechanism.

## Key facts
- JSON-RPC messages contain four fields: `jsonrpc` (version), `method` (function name), `params` (arguments), and `id` (correlates request to response)
- Version 2.0 added named parameters and batch requests (multiple calls in one HTTP POST), which can amplify abuse if rate limiting is absent
- No native authentication or authorization — security must be layered externally via API gateways, tokens, or network controls
- Batch request abuse can cause server-side DoS by flooding a single endpoint with hundreds of expensive method calls simultaneously
- Common in blockchain platforms (Ethereum, Bitcoin), internal microservices, and VS Code's Language Server Protocol — broad attack surface beyond just crypto

## Related concepts
[[REST API Security]] [[API Authentication]] [[Denial of Service]] [[Web Application Firewall]] [[Insecure Direct Object Reference]]