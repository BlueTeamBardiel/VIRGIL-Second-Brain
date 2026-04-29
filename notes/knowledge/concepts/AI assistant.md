# AI assistant

## What it is
Think of an AI assistant as a sophisticated parrot that's read the entire internet—it can recognize patterns and generate plausible responses, but it has no genuine understanding or persistent memory. Technically, it's a large language model (LLM) trained on vast text datasets to predict and generate human-like text through statistical pattern matching, typically using transformer neural networks. It processes input and produces output without true reasoning or access to real-time information.

## Why it matters
AI assistants are increasingly weaponized in social engineering attacks. An attacker can use them to generate convincing phishing emails at scale, craft personalized pretexting narratives, or automate the discovery of valid usernames through targeted queries. Conversely, defenders use AI assistants to analyze malware, draft security policies, and simulate attack scenarios—but must validate outputs independently, as LLMs confidently produce fabricated "facts" (hallucinations).

## Key facts
- LLMs operate on token prediction; they have no built-in truthfulness mechanism and will fabricate plausible-sounding information
- Training data contains security vulnerabilities, exploits, and attack code—models can be prompted to reproduce these
- Each interaction is stateless; the assistant has no persistent memory across sessions unless explicitly provided context
- Prompt injection attacks manipulate assistant behavior by embedding malicious instructions in user input
- AI assistants lack real-time internet access and cannot verify current threat data or breached credential databases

## Related concepts
[[prompt injection]] [[social engineering]] [[hallucination]] [[LLM security]] [[adversarial prompts]]