# RAM Extraction

## What it is
Like flash-freezing a chef mid-recipe to read their mind — you capture volatile memory at a precise moment to see exactly what the system was *doing*, not just what it stored. RAM extraction (also called memory forensics or live memory acquisition) is the process of capturing the contents of a running system's volatile memory (RAM) to recover encryption keys, process data, credentials, and artifacts that never touch the disk.

## Why it matters
During the 2014 investigation of the Target breach, forensic analysts used memory forensics to recover the BlackPOS malware scraping payment card data directly from RAM — the malware was designed to avoid writing to disk precisely to evade traditional forensics. Without RAM extraction, the attack mechanism would have remained invisible. Defenders now routinely capture memory images during incident response *before* powering off a compromised host.

## Key facts
- **Order of volatility**: RAM is the most volatile evidence and must be collected first — it vanishes completely on power loss (NIST 800-86 guidance)
- **Tools**: Volatility Framework is the industry-standard open-source tool for analyzing memory dumps; WinPmem and DumpIt are common acquisition tools
- **What's recoverable**: Encryption keys (including BitLocker keys), plaintext passwords, running process lists, network connections, and injected shellcode
- **Cold boot attack**: An attacker can freeze RAM chips (literally with compressed air) to slow electron decay and read contents seconds to minutes after power-off — this is a physical attack vector
- **Fileless malware detection**: RAM extraction is often the *only* way to detect fileless malware (e.g., PowerShell-based attacks) that lives entirely in memory

## Related concepts
[[Memory Forensics]] [[Order of Volatility]] [[Fileless Malware]] [[Cold Boot Attack]] [[Incident Response]]