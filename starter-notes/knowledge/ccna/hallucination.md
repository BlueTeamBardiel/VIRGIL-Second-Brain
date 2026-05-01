# hallucination

## What it is
Like a sleep-deprived witness who confidently describes a red getaway car that was actually blue, an AI language model generates plausible-sounding but factually incorrect or entirely fabricated outputs. Hallucination occurs when a large language model (LLM) produces responses that are syntactically fluent and confident yet unsupported by its training data or real-world facts.

## Why it matters
In a SOC environment, an analyst querying an AI assistant about a CVE might receive a fabricated CVSS score or a non-existent patch reference — leading to a misconfigured remediation priority or an unpatched critical vulnerability. Attackers can also deliberately exploit hallucination through prompt injection, crafting inputs that nudge an AI tool into generating false security advisories or bogus code that a developer blindly trusts and deploys.

## Key facts
- Hallucination is a fundamental LLM behavior, not a bug — it stems from statistical pattern completion rather than grounded reasoning or live knowledge retrieval
- Retrieval-Augmented Generation (RAG) is the primary mitigation: grounding LLM responses in verified, real-time document sources reduces fabrication rates
- AI-generated phishing content can hallucinate convincing but fake organizational details (names, emails, policies), making social engineering harder to detect
- Hallucination rates vary by model and task; code generation and legal/technical summarization are especially high-risk domains for security use cases
- Security tools that use LLMs for log analysis or threat intelligence must include human-in-the-loop validation to prevent acting on hallucinated indicators of compromise (IOCs)

## Related concepts
[[prompt injection]] [[large language model security]] [[social engineering]] [[threat intelligence]] [[retrieval-augmented generation]]
