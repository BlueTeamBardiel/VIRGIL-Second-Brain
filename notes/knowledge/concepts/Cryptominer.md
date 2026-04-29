# Cryptominer

## What it is
Like a squatter who breaks into your house not to steal your furniture, but to run their cryptocurrency mining rig on your electricity bill — a cryptominer (or cryptojacker) is malware that hijacks a victim's CPU/GPU cycles to mine cryptocurrency for the attacker without the owner's knowledge or consent.

## Why it matters
In 2018, attackers compromised the LA Times' AWS S3 bucket and injected a Monero-mining script (Coinhive) into the site's code, turning every visitor's browser into an unwitting miner. This illustrates both a web delivery vector and why Monero is preferred — its privacy features make transactions harder to trace than Bitcoin.

## Key facts
- **Two primary forms:** file-based malware installed on endpoints, and **fileless/browser-based** scripts (JavaScript) that run only while a page is open
- **Monero (XMR)** is the cryptocurrency of choice because it uses the CryptoNight algorithm optimized for CPUs, and its ring signatures obscure sender identity
- **Key IOC:** sustained high CPU usage (often 90–100%) on systems with no obvious workload; also look for unusual outbound connections to mining pools
- **Drive-by cryptomining** can occur without malware installation — a malicious or compromised webpage is enough; closing the tab stops the attack
- On Security+/CySA+, cryptominers are classified as **PUPs (Potentially Unwanted Programs)** or malware depending on consent, and are detected via behavioral analysis and network traffic anomalies (connections to known mining pool domains/IPs)

## Related concepts
[[Fileless Malware]] [[Botnet]] [[Indicators of Compromise]] [[Command and Control]] [[Drive-by Download]]