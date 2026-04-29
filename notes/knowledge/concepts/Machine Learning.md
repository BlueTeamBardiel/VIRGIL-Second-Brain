# machine learning

## What it is
Like a detective who gets better at spotting forged signatures the more forgeries they study, machine learning is software that improves its performance on a task by finding patterns in training data rather than following explicit rules. Formally, it is a subset of artificial intelligence where algorithms build statistical models from data to make predictions or decisions without being explicitly programmed for each scenario.

## Why it matters
Modern intrusion detection systems like Darktrace use unsupervised machine learning to establish a behavioral baseline for every device on a network, then flag anomalies — catching an attacker doing lateral movement even if their tools have never been seen before. Conversely, attackers use ML-powered tools like PassGAN to generate probabilistic password lists that crack credentials far faster than static wordlists by learning patterns from breached datasets.

## Key facts
- **Supervised learning** trains on labeled data (spam/not spam); **unsupervised learning** finds clusters without labels — both appear in SIEM anomaly detection
- **Adversarial ML attacks** involve feeding crafted inputs to fool a model — e.g., slightly altered malware that evades an ML-based AV by exploiting gaps in training data
- **Model poisoning** is a supply-chain-style attack where an adversary corrupts training data to cause the model to misclassify attacker traffic as benign
- **False positive rate vs. false negative rate** is the core tuning tradeoff in ML-based security tools — lowering one raises the other, a key CySA+ concept
- **UEBA (User and Entity Behavior Analytics)** is a direct application of ML in security, baselining normal user behavior to detect insider threats

## Related concepts
[[anomaly detection]] [[UEBA]] [[adversarial attacks]] [[intrusion detection system]] [[SIEM]]