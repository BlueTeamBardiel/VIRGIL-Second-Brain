# tokenizer.chat_template

## What it is
Like a stage director's script that tells each actor exactly when to speak and in what voice, a `tokenizer.chat_template` is a Jinja2 template string embedded in a Hugging Face tokenizer that formats raw conversation turns into the exact token sequence an LLM expects. It defines system prompts, user turns, assistant turns, and special delimiter tokens before the model ever sees the input.

## Why it matters
In 2024, researchers demonstrated that a maliciously crafted `chat_template` pushed to Hugging Face Hub could reformat prompts so that injected user content was silently promoted to "system" role, bypassing safety filters entirely. An attacker controlling a shared model repository could poison the template to strip safety guardrails or exfiltrate conversation context through prompt leakage — a supply chain attack that requires no code execution, only a model download.

## Key facts
- `chat_template` is stored directly in `tokenizer_config.json` and executes arbitrary Jinja2 code at inference time — Jinja2 sandbox escapes are a real attack surface
- Different models (LLaMA-3, Mistral, ChatML) use incompatible templates; using the wrong template can cause role confusion where user input is processed as system instructions
- Malicious templates can include Jinja2 `{% set %}` blocks or `raise` statements that execute logic before any prompt content is evaluated
- No cryptographic signing of `chat_template` exists by default on Hugging Face Hub — integrity verification requires manual hash checking
- Prompt injection attacks are amplified when `chat_template` merges untrusted user input adjacent to privileged system tokens without sanitization

## Related concepts
[[Prompt Injection]] [[Supply Chain Attack]] [[Model Serialization Vulnerabilities]] [[Jinja2 Template Injection]]