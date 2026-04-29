# Microsoft Word

## What it is
Like a Swiss Army knife that secretly contains a detonator, Microsoft Word is far more than a text editor — it's a full scripting and automation platform disguised as a document tool. Precisely, it is a word processing application that supports embedded macros (via VBA), OLE objects, and dynamic data exchange (DDE), making it a frequent vehicle for malware delivery.

## Why it matters
In countless spear-phishing campaigns — including the infamous Emotet malware distribution — attackers sent Word documents with embedded VBA macros that, once enabled by the victim, silently downloaded and executed a payload. Defenders must configure Group Policy to disable macros by default and enforce Protected View to prevent automatic execution of untrusted content.

## Key facts
- **Macro-based attacks** use VBA (Visual Basic for Applications) embedded in `.doc` or `.docm` files; `.docx` files cannot contain macros natively
- **DDE (Dynamic Data Exchange)** was exploited as a macro-less attack vector, allowing command execution through field codes — patched but historically significant
- **Protected View** opens documents from the internet in a sandboxed read-only mode; the social engineering lure is convincing users to click "Enable Editing"
- **MOTW (Mark of the Web)** is a Windows flag on downloaded files that triggers Protected View; attackers use ISO or ZIP containers to bypass it
- Malicious Word documents are categorized under **MITRE ATT&CK T1566.001** (Spearphishing Attachment) and **T1204.002** (Malicious File execution)

## Related concepts
[[Macros]] [[Phishing]] [[VBA Malware]] [[Mark of the Web]] [[OLE Objects]]