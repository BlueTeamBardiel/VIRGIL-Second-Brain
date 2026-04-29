# biometric scanner

## What it is
Like a bouncer who memorizes your face instead of checking your ID card, a biometric scanner authenticates identity by measuring unique physical or behavioral characteristics rather than something you carry or remember. It captures a biological trait — fingerprint, iris pattern, facial geometry, or voiceprint — converts it into a mathematical template, and compares that template against stored references at each authentication attempt.

## Why it matters
In 2019, researchers demonstrated that consumer fingerprint scanners could be defeated with a "MasterPrint" — a synthetic partial fingerprint matching enough common ridge patterns to unlock roughly 65% of smartphones tested at a 0.1% false acceptance threshold. This attack exploits the fact that partial fingerprint matching (used for speed) dramatically inflates false acceptance rates, meaning biometrics alone cannot be trusted as single-factor authentication for high-security systems.

## Key facts
- **Two error rates define scanner quality**: False Acceptance Rate (FAR) — letting impostors in — and False Rejection Rate (FRR) — locking out legitimate users; the Crossover Error Rate (CER/EER) is where FAR equals FRR and benchmarks overall accuracy.
- Biometric data is **not revocable** — unlike a password, you cannot reissue someone a new fingerprint if the template database is breached.
- **Liveness detection** (anti-spoofing) is a required countermeasure; without it, a high-resolution photo or silicone mold can defeat optical and capacitive scanners.
- Under Security+, biometrics are classified as **"something you are"** — the third authentication factor alongside knowledge and possession.
- Biometric templates stored centrally represent a **high-value target**; best practice is on-device storage (e.g., Apple Secure Enclave) to prevent bulk credential theft.

## Related concepts
[[multi-factor authentication]] [[false acceptance rate]] [[authentication factors]] [[liveness detection]] [[Secure Enclave]]