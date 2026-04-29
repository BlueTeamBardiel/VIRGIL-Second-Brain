# vibrantlabsai RAGAS

## What it is
Like a food critic scoring a restaurant on taste, presentation, and value separately, RAGAS (Retrieval-Augmented Generation Assessment Score) is a multi-dimensional evaluation framework that measures RAG-based AI system quality across distinct axes. Developed as an open-source tool, it quantifies how faithfully an AI's answer reflects retrieved documents, how relevant the retrieval was, and how completely the answer addresses the question — without requiring human-labeled ground truth for every metric.

## Why it matters
In AI-assisted security operations (SIEM copilots, threat intel chatbots), a RAG pipeline might retrieve the wrong CVE context and generate a plausible-but-wrong remediation step — a **hallucination attack surface**. RAGAS metrics like *faithfulness* and *context precision* can catch cases where the model fabricates exploit details not present in the retrieved document, helping security teams validate AI output pipelines before deploying them in incident response workflows.

## Key facts
- **Four core metrics**: Faithfulness, Answer Relevancy, Context Precision, and Context Recall — each scoring 0–1
- **Faithfulness** detects hallucination by checking if every claim in the answer is grounded in retrieved context — critical for preventing AI-generated false security advisories
- **Context Precision** measures whether retrieved chunks are actually useful (low score = noisy retrieval = higher risk of misleading output)
- **No ground-truth labels required** for some metrics, enabling automated red-teaming of AI pipelines at scale
- Useful in **AI supply chain security** audits — evaluating third-party RAG tools embedded in security products for reliability and manipulation resistance

## Related concepts
[[Retrieval-Augmented Generation]] [[AI Hallucination]] [[Prompt Injection]] [[LLM Security Testing]] [[AI Red Teaming]]