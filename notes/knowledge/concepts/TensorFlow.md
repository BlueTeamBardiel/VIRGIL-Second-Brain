# TensorFlow

## What it is
Think of TensorFlow like a factory assembly line where raw numbers enter one end and predictions exit the other — each station (layer) transforms the data in a learned way. Precisely, TensorFlow is Google's open-source machine learning framework that uses computational graphs to build, train, and deploy neural networks across CPUs, GPUs, and TPUs. It provides the mathematical infrastructure that powers everything from image recognition to malware classification engines.

## Why it matters
Security teams increasingly use TensorFlow to build anomaly detection models that identify malicious network traffic by learning baseline behavioral patterns. Adversarially, attackers have exploited TensorFlow-based models through adversarial examples — subtly crafted inputs that fool a malware classifier into labeling a malicious binary as benign, effectively bypassing AI-driven endpoint detection. This attack class (adversarial ML) is a growing concern as defenders deploy more ML-based security controls.

## Key facts
- TensorFlow models can be attacked via **model inversion** — feeding the model crafted queries to reconstruct sensitive training data, a privacy violation relevant to GDPR compliance
- **Pickle-based model files** (`.pkl`) and TensorFlow SavedModels can contain malicious serialized code; loading untrusted model files is a supply chain attack vector
- TensorFlow Lite enables on-device inference, making it a target for **hardware-side-channel attacks** on embedded/IoT security systems
- Adversarial ML attacks (evasion, poisoning, model extraction) against TensorFlow models are tracked under **MITRE ATLAS** — the adversarial ML companion to ATT&CK
- Google's **TensorFlow Privacy** library implements differential privacy to prevent training data leakage from deployed models

## Related concepts
[[Adversarial Machine Learning]] [[Supply Chain Attacks]] [[Anomaly-Based Detection]]