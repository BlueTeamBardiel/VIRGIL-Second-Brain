# Search AI

## What it is
Like a reference librarian who has memorized every book but sometimes confidently cites a book that doesn't exist, Search AI systems augment traditional search engines by generating synthesized answers using large language models rather than simply returning a list of links. Precisely, Search AI refers to AI-powered tools (e.g., Microsoft Copilot, Google AI Overviews, Perplexity) that combine retrieval-augmented generation (RAG) with real-time web indexing to produce natural-language answers to queries.

## Why it matters
Attackers exploit Search AI through **prompt injection via poisoned web content** — embedding hidden instructions in indexed pages so that when the AI scrapes and summarizes that content, it outputs attacker-controlled text, potentially leaking sensitive session data or directing users to malicious URLs. In 2024, researchers demonstrated that Bing's AI chat could be manipulated through indirect prompt injection from a malicious webpage to exfiltrate a user's personal information from earlier in the conversation.

## Key facts
- **Prompt injection** is the primary attack surface: malicious text in retrieved content hijacks AI output, bypassing the user's original intent
- Search AI can enable **data exfiltration** by embedding invisible instructions (e.g., white text on white background) in web pages that the AI "reads" during summarization
- **Hallucination** — confidently fabricated answers — creates risk in security contexts when users trust AI-generated CVE details, policy summaries, or compliance guidance without verification
- **RAG poisoning** targets the retrieval pipeline specifically: corrupting indexed sources to persistently skew AI-generated answers at scale
- From a defense perspective, organizations should classify Search AI tools under **Shadow AI** policies and restrict use with sensitive internal queries through DLP controls

## Related concepts
[[Prompt Injection]] [[Retrieval-Augmented Generation]] [[Shadow AI]] [[Data Loss Prevention]] [[Social Engineering]]