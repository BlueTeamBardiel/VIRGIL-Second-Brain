# FIN10

## What it is
Like a professional extortionist who breaks into a casino's back office, photographs the accounting books, and demands protection money — FIN10 is a financially motivated threat actor group that specializes in intrusion-based extortion rather than traditional fraud. Specifically, FIN10 targets North American organizations (particularly Canadian casinos and mining companies), exfiltrating sensitive data and threatening public exposure unless ransoms are paid.

## Why it matters
In documented campaigns, FIN10 breached casino operators, stole personally identifiable information and internal communications, then emailed executives directly with extortion demands ranging from 100–200 Bitcoin. Organizations without robust data loss prevention (DLP) controls and incident response plans faced both financial extortion and potential regulatory penalties from the exposed data — a double-threat scenario that defenders must account for separately from ransomware playbooks.

## Key facts
- **Active period**: First documented operating roughly 2013–2016, primarily targeting Canadian gambling and resource extraction industries
- **TTPs**: Used spear-phishing for initial access, then deployed legitimate remote access tools (like Meterpreter and PowerShell Empire) to blend into normal traffic — a classic "living off the land" approach
- **Monetization model**: Pure extortion — no encryption, no ransomware deployment; leverage was *stolen data exposure*, not operational disruption
- **Attribution**: Believed to be a small, tightly organized group; FireEye/Mandiant produced the primary public reporting on this actor
- **Defense implication**: Their campaigns highlight why DLP, egress filtering, and executive communication monitoring are critical — encryption-focused defenses alone would not have stopped them

## Related concepts
[[Threat Actor Attribution]] [[Spear Phishing]] [[Living off the Land (LotL)]] [[Data Loss Prevention (DLP)]] [[Extortion-Based Ransomware]]