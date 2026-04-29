# LiteLLM

## What it is
Think of LiteLLM as a universal power adapter for AI models — just as one adapter lets you plug any device into any country's outlet, LiteLLM provides a single unified API that lets developers call 100+ different large language models (OpenAI, Anthropic, Gemini, etc.) through one consistent interface. It acts as a proxy and translation layer, abstracting away each provider's unique API format into a standardized call.

## Why it matters
In enterprise environments, LiteLLM deployments can become high-value attack targets because they aggregate API keys for multiple AI providers in one location — compromising a single LiteLLM proxy server can expose credentials for dozens of AI services simultaneously. Additionally, LiteLLM's logging and routing features mean that sensitive prompts and responses from across an organization flow through one choke point, creating risks of data exfiltration or prompt injection attacks that affect multiple downstream models at once.

## Key facts
- LiteLLM can be self-hosted as a proxy server, meaning its security posture depends entirely on the organization's configuration — misconfigurations (open ports, weak auth) have led to exposed admin panels in the wild
- CVE-2024-35181 identified a path traversal vulnerability in LiteLLM allowing unauthenticated attackers to read arbitrary files from the server
- LiteLLM centralizes API key management, making it a **secrets sprawl** risk if the master key or environment variables are improperly secured
- The proxy supports virtual keys (scoped credentials), which when misconfigured can grant broader model access than intended — a principle of least privilege failure
- Because LiteLLM sits between users and AI providers, it is a natural insertion point for **man-in-the-middle** style prompt logging or manipulation

## Related concepts
[[API Security]] [[Secrets Management]] [[Proxy Server Attacks]] [[Prompt Injection]] [[Supply Chain Risk]]