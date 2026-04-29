# LLM security

## What it is
Like a brilliant intern who will follow *any* instruction slipped into their inbox — even from a malicious sticky note someone hid inside a PDF they were asked to summarize — LLMs can be manipulated through their inputs rather than their code. LLM security encompasses the practices and threat models surrounding the deployment of large language models, addressing how attackers exploit the model's instruction-following behavior to bypass safety controls, leak data, or hijack actions.

## Why it matters
In 2023, researchers demonstrated that a malicious webpage could embed invisible prompt injection text, causing an AI assistant (with browser access) to silently exfiltrate a user's private emails to an attacker-controlled server. This "indirect prompt injection" requires no code execution — only the model reading attacker-controlled content — making traditional perimeter defenses nearly useless.

## Key facts
- **Prompt injection** is the #1 LLM attack vector: adversarial text in user input or external data overrides system instructions (analogous to SQL injection overriding query logic)
- **Jailbreaking** bypasses model safety filters using roleplay, encoding tricks, or token smuggling (e.g., "Do Anything Now" / DAN attacks)
- **Training data poisoning** corrupts model behavior at the source — attackers who contribute to public datasets can embed backdoor triggers
- **Data exfiltration via LLMs** can occur when models with tool access (email, file systems) are manipulated into leaking context window contents
- OWASP published the **OWASP Top 10 for LLMs** (2023), making LLM-specific risks an emerging exam-relevant framework alongside traditional OWASP Top 10
- **Insecure output handling** occurs when downstream systems blindly execute LLM-generated content (SQL, shell commands, HTML) without sanitization

## Related concepts
[[Prompt Injection]] [[Supply Chain Attacks]] [[Input Validation]] [[OWASP Top 10]] [[Privilege Escalation]]