# fastchat

## What it is
Like a food truck that sets up anywhere to serve meals without a permanent restaurant license, FastChat is a lightweight, open-source framework that lets anyone spin up a local large language model (LLM) server with a chat interface on commodity hardware. Precisely, it is a distributed serving system for LLMs (including Vicuna, LLaMA variants) that exposes an OpenAI-compatible REST API, enabling local or self-hosted AI deployments without cloud dependency.

## Why it matters
Attackers and red teamers use FastChat to host uncensored or fine-tuned LLMs locally, bypassing the content filters and logging present in commercial APIs like OpenAI — making it a platform for generating phishing lures, malware code scaffolding, or social engineering scripts with no audit trail. Defensively, blue teams deploy FastChat internally to run air-gapped AI assistants that never transmit sensitive data to third-party cloud providers, reducing data exfiltration risk in regulated environments.

## Key facts
- FastChat exposes an OpenAI-compatible `/v1/chat/completions` endpoint, meaning any tool built for OpenAI can be redirected to a local, unmonitored model by simply changing the base URL
- Because FastChat runs locally, all prompts and responses are absent from commercial provider logs — defeating DLP controls that monitor cloud AI API traffic
- It supports multi-model serving and can load quantized models (GGUF/GPTQ), making deployment feasible on consumer GPUs as small as 8GB VRAM
- FastChat was the foundation for the **Vicuna** model release — one of the first high-quality open LLM chat models — giving it significant community adoption and a large ecosystem of jailbreak fine-tunes
- Security teams should treat internal FastChat deployments as shadow IT risks if stood up without authorization, as they create unmonitored AI inference endpoints on corporate networks

## Related concepts
[[Large Language Model Security]] [[Jailbreaking]] [[Shadow IT]] [[Data Loss Prevention]] [[API Security]]