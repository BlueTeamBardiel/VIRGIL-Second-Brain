# LangChain-ChatChat

## What it is
Like a librarian who can search your entire private document collection and answer questions about it — but one that sometimes gets tricked into leaking the restricted shelf. LangChain-ChatChat is an open-source framework built on LangChain that enables organizations to deploy local knowledge-base chatbots, connecting large language models (LLMs) to private document stores via retrieval-augmented generation (RAG). It is designed for on-premise, air-gapped deployments where data sovereignty matters.

## Why it matters
In 2024, a CVE was disclosed (CVE-2024-5998 and related issues) in LangChain-ChatChat exposing a path traversal and arbitrary file read vulnerability — an attacker sending a crafted API request could exfiltrate sensitive files outside the intended document directory. This is critical in enterprise deployments where the knowledge base may contain HR records, source code, or internal security policies, turning a helpful internal tool into a data exfiltration endpoint.

## Key facts
- **Path Traversal (CWE-22)** is the primary vulnerability class: unsanitized file path inputs allowed `../` sequences to escape the document root directory.
- LangChain-ChatChat exposes a REST API; unauthenticated or weakly authenticated endpoints dramatically expand the attack surface in misconfigured deployments.
- RAG pipelines introduce a **prompt injection** risk: malicious content embedded in ingested documents can manipulate LLM behavior or extract system prompts.
- Defense requires strict **input validation**, chroot-equivalent directory jailing, and API authentication (e.g., token-based auth) on all document-serving endpoints.
- Supply chain risk is elevated — LangChain-ChatChat bundles multiple dependencies (FAISS, HuggingFace libraries) each carrying their own vulnerability surface.

## Related concepts
[[Path Traversal]] [[Prompt Injection]] [[Retrieval-Augmented Generation]] [[API Security]] [[Supply Chain Risk]]