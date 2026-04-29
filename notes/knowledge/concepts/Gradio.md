# Gradio

## What it is
Think of Gradio like a pop-up kiosk that lets a chef demo their recipes to the public — it wraps a machine learning model in a quick web interface so anyone can poke at it without touching the kitchen. Precisely, Gradio is an open-source Python library that generates instant web UIs for ML models, APIs, and data pipelines, typically running on port 7860 and optionally exposed via Hugging Face Spaces or public share links.

## Why it matters
Security researchers have discovered misconfigured Gradio instances publicly accessible on the internet — some exposing internal model inference endpoints, file upload handlers, or even arbitrary code execution via crafted inputs. In 2024, CVE-2024-1561 and related vulnerabilities in Gradio allowed path traversal attacks through its file-serving endpoints, enabling attackers to read arbitrary files from the host server. This makes Gradio a real attack surface in AI/ML pipelines that often live outside traditional security review.

## Key facts
- Default behavior creates a **public share link** (`share=True`) tunneled through Gradio's servers — exposing internal tools to the internet unintentionally
- Runs on **port 7860** by default; misconfigured deployments are fingerprinted and indexed by Shodan
- Vulnerable to **path traversal** (CVE-2024-1561) and **SSRF** via file and URL input components if unpatched
- Gradio apps can expose **model inversion and prompt injection** opportunities when wrapping LLMs without input sanitization
- Authentication is **opt-in** via `gr.Blocks(auth=...)` — it is disabled by default, making unauthenticated exposure a common misconfiguration

## Related concepts
[[Path Traversal]] [[Server-Side Request Forgery]] [[Prompt Injection]] [[Attack Surface Management]] [[API Security]]