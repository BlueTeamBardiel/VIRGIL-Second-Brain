# OpenAI Codex CLI

## What it is
Think of it as a junior developer who never sleeps — you describe a task in plain English through your terminal, and it writes, edits, and executes code autonomously on your machine. OpenAI Codex CLI is an open-source command-line agent that connects GPT-4o (or similar models) to your local filesystem and shell, enabling multi-step agentic coding tasks. It operates in configurable trust modes ranging from fully sandboxed to auto-executing, where it can run commands without human confirmation.

## Why it matters
In a red team scenario, a compromised developer workstation running Codex CLI in "full-auto" mode becomes a force multiplier — an attacker who gains prompt injection access through a malicious repository could instruct the agent to exfiltrate SSH keys, modify CI/CD pipeline scripts, or create backdoored commits without the developer noticing. Defensively, security teams must evaluate AI coding agents as privileged processes with filesystem and shell access, applying least-privilege principles and monitoring tool output the same way they would audit a privileged user session.

## Key facts
- Codex CLI runs with three trust modes: **Suggest** (read-only), **Auto-edit** (writes files, no shell), and **Full-auto** (executes arbitrary shell commands) — misconfiguration is a direct attack surface
- **Prompt injection** is the primary threat vector: malicious content in files or web pages can redirect the agent's actions against the user
- The tool uses **sandboxing via macOS Seatbelt or Docker** in safer modes, but sandbox escapes remain an active research area
- It is **open-source** (MIT license), meaning security researchers can audit and threat-model its execution flow directly
- Supply chain risk applies: the CLI itself and its model plugins must be verified, as a tampered local model config could redirect API calls to a malicious endpoint

## Related concepts
[[Prompt Injection]] [[Agentic AI Security]] [[Least Privilege]]