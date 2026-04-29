# lm-sys fastchat

## What it is
Think of it as a "Lego kit for LLM chatbots" — a pre-built, open-source framework that lets anyone rapidly assemble and deploy a conversational AI service without writing the plumbing from scratch. FastChat, developed by the LMSYS organization, is an open-source platform for training, serving, and evaluating large language models, providing a REST API compatible with OpenAI's interface along with a multi-model chat UI called Chatbot Arena.

## Why it matters
In 2023, FastChat's OpenAI-compatible API endpoint became an attack surface when organizations self-hosted it without authentication — exposing internal LLM inference servers to the open internet. Attackers could craft prompt injection payloads through the `/v1/chat/completions` endpoint to exfiltrate system prompts, abuse compute resources (GPU hijacking), or pivot into internal networks if the server had excessive permissions.

## Key facts
- FastChat exposes an OpenAI-compatible REST API (`/v1/chat/completions`, `/v1/models`) meaning any tool built for OpenAI can point to a self-hosted FastChat instance — including attacker tooling
- Default deployments lack built-in authentication; securing it requires reverse proxies (nginx + bearer tokens) or API gateway layering
- Hosts the **Chatbot Arena** benchmark — used to evaluate model safety, meaning vulnerabilities in the platform can corrupt red-team/blue-team evaluation integrity
- Supports multi-model serving via a controller/worker architecture — a compromised controller node can redirect all model traffic
- CVE-relevant concern: dependency chain attacks through FastChat's pip packages (e.g., `fschat`) can introduce malicious code into AI infrastructure

## Related concepts
[[Prompt Injection]] [[API Security]] [[Supply Chain Attack]] [[LLM Security]] [[Model Serving Infrastructure]]