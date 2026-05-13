# Data Poisoning

## What it is

In **Halo: Combat Evolved**, the Flood doesn't kill you — it converts you. A trooper takes one infection form to the chest and stands back up wearing the same armor, carrying the same rifle, walking the same patrol route. The model of "friendly Marine" is still intact. The training data — the uniform, the voice lines, the IFF tag — all check out. The behavior is what's wrong. By the time you notice, the squad you were supposed to reinforce is shooting you in the back. *That's data poisoning.*

Plain English: an attacker tampers with the data a machine learning model trains on, so the model learns the wrong lesson — and ships that wrong lesson to production. The model isn't broken in any way a scanner can see. The weights are valid. The pipeline ran clean. The predictions are wrong on purpose, in ways that benefit the attacker.

Technical definition: **data poisoning** is an integrity attack against the training stage of a machine learning lifecycle. The adversary injects, modifies, or mislabels training samples to manipulate the learned decision boundary — either degrading model accuracy broadly (availability poisoning) or implanting a specific input-to-output mapping the attacker can trigger later (targeted / backdoor poisoning). It is the ML analogue of supply chain compromise: the artifact is signed and valid, but the upstream input was corrupted.

This sits in CS0-003 Objective 2.2 because vulnerability assessment now includes ML pipelines — the training data store, the labeling workflow, the model registry — as assets your tools have to reason about. Most vuln scanners can't see this. That's the point.

## Why it matters

ML is in production decision paths now. Spam filtering, fraud scoring, EDR behavioral baselines, SOC alert triage, identity risk scoring, code review copilots, content moderation. When the model is wrong, the decision is wrong at machine speed and machine scale — millions of inferences before a human notices the drift.

Three reasons CySA+ analysts care:

1. **Your own tools use ML.** Modern EDR, UEBA, and SIEM correlation engines train on customer telemetry. If an attacker poisons the telemetry — fake "benign" beacons, label drift, sample flooding — your detection stack learns to ignore the next real attack.
2. **The business is shipping ML faster than security can scope it.** Data scientists pull training data from S3 buckets, Hugging Face repos, scraped web pages, and labeling vendors. Each one is an unmanaged supply chain.
3. **The exam tests modern threats.** CompTIA added AI/ML supply chain risk to CS0-003. Expect a scenario question where the "vulnerability" isn't a CVE — it's an unsigned training corpus or a public dataset pulled without integrity validation.

## Key facts

### The two flavors

| Type | Goal | Detection difficulty | Example |
|---|---|---|---|
| **Availability poisoning** | Degrade accuracy across the board | Easier — model just gets worse | Flood a spam filter with mislabeled samples until precision collapses |
| **Targeted / backdoor poisoning** | Implant a specific trigger → specific output | Very hard — model looks fine on test data | Train a face recognition model to unlock for anyone wearing a specific sticker pattern |

The targeted flavor is the dangerous one. The model passes acceptance tests. Loss curves look clean. Validation accuracy is unchanged. The backdoor only fires on the trigger input the attacker keeps in their pocket.

### Where the poison enters

- **Public datasets** — Common Crawl, Hugging Face, ImageNet mirrors, scraped reviews. No one signed any of it.
- **Labeling vendors** — Mechanical Turk-style pipelines where a $0.02 click decides ground truth.
- **User-generated input loops** — recommendation systems, chatbots, fraud scoring that retrain on production traffic. If the attacker can submit traffic, they can submit training data.
- **Insider in the data pipeline** — anyone with write access to the training bucket
- **Compromised model registry** — replace the artifact post-training (technically model poisoning, not data poisoning, but same blast radius)

### Why scanners miss it

Your CS0-003 toolkit — **[[Nessus]]**, **[[OpenVAS]]**, **[[Nikto]]**, **[[Nmap]]**, **[[Burp Suite]]**, **[[ZAP]]**, **[[Metasploit]]** — was built for CVEs, misconfigs, exposed services, and web app flaws. They scan code, hosts, and HTTP responses. They do not reason about training data integrity. A poisoned dataset has no CVE. The S3 bucket holding it is probably configured correctly. The model serving endpoint passes a TLS scan.

Cloud assessment tools — **[[Scout Suite]]**, **[[Prowler]]**, **[[Pacu]]** — get closer. They can flag a training bucket that's world-readable or an IAM role with overbroad write access. That's the supply chain hygiene layer. They still don't tell you whether the bytes inside are clean.

What does help, partially:

- **Dataset hashing and signing** — pin every training corpus version to a known hash. Treat datasets like software dependencies.
- **Data lineage tooling** — MLflow, DVC, Weights & Biases — answer "what data trained this model, who touched it, when."
- **Statistical anomaly detection on training data** — distribution drift, label flip rate, sample clustering. Looking for the infection form before the trooper stands back up.
- **Backdoor scanning research tools** — Neural Cleanse, ABS, STRIP — academic territory, not enterprise-ready, but moving fast.

### Adversary techniques to know

- **Label flipping** — adversary changes "malware" labels to "benign" in the training set. Cheap, effective, hard to spot at scale.
- **Clean-label attacks** — labels stay correct; the input itself is subtly modified so the model learns a wrong association. Harder to detect because nothing looks mislabeled.
- **Trigger / backdoor injection** — embed a specific pattern (pixel patch, byte sequence, phrase) in training samples that activates the malicious behavior at inference time.
- **Sybil flooding** — overwhelm a system that retrains on user input by submitting massive volumes of attacker-controlled samples. Tay (the chatbot) was a public, low-effort version of this.

### Defensive posture

1. **Treat training data as code.** Hash it, version it, sign it, gate it through change management.
2. **Air-gap retraining from untrusted input loops.** If your model retrains on user behavior, segment training data ingestion from production, require human review on sample inclusion, and rate-limit per-source contributions.
3. **Hold out a trusted validation set forever.** Never let the validation set come from the same pipeline as training. The validation set is your canary.
4. **Monitor for distribution drift.** Statistical baselines on feature distributions, label ratios, sample velocity per source.
5. **Restrict who can push to the training bucket and the model registry.** Same rigor as production code. Same audit trail.
6. **Red-team the pipeline.** Tabletop the question: "if I had write access to one source dataset for one week, what could I make the model do?"

### CompTIA exam traps

> **CompTIA exam trap:** Data poisoning vs. **adversarial input** (evasion). Poisoning attacks the *training* stage — the model learns wrong. Adversarial input attacks the *inference* stage — the model is fine, but the attacker crafts an input (perturbed image, crafted prompt) that fools it at runtime. CompTIA will give you a scenario and ask which attack class. Tell: did the attacker touch training data? → poisoning. Did the attacker only craft a malicious input at request time? → evasion.

> **CompTIA exam trap:** Data poisoning is an **integrity** attack in CIA terms, not confidentiality. The model isn't leaking data — it's making wrong decisions. If the question frames it as "data was exfiltrated," that's **model inversion** or **membership inference**, different attack class.

> **CompTIA exam trap:** The "tool" answer for ML supply chain risk on the CS0-003 is usually **cloud infrastructure assessment** (Scout Suite, Prowler) to validate the bucket and IAM around the data, not a traditional vuln scanner. The exam wants you to recognize that **[[Nessus]]** doesn't see this and that the control is upstream — bucket policy, signing, lineage.

## SOC reality

- The first sign is almost never an alert. It's a product manager in Slack asking "why is the fraud model approving everything from this one merchant ID?" or a customer support ticket pile growing on a single false-negative pattern. The SOC gets looped in third or fourth.
- L1 triage on a suspected ML compromise: pull the data lineage. Who wrote to the training bucket in the last 90 days? What was the dataset hash at training time? Does it match what's in the registry now? Most orgs cannot answer these questions in under a day.
- The CISO question is always: "Can the model be rolled back, and how far back is clean?" If you don't have a known-good snapshot and a clean validation set, the honest answer is "we don't know" — and that answer ends careers.
- Never promise "the model is fine, we retrained it." Retraining on the same poisoned source reproduces the poison. Eradication means rebuilding the dataset, not just the model.
- Escalation: L1 confirms the integrity question is real → L2 / IR pulls lineage and pipeline logs → ML platform team owns rollback → legal gets called if the model made consequential decisions (lending, hiring, content moderation, safety) during the poisoned window. Regulatory disclosure may apply under emerging AI rules — loop counsel early.

The blue team lesson: the Flood doesn't ring a doorbell. The trooper just stops being the trooper. *If your detection stack only watches the perimeter and the endpoint, the model that decides what an endpoint alert means is the soft target you never scanned.*

## Related concepts

[[Supply Chain Attack]] · [[Adversarial Machine Learning]] · [[Model Inversion]] · [[Membership Inference]] · [[Scout Suite]] · [[Prowler]] · [[Pacu]] · [[Cloud Infrastructure Assessment]] · [[Data Integrity]] · [[MLOps Security]] · [[Insider Threat]] · [[Vulnerability Assessment Tools]] · [[Threat Modeling]] · [[OWASP ML Top 10]]

*Source: VIRGIL knowledge base — 2026-05-11*