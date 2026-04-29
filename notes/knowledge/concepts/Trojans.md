# Trojans

## What it is
Like the wooden horse gifted to Troy — a welcome-looking present with soldiers hidden inside — a Trojan is malware that disguises itself as legitimate, desirable software to trick users into executing it. Unlike viruses or worms, Trojans do not self-replicate; they rely entirely on social engineering to get the user to run them.

## Why it matters
In 2011, RSA Security was breached after an employee opened an Excel attachment titled "2011 Recruitment Plan.xls," which contained a Trojan that installed a backdoor and ultimately compromised SecurID token data affecting defense contractors. This illustrates how Trojans bypass perimeter defenses entirely by exploiting human trust rather than technical vulnerabilities.

## Key facts
- **Trojans require user execution** — they have no self-propagation mechanism, distinguishing them from worms (which spread automatically) and viruses (which attach to files)
- **Common types include**: Remote Access Trojans (RATs), banking Trojans (credential stealers), downloader Trojans, and rootkit droppers
- **RATs specifically** establish persistent backdoor access, often enabling keylogging, webcam access, and command-and-control (C2) communication
- **Delivery vectors** include phishing emails, drive-by downloads, pirated software, and malicious browser extensions
- **Detection evasion**: Trojans frequently use code signing with stolen certificates, DLL hijacking, or process injection to appear legitimate to antivirus tools

## Related concepts
[[Social Engineering]] [[Remote Access Trojan (RAT)]] [[Command and Control (C2)]] [[Malware]] [[Rootkits]]