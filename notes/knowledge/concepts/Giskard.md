# Giskard

## What it is
Like a crash-test dummy lab for AI models, Giskard is an open-source testing and evaluation framework that stress-tests machine learning models — particularly LLMs — for safety vulnerabilities, biases, and failure modes before they reach production. It systematically probes models the way a penetration tester probes a network: looking for weaknesses you didn't know existed.

## Why it matters
As organizations deploy LLM-powered applications (chatbots, decision-support tools, automated analysts), adversaries exploit undetected model vulnerabilities through prompt injection, jailbreaking, and data leakage. Giskard provides automated red-teaming scans that surface these risks during development — for example, detecting that a customer-service AI can be manipulated into revealing internal policy documents through carefully crafted user prompts, before attackers discover it first.

## Key facts
- Giskard performs **automated vulnerability scanning** for AI/ML models, covering categories like prompt injection, hallucination, sensitive data disclosure, and stereotype/bias issues
- It integrates with the **OWASP Top 10 for LLM Applications**, mapping detected issues to standardized risk categories relevant to compliance audits
- Giskard supports both **traditional ML models** (tabular classifiers) and **generative AI/LLMs**, making it applicable across the full AI security surface
- The framework generates **human-readable test reports** that document vulnerabilities with severity ratings, bridging the gap between data science teams and security reviewers
- Giskard's **adversarial test generation** is LLM-assisted — it uses an AI to automatically craft attack prompts against the target model, simulating real threat actor behavior

## Related concepts
[[Prompt Injection]] [[LLM Security]] [[AI Red Teaming]] [[OWASP LLM Top 10]] [[Model Security Testing]]