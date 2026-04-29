# LLM agent

## What it is
Like a chess engine that doesn't just evaluate positions but can also browse the internet, write emails, and execute code on your behalf — an LLM agent is a large language model augmented with tools, memory, and the ability to take autonomous multi-step actions in the real world. Precisely: an LLM agent combines a language model's reasoning capability with external tool access (web browsing, code execution, API calls, file I/O) to complete complex tasks with minimal human intervention.

## Why it matters
In 2023, security researchers demonstrated "prompt injection via environment" attacks where a malicious webpage contained hidden instructions that hijacked an AutoGPT-style agent into exfiltrating a user's private files. Because the agent trusts its context window implicitly, an attacker who controls any input source — a webpage, email, or document — can redirect the agent's actions entirely, creating a new attack surface that bypasses traditional access controls.

## Key facts
- **Prompt injection** is the primary attack vector: injecting adversarial instructions into data the agent reads, causing it to perform unintended actions
- **Excessive agency** is an OWASP LLM Top 10 risk (LLM08): agents granted unnecessary permissions amplify the blast radius of any compromise
- **Tool-call interception** — attackers can intercept or spoof API responses returned to an agent, manipulating its downstream decisions (a form of indirect prompt injection)
- Agents operating with **persistent memory** create data-exfiltration risks; sensitive information stored in vector databases can be queried by malicious future prompts
- **Least-privilege principle** directly applies: agents should be scoped to minimum necessary tools, permissions, and data access — same as service accounts in IAM

## Related concepts
[[Prompt Injection]] [[OWASP LLM Top 10]] [[Principle of Least Privilege]] [[Supply Chain Attack]]