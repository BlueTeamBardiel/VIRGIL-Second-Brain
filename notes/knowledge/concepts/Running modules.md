# Running modules

## What it is
Like a chef pulling a specific tool from a knife roll to perform one precise task, running modules in frameworks like Metasploit means selecting and executing a self-contained code unit designed to perform a single security function. Precisely: a module is a discrete, pre-built exploit, payload, auxiliary scanner, or post-exploitation script that an attacker or tester loads into a framework and fires against a target with configured parameters.

## Why it matters
During a penetration test, an operator loads the `ms17_010_eternalblue` Metasploit module, sets the RHOSTS parameter to a target IP, and executes it — achieving remote code execution on an unpatched Windows SMB service in seconds. Defenders monitoring with a SIEM can detect this activity by watching for characteristic SMB traffic patterns and the module's shellcode signatures in network payloads.

## Key facts
- In Metasploit, the command sequence is: `use <module>`, `set <options>`, `run` or `exploit` — understanding this workflow is testable on Security+
- Module types include: **exploits** (attack vulnerabilities), **payloads** (code delivered after exploitation), **auxiliary** (scanners/fuzzers), **post** (post-exploitation actions), and **encoders** (obfuscate payloads)
- Running a module without proper authorization is a federal crime under the Computer Fraud and Abuse Act (CFAA) — scope documents and ROE protect penetration testers
- The `check` command in Metasploit tests whether a target is *vulnerable* without actively exploiting it — useful for safe reconnaissance
- Meterpreter is a commonly tested payload module that runs entirely in memory, leaving minimal disk artifacts and evading many AV solutions

## Related concepts
[[Metasploit Framework]] [[Exploit Payloads]] [[Post-Exploitation]] [[Penetration Testing Methodology]] [[Indicators of Compromise]]