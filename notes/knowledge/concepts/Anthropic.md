# Anthropic

## What it is
Like a car manufacturer that obsesses over crash-test safety before shipping vehicles, Anthropic is an AI safety company that builds large language models (LLMs) with alignment and interpretability as core design constraints — not afterthoughts. Founded in 2021 by former OpenAI researchers, Anthropic develops the Claude family of AI assistants using a technique called Constitutional AI (CAI) to reduce harmful outputs.

## Why it matters
In enterprise security contexts, organizations deploying Claude via Anthropic's API must still assess prompt injection risks — attackers can craft inputs that manipulate the model into bypassing safety guardrails, leaking system prompts, or generating restricted content. Security teams evaluating AI tools need to understand that even "safety-focused" models introduce attack surfaces like indirect prompt injection, where malicious instructions are embedded in data the model processes (e.g., a webpage or document).

## Key facts
- Anthropic introduced **Constitutional AI (CAI)**: training LLMs against a written set of principles using AI feedback (RLAIF — Reinforcement Learning from AI Feedback) rather than purely human feedback
- The **Claude model family** (Claude 1, 2, 3, Sonnet, Haiku, Opus) is Anthropic's primary commercial product, competing directly with OpenAI's GPT series
- Anthropic publishes **responsible scaling policies** — commitments to pause deployment if models reach dangerous capability thresholds (relevant to AI governance frameworks)
- From a **threat modeling** perspective, Anthropic's APIs require API key management, making them subject to credential theft and abuse (OWASP API Security Top 10 relevance)
- Anthropic's research on **mechanistic interpretability** aims to reverse-engineer what circuits inside neural nets are doing — directly relevant to AI transparency in regulated industries (NIST AI RMF)

## Related concepts
[[Large Language Model Security]] [[Prompt Injection]] [[AI Governance]] [[API Security]] [[OWASP LLM Top 10]]