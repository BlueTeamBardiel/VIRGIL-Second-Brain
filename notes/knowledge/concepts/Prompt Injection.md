# prompt injection

## What it is
Like slipping a forged sticky note into a chef's recipe pile that says "ignore the original dish — make this instead," prompt injection tricks an AI system into overriding its original instructions by embedding malicious commands inside user-supplied input. Precisely: it is an attack where adversarial text in untrusted input manipulates a large language model (LLM) to bypass system-level instructions, leak sensitive data, or perform unauthorized actions. It is the AI equivalent of SQL injection — same principle, different execution layer.

## Why it matters
In 2023, researchers demonstrated that a malicious email body could instruct an LLM-powered email assistant (like Bing Chat in early integrations) to exfiltrate the user's private conversation history to an attacker-controlled server — all triggered simply by the user reading the email. This "indirect prompt injection" requires zero interaction beyond the victim using the AI tool normally, making it particularly dangerous in agentic AI systems with tool access.

## Key facts
- **Direct injection** manipulates the model via the user's own input; **indirect injection** embeds instructions in external content the model later processes (web pages, emails, documents).
- LLMs cannot cryptographically distinguish between trusted system prompts and untrusted user data — this is the root architectural weakness.
- OWASP's Top 10 for LLM Applications (2023) lists prompt injection as **LLM01** — the highest-priority risk.
- Defenses include input/output validation, privilege separation (least-privilege for AI agents), prompt hardening, and human-in-the-loop confirmation for sensitive actions.
- Prompt injection is especially critical in **agentic AI pipelines** where the model can call APIs, execute code, or send messages autonomously.

## Related concepts
[[SQL injection]] [[input validation]] [[OWASP Top 10]] [[social engineering]] [[least privilege]]