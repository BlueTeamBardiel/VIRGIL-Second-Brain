# Adobe Reader JS CVEs

## What it is
Like a Swiss Army knife smuggled into a courthouse inside a legal document, Adobe Reader's embedded JavaScript engine allowed attackers to hide executable logic inside seemingly innocent PDFs. These are a class of vulnerabilities in Adobe Acrobat/Reader where malicious JavaScript embedded in PDF files exploits flaws in the JavaScript interpreter to achieve code execution, heap spraying, or sandbox escapes.

## Why it matters
In Operation Aurora-era attacks and countless spear-phishing campaigns, threat actors emailed weaponized PDFs to corporate targets — opening the file triggered JS execution that exploited heap overflow vulnerabilities (e.g., CVE-2010-0188), dropping Remote Access Trojans silently. Defenders responded by deploying PDF sandboxing and disabling JavaScript execution in Reader's security settings, which remains a hardening baseline today.

## Key facts
- **CVE-2008-2992** was an early high-profile case: a `util.printf()` JavaScript function stack overflow allowing arbitrary code execution in Adobe Reader 8.x and earlier
- **Heap spraying** via JavaScript was a dominant technique — attackers used JS loops to fill memory with NOP sleds and shellcode before triggering a predictable crash
- Adobe introduced a **Protected Mode sandbox** (ASLR + DEP integration) in Reader X (2010) specifically to contain JavaScript exploit payloads
- Disabling JavaScript in Adobe Reader (Preferences → JavaScript → uncheck "Enable Acrobat JavaScript") eliminates the entire attack surface class
- These CVEs are frequently categorized as **CWE-119 (Buffer Overflow)** or **CWE-416 (Use-After-Free)** and carry CVSS scores commonly ranging 9.0–9.3

## Related concepts
[[Heap Spraying]] [[PDF Malware Analysis]] [[Sandbox Escape]] [[Spear Phishing]] [[ASLR Bypass]]