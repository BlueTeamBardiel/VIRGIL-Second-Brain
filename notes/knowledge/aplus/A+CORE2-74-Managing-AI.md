# Managing AI

## What it is

A junior tech pastes a customer's full email — name, account number, support history — into a free public chatbot and asks it to "write a polite reply." The reply is fine. The data is now sitting on someone else's server, used to train someone else's model, governed by someone else's privacy policy. The customer never consented. The company never approved that tool. The tech just had a privacy incident and doesn't know it yet.

In plain English: AI is now part of the IT workflow whether your company has a policy for it or not. Your job is to know what AI is good at, what it lies about, what data you can feed it, and what the rules say. The tools are mind-like — they reason, summarize, generate — but they have no soul, no memory of your context, and no understanding of what they're not allowed to see.

Technically: generative AI (LLMs, image models, code assistants) is a class of machine learning system that produces probabilistic outputs from training data. It does not "know" things. It predicts the next likely token based on patterns. That distinction is the source of every limitation, every hallucination, and every policy headache in this objective.

## Why it matters

Objective 220-1202 4.10 is new for a reason. Every enterprise is now writing AI acceptable-use policies, every vendor is bolting AI features into existing products, and every helpdesk tech is being asked questions like "can I use ChatGPT for this?" by users who genuinely don't know. The exam tests whether you understand integration paths, the technology's hard limits, the difference between public and private deployments, and the eight policy concerns CompTIA explicitly names: bias, data security, appropriate use, hallucinations, data source, plagiarism, accuracy, and data privacy.

This is also where junior techs get fired. Pasting customer PII into a public model violates GDPR, HIPAA, PCI-DSS, and most internal data classification policies in one motion. The exam wants you to know the rules before your first day on a real ticket queue.

## In your build, in the enterprise

**Beat 1 — Technical depth.** AI integration happens at three layers. First, **API integration**: an application calls a hosted model (OpenAI, Anthropic, Azure OpenAI, AWS Bedrock) over HTTPS, sending prompts and receiving completions. Second, **embedded features**: Microsoft Copilot inside Word and Excel, GitHub Copilot inside VS Code, Adobe Firefly inside Photoshop — the AI lives inside an app you already own. Third, **local/self-hosted models**: Ollama, LM Studio, vLLM running on your own hardware, with weights downloaded from Hugging Face (Llama, Mistral, Qwen, DeepSeek). The deployment model determines where your data goes and who sees it. Public hosted = your prompts leave your network. Private hosted (Azure OpenAI with a tenant-scoped endpoint) = stays in your cloud subscription. Local = never leaves the box.

**Beat 2 — Feynman example via the homelab.** You decide to run AI locally on your gaming rig. You've got a 4090 with 24GB VRAM, 64GB system RAM, a Ryzen 9.

**The download:** You pull a 70B-parameter Llama model from Hugging Face. It's 40GB. *Models are huge — VRAM and disk are the gating factors.*

**The quantization:** Full precision won't fit in 24GB VRAM. You grab a 4-bit quantized version — same model, compressed weights, slight accuracy loss. Now it fits. *Quantization is how consumer GPUs run "big" models.*

**The first prompt:** You ask it who won the 2025 Super Bowl. It confidently names the wrong team. The model's training cutoff was eight months before the game. *No internet access, no real-time knowledge — it makes up a plausible answer. That's a hallucination, and the model has no idea it's wrong.*

**The realization:** You ask it to summarize a PDF of your medical records. It does. The data never left your machine. No API call, no third-party server, no privacy violation. *Local inference is the privacy model. Slow, expensive in hardware, but yours.*

**Beat 3 — Bridge from homelab to enterprise.** Same question, different builds:

- **Gaming homelab:** local Ollama on the 4090. Privacy by air gap. Slow on 70B models, fine for 13B.
- **Small business:** Microsoft 365 Copilot. Data stays inside the Microsoft 365 tenant, governed by the existing Microsoft data processing agreement. No new vendor, no new contract.
- **Enterprise security org:** Azure OpenAI Service deployed in the company's own Azure tenant. Prompts never train the public model. Logged, auditable, scoped by Entra ID.
- **Regulated industry (healthcare, finance, defense):** fully air-gapped on-premise model serving via vLLM on company-owned GPUs. Nothing touches the public internet. Slow to deploy, expensive, mandatory.

**Beat 4 — The point.** Same fundamental question: *where does the data go, and who can see it?* Different deployments, different right answers. The hardware question (can my GPU run this model?) is trivial compared to the data question (am I allowed to put this into this model?). Get the data-flow question into your bones — it's the one your security team will ask you, and it's the one CompTIA tests.

## Key facts

### Public vs. private AI

| Type | Where it runs | Who sees prompts | Use case |
|---|---|---|---|
| **Public** (ChatGPT free, Gemini free, Claude free) | Vendor's cloud | Vendor, possibly used for training | Personal use, never sensitive data |
| **Public API** (OpenAI API, Anthropic API) | Vendor's cloud | Vendor, contractually not used for training (paid tier) | Apps with non-sensitive data |
| **Private cloud** (Azure OpenAI, AWS Bedrock) | Your cloud tenant | Only you and the cloud provider | Enterprise workloads with sensitive data |
| **Self-hosted** (Ollama, vLLM, on-prem) | Your hardware | Only you | Regulated data, full sovereignty |

The line CompTIA tests: **public AI tools default to using your prompts as training data unless you've explicitly opted out or paid for a tier that contractually prohibits it.** Free = you are the product.

### Application integration patterns

- **Embedded copilots** — Microsoft 365 Copilot, GitHub Copilot, Adobe Firefly. Lives inside the application. Honors the app's existing permissions model.
- **API-driven features** — a CRM that summarizes call transcripts, a ticketing system that auto-categorizes incoming tickets. The vendor calls a model behind the scenes.
- **RAG (Retrieval-Augmented Generation)** — the AI is given access to your company's documents (SharePoint, Confluence, a wiki) and answers questions using that data. Common pattern for internal knowledge bots.
- **Agents** — AI that takes actions (sends emails, creates tickets, runs scripts). Highest risk category — the model can do things, not just say things.

### Limitations — what AI cannot do

- **Real-time knowledge.** Models have a training cutoff. Anything after that date is invisible unless the model has web search or RAG.
- **Math and counting.** LLMs predict tokens, not numbers. They will confidently get arithmetic wrong.
- **Determinism.** Same prompt, different answers. Bad for anything requiring reproducibility.
- **Source verification.** The model cannot tell you with certainty where it got an answer. Citations are often fabricated.
- **Context length.** Every model has a token limit. Past it, earlier context is dropped or forgotten.
- **Reasoning under uncertainty.** Models don't say "I don't know." They say something plausible.

### The eight policy concerns

| Concern | What it means | Example failure |
|---|---|---|
| **Bias** | Training data encodes social and historical biases | Resume-screening AI downranks candidates from certain schools |
| **Data security** | Prompts may be logged, stored, breached | Customer SSN pasted into public ChatGPT |
| **Appropriate use** | Not every task is an AI task | Tech uses AI to write a termination letter without HR review |
| **Hallucinations** | Confidently-stated false output | AI cites a court case that doesn't exist |
| **Data source** | You don't always know what the model was trained on | Model trained on copyrighted books reproduces passages |
| **Plagiarism** | AI output may duplicate copyrighted training material | Marketing copy that triggers a DMCA claim |
| **Accuracy** | Plausible-sounding ≠ correct | Configuration command that bricks a switch |
| **Data privacy** | User data in prompts may violate GDPR, HIPAA, PCI-DSS | PHI in a prompt sent to a non-BAA-covered model |

### CompTIA exam traps

> **CompTIA exam trap:** confusing "private AI" with "secure AI." A private deployment (Azure OpenAI in your tenant) keeps data out of the public training pool, but it doesn't automatically encrypt prompts, audit access, or prevent insider misuse. Private is a data-flow boundary, not a security control. CompTIA tests the distinction.

> **CompTIA exam trap:** treating hallucinations as a bug to be patched. Hallucinations are a structural property of how LLMs work — they predict likely tokens, not verified facts. No model is hallucination-free. Mitigation = RAG, citation requirements, human review. Elimination is not on the table.

> **CompTIA exam trap:** assuming "the AI did it" is a defense. If a tech uses AI to generate a config that breaks production, the tech is accountable, not the model. Acceptable-use policies make this explicit. Output requires human review.

## Helpdesk reality

- **"Can I use ChatGPT for work?"** — answer depends on your company's policy and the data involved. Default answer: use the company-approved tool (Copilot, internal Azure OpenAI) and never paste customer data, credentials, or internal documents into a public free tool.
- **"The AI gave me this command — should I run it?"** — never run AI-generated commands on production without reading every line and understanding what it does. The model will confidently suggest `rm -rf` against the wrong path.
- **"My screenshot has an error I don't recognize."** — drop it into your **company-approved** AI tool (Copilot, Now Assist) for recognition assist. Never use a personal account. Never use a tool security hasn't vetted.
- **"Can the AI access my files?"** — Microsoft 365 Copilot can read anything the user already has permission to read. If your sharing permissions were sloppy before, Copilot just made that visible. Permissions hygiene is now AI hygiene.
- **Never promise the AI is private** unless you've personally verified the deployment model and the data processing agreement. "It's Microsoft, it must be safe" is not verification.

## Related concepts

[[Data Classification]] · [[Acceptable Use Policy]] · [[Regulated Data PII PHI PCI]] · [[Change Management]] · [[Incident Response]] · [[Software Licensing]] · [[Privacy Policies]]

*Source: VIRGIL knowledge base — 2026-05-11*