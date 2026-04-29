# Claude

## What it is
Like a highly capable intern with no memory between shifts — helpful, articulate, but potentially manipulated by whoever wrote the briefing note they're reading. Claude is a large language model (LLM) developed by Anthropic, designed with a focus on "Constitutional AI" to reduce harmful outputs through built-in alignment training.

## Why it matters
In red team exercises, security researchers have demonstrated **prompt injection attacks** against Claude and similar LLMs integrated into enterprise workflows — where malicious instructions embedded in a webpage or document cause the AI to exfiltrate conversation data or bypass safety filters. Defenders must treat LLM inputs as untrusted user data, just like SQL queries, and sanitize accordingly.

## Key facts
- Claude uses **Constitutional AI (CAI)**: a technique where the model critiques and revises its own outputs against a set of principles — reducing reliance on purely human-labeled "harmful" data
- Like all LLMs, Claude is vulnerable to **prompt injection**, **jailbreaking**, and **indirect prompt injection** (malicious instructions hidden in content the AI processes)
- Claude operates as a **stateless session model** by default — no persistent memory across conversations unless explicitly given memory tools (relevant to data minimization principles under privacy frameworks)
- Anthropic's model cards classify Claude's risk tiers — relevant to **AI risk governance** frameworks like NIST AI RMF and emerging CISA AI security guidance
- Deploying Claude via API in a production environment falls under **third-party AI risk**, requiring supply chain security review similar to any SaaS dependency

## Related concepts
[[Prompt Injection]] [[Large Language Model Security]] [[AI Supply Chain Risk]] [[Constitutional AI]] [[Jailbreaking]]