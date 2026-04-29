# Duqu

## What it is
Like a master spy who breaks into a safe not to steal the money, but to photograph the blueprints inside, Duqu is a sophisticated reconnaissance malware designed to harvest intelligence — not cause destruction. Discovered in 2011, it is a modular trojan closely related to Stuxnet, built to exfiltrate data from industrial control system vendors to enable future targeted attacks.

## Why it matters
Duqu was used to infiltrate certificate authorities and industrial equipment manufacturers, stealing design documents and cryptographic keys that could be weaponized in subsequent operations. By targeting the *suppliers* of critical infrastructure rather than the infrastructure itself, attackers demonstrated a sophisticated supply chain intelligence strategy — making defenders realize that protecting the end target isn't enough if the vendors building it are compromised.

## Key facts
- Duqu shares large portions of source code with Stuxnet, suggesting the same development team (likely a nation-state, widely attributed to the US/Israel Equation Group)
- It used a zero-day vulnerability in the Windows kernel via a malicious Word document (CVE-2011-3402) for initial infection
- Duqu communicated with C2 servers using encrypted JPEG files to conceal data exfiltration — a steganographic technique
- The malware was designed to self-delete after 36 days, limiting forensic investigation
- A second variant, **Duqu 2.0**, was discovered in 2015 and had compromised Kaspersky Lab's own network, as well as venues hosting Iranian nuclear negotiations

## Related concepts
[[Stuxnet]] [[Advanced Persistent Threat]] [[Zero-Day Exploit]] [[Supply Chain Attack]] [[Steganography]]