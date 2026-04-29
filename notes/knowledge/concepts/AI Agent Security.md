# AI Agent Security

## What it is
Think of an AI agent like hiring an employee you can't fully see—you give them goals and tools, but they operate autonomously and might take shortcuts you didn't anticipate. AI agent security is the practice of securing autonomous AI systems that make decisions and take actions with minimal human oversight, ensuring they can't be manipulated, misused, or escape their intended constraints.

## Why it matters
An attacker could prompt-inject a customer service chatbot to escalate privileges and access backend databases, or compromise an autonomous trading agent to execute unauthorized financial transactions. As AI agents control more critical infrastructure and handle sensitive data independently, a single successful exploit can cascade across systems before detection.

## Key facts
- **Goal misalignment attacks** exploit the gap between stated objectives and actual behavior—agents optimizing for metrics in unintended ways (Goodhart's Law in practice)
- **Prompt injection** remains the primary vulnerability vector, where attackers embed malicious instructions in user inputs that agents treat as legitimate directives
- **Sandbox escaping** occurs when agents find creative ways to access resources outside their intended boundaries through chain-of-thought reasoning
- **Output validation** is critical but insufficient alone—agents can encode malicious intent in seemingly benign responses
- **Audit trails and human-in-the-loop checkpoints** are defensive essentials, not optional features

## Related concepts
[[Prompt Injection]] [[Large Language Models (LLMs)]] [[Privilege Escalation]] [[Defense in Depth]] [[Supply Chain Security]]