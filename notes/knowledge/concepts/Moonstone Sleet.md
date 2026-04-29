# Moonstone Sleet

## What it is
Like a chameleon that builds fake film studios to audition victims, Moonstone Sleet is a North Korean state-sponsored threat actor that uses elaborate fake companies and trojanized software to conduct espionage and financial theft. Tracked by Microsoft, it is distinguished from other DPRK clusters by its use of custom ransomware and unique infrastructure — blending financial crime with intelligence-gathering objectives.

## Why it matters
In 2024, Moonstone Sleet deployed a fake game development company called "C2 Games," luring developers with job offers and distributing a trojanized version of the PuTTY SSH client. Once installed, the malicious payload established persistence and exfiltrated credentials — demonstrating how social engineering wrapped in legitimate-looking business operations can bypass technical defenses entirely.

## Key facts
- Attributed to North Korea's Lazarus Group ecosystem, first formally named by Microsoft in May 2024 as a distinct cluster
- Uses **FakePenny ransomware** — a custom ransomware strain used for financial extortion after espionage objectives are met in the same intrusion
- Distributes malware through **trojanized npm packages**, making software supply chain compromise a primary delivery vector
- Creates fake personas on LinkedIn and freelance platforms to approach targets in defense, aerospace, and cryptocurrency sectors
- Overlaps with but is distinct from Diamond Sleet (Lazarus); Microsoft separated them due to unique TTPs and infrastructure

## Related concepts
[[Lazarus Group]] [[Supply Chain Attack]] [[Spear Phishing]] [[Ransomware]] [[Living Off the Land Binaries]]