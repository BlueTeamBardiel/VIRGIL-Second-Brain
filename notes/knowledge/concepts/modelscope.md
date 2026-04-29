# modelscope

## What it is
Think of ModelScope like a GitHub for AI models — a platform where developers publish, share, and download pre-trained machine learning models as easily as cloning a repository. Precisely, ModelScope is an open-source model-as-a-service (MaaS) platform developed by Alibaba DAMO Academy that hosts thousands of AI/ML models across vision, NLP, and audio domains. Users can download and run models directly via Python packages with minimal code.

## Why it matters
In 2023, researchers discovered that ModelScope's Python library contained a critical **arbitrary code execution vulnerability (CVE-2024-45845)** — simply loading a malicious model file could trigger code execution on the victim's machine, because model deserialization (via pickle) runs embedded Python code without sandboxing. An attacker publishing a poisoned model to a shared repository could compromise every data scientist or ML pipeline that pulls and loads it, turning a "download model" command into a supply chain attack vector identical to malicious PyPI packages.

## Key facts
- **Deserialization attacks** are the primary risk: Python's `pickle` format, commonly used for ML model serialization, executes arbitrary code on load — ModelScope models using this format inherit the vulnerability
- ModelScope hosts **100,000+ models** and is widely used in China-adjacent AI development pipelines, making it a high-value supply chain target
- Attacks against platforms like ModelScope are classified under **MITRE ATLAS tactic: ML Supply Chain Compromise (AML.T0010)**
- Defense requires **model scanning tools** (e.g., ProtectAI's ModelScan) before loading any third-party model artifact
- The risk parallels **SolarWinds-style supply chain attacks** — trust in the distribution platform becomes the attack surface, not the model's AI behavior itself

## Related concepts
[[Supply Chain Attack]] [[Deserialization Vulnerability]] [[AI/ML Security]] [[Dependency Confusion]] [[MITRE ATLAS]]