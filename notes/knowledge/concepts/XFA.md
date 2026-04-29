# XFA

## What it is
Think of XFA as a secret engine hidden inside a PDF — like finding a full JavaScript runtime embedded inside what looks like a simple Word document. XFA (XML Forms Architecture) is a proprietary XML-based specification developed by Adobe that allows PDF files to contain dynamic, interactive forms powered by embedded JavaScript logic and XML data structures.

## Why it matters
Attackers have exploited XFA's embedded scripting capabilities to deliver malware through malicious PDF files that execute JavaScript automatically when opened in vulnerable PDF readers. In 2010–2013, multiple CVEs targeted Adobe Reader's XFA parser, allowing arbitrary code execution simply by opening a crafted PDF — a common phishing attachment vector used by APT groups to compromise enterprise endpoints.

## Key facts
- XFA embeds XML and JavaScript inside PDFs, making them capable of network calls, form submissions, and local script execution — far beyond static document behavior
- Adobe Reader and Acrobat are the primary applications that fully support XFA; most third-party readers (Foxit, Chrome's built-in viewer) partially or fully ignore XFA content
- Adobe officially deprecated XFA in PDF 2.0 (ISO 32000-2), signaling a shift toward AcroForms as the standard
- XFA-based attacks are classified under **malicious document** or **client-side exploitation** techniques — mapped to MITRE ATT&CK T1204.002 (Malicious File)
- Security controls against XFA threats include disabling JavaScript in PDF readers, sandboxing PDF viewers, and using email gateway filters that strip or detonate PDF attachments in isolated environments

## Related concepts
[[PDF Malware]] [[JavaScript Injection]] [[Client-Side Exploitation]] [[Malicious Attachments]] [[AcroForms]]