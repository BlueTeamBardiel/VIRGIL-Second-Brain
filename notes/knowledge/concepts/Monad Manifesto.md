# Monad Manifesto

## What it is
Like a hacker's recipe book that chains cooking steps together — each step takes the previous output and passes it cleanly to the next — the Monad Manifesto is a foundational document from the offensive security community (associated with the Monad/PowerShell development era) outlining a philosophy for chaining commands and automating system administration through a unified scripting environment. More broadly in security contexts, it refers to the design principles behind PowerShell's pipeline-oriented, object-passing architecture that made it both a powerful administration tool and a premier attacker's framework.

## Why it matters
Attackers leverage PowerShell's monadic chaining philosophy to execute fileless malware — pulling a payload directly from the internet, decoding it in memory, and executing it without ever touching disk, all in a single piped command. Defenders must understand this architecture to properly configure Constrained Language Mode, script block logging, and AMSI (Antimalware Scan Interface) to detect and break these chains.

## Key facts
- PowerShell was originally codenamed **"Monad"**; the Monad Manifesto (2002, Jeffrey Snover) outlined its object-pipeline design philosophy
- Unlike cmd.exe which passes **text**, PowerShell passes **.NET objects** between pipeline stages — making it far more powerful for both admins and attackers
- The manifesto directly influenced **Living off the Land (LotL)** attack techniques by providing attackers a pre-installed, trusted execution environment
- **Script Block Logging** (Event ID 4104) is the primary CySA+-relevant control for detecting malicious PowerShell chains
- AMSI integration allows antivirus engines to inspect PowerShell content **at runtime**, even when obfuscated or base64-encoded

## Related concepts
[[PowerShell Attack Techniques]] [[Living off the Land (LotL)]] [[Fileless Malware]] [[AMSI (Antimalware Scan Interface)]] [[Script Block Logging]]