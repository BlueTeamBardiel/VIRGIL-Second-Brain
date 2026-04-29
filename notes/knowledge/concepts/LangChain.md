# LangChain

## What it is
Think of LangChain like a power strip for AI — it lets you plug multiple tools, data sources, and language models together so they can work as one coordinated system. Precisely, LangChain is an open-source framework that enables developers to build applications by chaining together large language model (LLM) calls with external tools, memory, and APIs. It abstracts the orchestration layer between AI models and the real-world systems they interact with.

## Why it matters
LangChain-based agents are increasingly used in autonomous security tools — think AI assistants that can query threat intelligence databases, run code, and browse the web in sequence. This same capability creates an attack surface: adversaries can craft malicious inputs that hijack the agent's chain of reasoning, causing it to exfiltrate data, execute unintended commands, or bypass access controls — a technique called **prompt injection**. A real-world example is a LangChain agent connected to a company's internal documents being tricked via a poisoned PDF into leaking sensitive files.

## Key facts
- LangChain supports **tool use** — agents can call external APIs, run SQL queries, or execute shell commands, dramatically expanding the blast radius of a compromised agent
- **Prompt injection** is the primary attack vector: malicious content in retrieved data overrides the agent's original instructions
- LangChain applications often use **RAG (Retrieval-Augmented Generation)**, meaning attacker-controlled documents can influence model behavior at runtime
- Chain-of-thought execution means a single injection can trigger **multiple downstream actions** before a human notices
- Security controls must include **input validation, output filtering, and least-privilege tool scoping** for any LangChain deployment

## Related concepts
[[Prompt Injection]] [[Large Language Models]] [[RAG Poisoning]] [[AI Supply Chain Attacks]] [[API Security]]