# Metamorfo

## What it is
Like a con artist who whispers in your ear while you stare at a fake shop window, Metamorfo is a banking trojan that overlays fake login screens on top of legitimate banking websites to steal credentials in real time. Technically, it is a Brazil-originated malware family (active since at least 2018) that uses AutoIt-compiled executables and keylogging combined with web injects to intercept banking sessions across Latin America and Europe.

## Why it matters
In documented 2019–2020 campaigns, Metamorfo spread via phishing emails containing ZIP attachments with malicious MSI installers disguised as invoice documents. Once installed, it disabled browser autofill functions (to force manual credential entry it could capture) and monitored window titles to activate its overlay attack only when a target banking site was detected — making it nearly invisible to casual users.

## Key facts
- **Origin & Targets:** Brazilian threat actor origins; initially targeted Latin American banks, later expanded to U.S., Canadian, and European financial institutions.
- **Delivery mechanism:** Phishing emails → ZIP → MSI installer → AutoIt-compiled payload, a chain designed to evade signature-based AV detection.
- **Autofill sabotage:** Actively disables browser autocomplete/autofill via registry modifications, forcing victims to type credentials that the keylogger captures.
- **Persistence:** Uses Windows Registry Run keys and scheduled tasks to survive reboots; also monitors running processes to kill analysis tools (e.g., Process Monitor).
- **Detection indicator:** Unusual AutoIt interpreter processes (`AutoIt3.exe`) running alongside browser processes is a behavioral red flag for this malware family.

## Related concepts
[[Banking Trojan]] [[Keylogger]] [[Web Inject]] [[Phishing]] [[AutoIt Malware]]