# Woody RAT

## What it is
Think of it as a master spy who slips into an office by pretending to be a memo from HR — once inside, it records everything and reports back silently. Woody RAT is a sophisticated Remote Access Trojan (RAT) first discovered in 2022 that targets Russian organizations by masquerading as legitimate documents, granting attackers persistent remote control over compromised systems. It combines multiple persistence mechanisms with encrypted command-and-control (C2) communication, making it difficult to detect and evict.

## Why it matters
In 2022, threat actors launched spear-phishing campaigns against Russian aerospace and defense entities, delivering Woody RAT through malicious `.doc` files exploiting the Follina vulnerability (CVE-2022-30190) or macro-laden Office documents. Once deployed, the RAT allowed attackers to exfiltrate sensitive files, execute remote commands, and maintain long-term persistence — demonstrating how targeted espionage campaigns weaponize legitimate file formats to bypass initial defenses.

## Key facts
- Woody RAT uses **two primary delivery mechanisms**: malicious Office macros and the Follina (CVE-2022-30190) MSDT exploit, making patching and macro controls critical defenses.
- It achieves **persistence via Windows Registry Run keys** and scheduled tasks, surviving reboots without re-infection.
- C2 communication is **encrypted**, often blending with normal HTTPS traffic to evade network-based detection.
- Capable of **keylogging, screenshot capture, file exfiltration, and remote shell execution** — a full-featured espionage toolkit.
- Attributed to an **unknown advanced threat actor** targeting Russian organizations, suggesting geopolitical or nation-state motivations during the Russia-Ukraine conflict period.

## Related concepts
[[Remote Access Trojan]] [[Follina CVE-2022-30190]] [[Spear Phishing]] [[Command and Control (C2)]] [[Persistence Mechanisms]]