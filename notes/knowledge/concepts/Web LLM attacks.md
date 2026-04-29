# Web LLM attacks

## What it is
Like slipping a forged work order into a contractor's clipboard so they carry out unauthorized tasks on your behalf, Web LLM attacks manipulate large language models integrated into web applications to perform actions or reveal data outside their intended scope. Specifically, attackers craft malicious inputs — prompts — to hijack the model's behavior, exfiltrate sensitive context, or pivot through the application's connected APIs and tools.

## Why it matters
In 2023, researchers demonstrated that AI-powered customer service chatbots could be prompt-injected via hidden text embedded in user-uploaded documents, causing the LLM to silently exfiltrate conversation history to an attacker-controlled endpoint. This matters because LLMs are increasingly granted access to internal APIs, databases, and user accounts — turning a successful injection into a full-privilege abuse scenario.

## Key facts
- **Prompt injection** is the primary attack vector: malicious instructions hidden in user input or external data (indirect injection) override the model's system prompt.
- **Indirect prompt injection** occurs when the poisoned content comes from a third-party source the LLM retrieves — a webpage, email, or document — not directly from the attacker's input.
- **Excessive agency** vulnerabilities arise when LLMs are granted more permissions or API access than their tasks require, magnifying the blast radius of a successful injection.
- **Data exfiltration via LLM** can occur through out-of-band channels: the model is instructed to make HTTP requests embedding stolen data in URLs or parameters.
- Defense principles include **least-privilege API access**, treating all external content as untrusted, and implementing **human-in-the-loop confirmation** for sensitive LLM-driven actions.

## Related concepts
[[Prompt Injection]] [[Insecure Direct Object Reference]] [[API Security]] [[Supply Chain Attacks]] [[Privilege Escalation]]