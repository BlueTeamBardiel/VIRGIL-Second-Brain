# Office

## What it is
Like a Swiss Army knife that also happens to have a lockpick hidden in the blade — Microsoft Office is a productivity suite so feature-rich that its own functionality became a primary attack surface. Precisely, it is a collection of applications (Word, Excel, PowerPoint, Outlook) that support embedded macros, OLE objects, and scripting engines that threat actors routinely weaponize for code execution.

## Why it matters
In the infamous Emotet campaigns, attackers sent phishing emails containing weaponized Word documents with malicious VBA macros. When a victim clicked "Enable Content," the macro silently downloaded and executed the Emotet payload — no exploit required, just a user clicking a button Microsoft put there for legitimate use.

## Key facts
- **VBA Macros** are the most abused Office feature; organizations commonly disable them via Group Policy (`Block macros from running in Office files from the Internet`)
- **CVE-2017-11882** (Equation Editor vulnerability) allowed remote code execution without macros — a patched but historically significant Office memory corruption flaw
- **DDE (Dynamic Data Exchange)** was abused as a macro-free code execution technique; Microsoft disabled it by default in 2017
- **Protected View** is a sandboxed read-only mode that opens documents from the internet, providing a critical first layer of defense against malicious documents
- Office documents with macros use legacy extensions: `.docm`, `.xlsm`, `.pptm` — the "m" signals macro capability and should trigger extra scrutiny

## Related concepts
[[Macros]] [[Phishing]] [[DDE Injection]] [[VBA]] [[Protected View]]