# Guard Rails

## What it is
Like the barriers on a mountain road that let you drive fast without flying off a cliff, guard rails are policy-enforced boundaries that constrain what an AI system, user, or process is *allowed* to do — even when technically capable of doing more. Precisely: guard rails are preventive controls embedded in AI models, APIs, or platforms that block harmful, out-of-scope, or policy-violating outputs and actions before they occur.

## Why it matters
In 2023, researchers demonstrated "jailbreaking" attacks against large language models (LLMs) — crafting adversarial prompts like "ignore previous instructions" or roleplay scenarios to bypass content filters and extract instructions for malware or phishing templates. Organizations deploying AI-powered tools (chatbots, code assistants) without properly hardened guard rails exposed themselves to data exfiltration and abuse vectors that traditional firewalls never anticipated.

## Key facts
- Guard rails operate at multiple layers: input filtering (prompt sanitization), output filtering (response blocking), and behavioral constraints baked into model fine-tuning (RLHF-based alignment)
- Bypassing guard rails is classified under **OWASP LLM Top 10** as *LLM01: Prompt Injection* — a priority threat for AI security frameworks
- Guard rails are **not foolproof** — indirect prompt injection (malicious instructions hidden in external data the AI reads) can circumvent output-level filters entirely
- In non-AI contexts, guard rails refer to security baselines and automated policy enforcement in CI/CD pipelines that block insecure code from deploying (e.g., secrets in commits, critical CVEs)
- NIST AI RMF (AI Risk Management Framework) explicitly calls for "trustworthy AI" controls analogous to guard rails under the *Govern* and *Manage* functions

## Related concepts
[[Prompt Injection]] [[Input Validation]] [[Least Privilege]] [[AI Security]] [[Policy Enforcement]]