# SuperAGI

## What it is
Think of it like giving an intern not just a task, but a fully equipped office, a phone, a computer, and the authority to hire help — then leaving them unsupervised. SuperAGI is an open-source autonomous AI agent framework that allows AI systems to self-direct, spawn sub-agents, use external tools, and pursue long-running goals without requiring human input at each step.

## Why it matters
In a red team scenario, an attacker could deploy a SuperAGI-style autonomous agent with access to web browsing, code execution, and API keys — allowing it to autonomously discover vulnerabilities, write exploits, and exfiltrate data across a multi-day campaign with minimal human oversight. This dramatically lowers the skill floor for persistent, adaptive attacks and challenges traditional detection models built around human-paced threat actors.

## Key facts
- SuperAGI is an **open-source autonomous agent platform** (GitHub-hosted) designed for deploying AI agents capable of multi-step task execution with tool use
- Supports **tool integration** (web search, file I/O, code execution) creating attack surface through uncontrolled external interactions
- Introduces the security concern of **prompt injection at scale** — malicious content in the environment can hijack an agent's goals mid-mission
- Autonomous agents can **persist API credentials and session tokens**, making credential hygiene and secrets management critical controls
- From a defense standpoint, monitoring autonomous agent activity requires **behavioral analytics** rather than signature-based detection, aligning with CySA+ threat hunting concepts

## Related concepts
[[Prompt Injection]] [[Autonomous Agents]] [[AI Supply Chain Security]] [[Credential Exposure]] [[Behavioral Analytics]]