# deep learning

## What it is
Like teaching a child to recognize cats not by giving them rules ("four legs, whiskers, fur") but by showing them 10,000 cat photos until their brain wires itself — deep learning trains layered neural networks to extract patterns directly from raw data without explicit programming. It is a subset of machine learning using multi-layered artificial neural networks (deep neural networks) that automatically learn hierarchical feature representations from large datasets. Each layer transforms its input into progressively more abstract representations until a final classification or prediction emerges.

## Why it matters
Security vendors use deep learning in next-gen antivirus to detect novel malware by analyzing raw byte sequences rather than signature hashes — enabling detection of zero-day variants that share no known signatures. Conversely, attackers use Generative Adversarial Networks (GANs), a deep learning architecture, to synthesize hyper-realistic deepfake audio and video for CEO fraud campaigns, bypassing human verification entirely.

## Key facts
- Deep learning models require massive labeled datasets and GPU compute; shallow ML models like decision trees work on smaller datasets
- Adversarial examples — carefully crafted inputs with tiny perturbations invisible to humans — can reliably fool deep learning classifiers, a critical reliability concern in security tooling
- Deep learning powers modern UEBA (User and Entity Behavior Analytics) tools that baseline normal behavior and flag anomalies without hand-coded rules
- Model poisoning attacks target the training phase: an attacker who corrupts training data can embed backdoors causing the model to misclassify specific inputs on demand
- Unlike traditional signature-based detection, deep learning models produce probabilistic outputs — high false positive rates remain a real operational challenge in SOC environments

## Related concepts
[[machine learning]] [[adversarial attacks]] [[user and entity behavior analytics (UEBA)]] [[malware analysis]] [[generative AI threats]]