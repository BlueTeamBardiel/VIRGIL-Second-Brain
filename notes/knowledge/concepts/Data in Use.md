# Data in use

## What it is
Like a document pulled out of a locked filing cabinet and spread open on a desk — visible to anyone walking by — data in use is information actively being processed by a CPU or held in RAM. It is the most vulnerable state of data because it must be decrypted and accessible to be worked on, meaning encryption alone cannot protect it.

## Why it matters
In a cold boot attack, an adversary with brief physical access can reboot a running machine and dump the contents of RAM before it clears, extracting encryption keys and plaintext credentials that were actively in use. This is why full-disk encryption like BitLocker doesn't fully protect a running, logged-in laptop left unattended — the keys are already loaded in memory.

## Key facts
- The three states of data are **data at rest** (stored), **data in transit** (moving across a network), and **data in use** (being processed) — all three appear on Security+ exams.
- **Trusted Execution Environments (TEEs)** and **secure enclaves** (e.g., Intel SGX) are hardware-level defenses specifically designed to protect data in use from other processes, including the OS.
- **Homomorphic encryption** is an emerging cryptographic technique that allows computation on encrypted data without decrypting it, theoretically eliminating the data-in-use vulnerability.
- Memory scraping malware (common in point-of-sale attacks like the Target breach) targets data in use by reading payment card data directly from RAM before it can be encrypted.
- Privileged access to a hypervisor can expose data in use across all guest virtual machines — a key risk in multi-tenant cloud environments.

## Related concepts
[[Data at Rest]] [[Data in Transit]] [[Trusted Execution Environment]] [[Cold Boot Attack]] [[Memory Scraping Malware]]