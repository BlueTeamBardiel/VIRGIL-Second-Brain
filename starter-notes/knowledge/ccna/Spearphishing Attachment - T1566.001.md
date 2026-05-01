# Spearphishing Attachment - T1566.001

## What it is
Like a poisoned gift addressed specifically to *you* by name, wrapped to look like it's from your boss — spearphishing attachments are targeted emails carrying malicious files (macros, PDFs, executables) crafted to exploit a specific individual's context, role, or relationships. Unlike bulk phishing, the lure content is researched and personalized to maximize credibility.

## Why it matters
In the 2016 DNC breach, Fancy Bear (APT28) sent targeted emails to staffers with malicious Word documents containing embedded macros that dropped credential-harvesting malware. The personalization made recipients far less suspicious than a generic phishing email would have — a defender who only filters for known-bad domains or sender reputation will miss this entirely without attachment sandboxing.

## Key facts
- **MITRE ATT&CK sub-technique** of Phishing (T1566); the attachment itself is the delivery vector, distinct from link-based (T1566.002) or service-based (T1566.003) variants
- Common malicious attachment types: `.docm`/`.xlsm` (macro-enabled Office files), `.pdf` with embedded JS, `.iso`/`.img` files (used to bypass Mark-of-the-Web protections), and `.lnk` shortcuts
- Defenders counter this with **email sandboxing/detonation**, disabling Office macros via Group Policy, and **DMARC/DKIM/SPF** enforcement to reduce sender spoofing
- On Security+/CySA+: recognize this as an **initial access** technique — the attachment rarely *is* the final payload; it typically drops a loader (e.g., Emotet, Cobalt Strike beacon)
- Detection signals include: unexpected attachments from known contacts, macro execution events in endpoint logs, and child processes spawned by Office applications (e.g., `winword.exe` → `cmd.exe`)

## Related concepts
[[Phishing - T1566]] [[Macro Malware]] [[Mark-of-the-Web Bypass]] [[Email Security Protocols (DMARC/DKIM/SPF)]] [[Sandbox Evasion]]


<!-- merged from: Spearphishing Attachment T1566.001.md -->

# Spearphishing Attachment T1566.001




<!-- merged from: Spearphishing Attachments T1566.md -->

# Spearphishing Attachments T1566




<!-- merged from: Spearphishing Attachment.md -->

# Spearphishing Attachment


