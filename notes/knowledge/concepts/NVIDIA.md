# NVIDIA

## What it is
Like a massive switchboard that routes thousands of phone calls simultaneously instead of one at a time, NVIDIA GPUs process thousands of parallel computations at once rather than sequentially. NVIDIA is a hardware manufacturer whose Graphics Processing Units (GPUs) were originally designed for rendering graphics but are now critical infrastructure for AI/ML workloads, cryptographic operations, and high-performance computing. Their CUDA parallel computing platform has made them the dominant hardware layer beneath most modern AI security tools and adversarial attacks.

## Why it matters
Threat actors leverage NVIDIA GPUs to dramatically accelerate password cracking — a modern RTX 4090 can crack NTLM hashes at roughly 300 billion attempts per second, reducing an 8-character password from years to minutes. Defenders use the same GPU acceleration in SIEM platforms and ML-based anomaly detection engines that process massive log volumes in near real-time. This hardware asymmetry means GPU availability increasingly determines both attack capability and defensive response speed.

## Key facts
- **GPU-accelerated cracking tools** like Hashcat exploit NVIDIA CUDA to attack MD5, NTLM, SHA-1, and bcrypt hashes orders of magnitude faster than CPU-only approaches
- **NVIDIA drivers have had critical CVEs** (e.g., CVE-2021-1076, privilege escalation via kernel driver) — GPU drivers are an often-overlooked attack surface on workstations and servers
- **CUDA is the API layer** attackers and defenders both use; understanding it helps contextualize why GPU-equipped cloud instances (AWS P-series, Azure NC-series) are rented for credential attacks
- **AI/ML security tools** — including endpoint behavioral analysis and network traffic classifiers — depend on NVIDIA hardware for training and inference speed
- **Supply chain risk**: NVIDIA chips in data center infrastructure represent a hardware supply chain concern, especially given export controls targeting adversary nation-states

## Related concepts
[[Password Cracking]] [[Hash Functions]] [[Hardware Security]] [[Machine Learning in Security]] [[Supply Chain Attacks]]