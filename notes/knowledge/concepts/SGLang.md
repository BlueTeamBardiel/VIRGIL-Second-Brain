# SGLang

## What it is
Think of SGLang as a choreographer's script for a dance troupe — instead of directing each dancer individually mid-performance, you write out the entire routine in advance so every move is coordinated and efficient. SGLang (Structured Generation Language) is a programming framework for large language models (LLMs) that allows developers to define complex, multi-step prompting workflows with explicit control flow, parallelism, and structured outputs. It sits between the application layer and the LLM inference engine, optimizing how prompts are batched and executed.

## Why it matters
In adversarial AI contexts, SGLang pipelines can be targeted through **prompt injection attacks** — if user-supplied input flows into an SGLang program without sanitization, an attacker can hijack the control flow and cause the LLM to exfiltrate data, bypass guardrails, or generate malicious outputs. Defenders must treat SGLang programs like any other executable code path: validate inputs, restrict output schemas, and audit pipeline logic for injection points.

## Key facts
- SGLang enables **RadixAttention**, a KV-cache reuse mechanism that dramatically reduces inference latency by sharing computation across prompt branches — this caching can leak context between sessions if not properly isolated
- Structured outputs in SGLang enforce JSON/regex schemas, reducing hallucination attack surfaces but creating **denial-of-service risks** if schema validation loops are exploited
- SGLang programs are written in Python, meaning **supply chain attacks** targeting the SGLang package (via PyPI) could compromise every LLM application built on it
- Multi-agent SGLang pipelines expand the **attack surface** by chaining LLM calls — a compromised upstream call can poison all downstream reasoning steps
- SGLang's runtime exposes an **HTTP API endpoint** (compatible with OpenAI format), which must be authenticated and rate-limited to prevent unauthorized model access

## Related concepts
[[Prompt Injection]] [[LLM Security]] [[Supply Chain Attack]] [[API Security]] [[AI Red Teaming]]