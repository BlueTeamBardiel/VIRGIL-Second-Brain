# Deep Learning Side-Channel Analysis

## What it is
Like a safecracker who learns to feel the subtle vibrations of each tumbler without ever seeing the lock's internal mechanism, deep learning side-channel analysis trains neural networks to extract secret information from unintended physical emissions — power consumption, electromagnetic radiation, timing variations — rather than attacking the cryptographic algorithm directly. It is a class of side-channel attack where machine learning models, particularly CNNs and MLPs, automatically learn distinguishing features from physical measurements to recover cryptographic keys without requiring manual feature engineering.

## Why it matters
In 2019, researchers demonstrated a deep learning-based power analysis attack against AES-128 implementations on an STM32 microcontroller, recovering the secret key in fewer than 50 power traces — a dramatic improvement over classical Differential Power Analysis which required thousands. This fundamentally threatens embedded devices like smart cards, HSMs, and IoT sensors where physical access is achievable by an adversary.

## Key facts
- **Profile attacks** use a two-phase model: training on a cloned "profiling device," then attacking the target — deep learning excels here because it handles noisy, high-dimensional trace data automatically
- **CNNs outperform MLPs** on desynchronized traces because convolutional layers capture local temporal patterns despite timing jitter
- Masking countermeasures (standard defense against classical DPA) are **not sufficient** against deep learning attacks at higher masking orders without significant trace counts
- **Hamming weight** and **Hamming distance** leakage models are the most common labels used to train neural networks in profiled attacks
- Data augmentation techniques (adding synthetic noise, trace shifting) are used both to improve attack models and as **defensive countermeasures** to mislead attackers

## Related concepts
[[Side-Channel Attack]] [[Differential Power Analysis]] [[Cryptographic Implementation Security]]