# VBA Macro

## What it is
Like a loaded mousetrap hidden inside a gift box, a VBA Macro is a pre-written automation script embedded inside Office documents that executes the moment someone opens the file and clicks "Enable Content." Specifically, VBA (Visual Basic for Applications) is Microsoft's scripting language built into Office applications like Word and Excel, allowing code to run with the same privileges as the logged-in user.

## Why it matters
Phishing campaigns routinely weaponize VBA macros by embedding malicious code inside invoice or shipping notification documents. When a victim opens the file and enables macros, the script silently downloads a payload — such as Emotet or a Cobalt Strike beacon — establishing a foothold inside the corporate network without exploiting any software vulnerability.

## Key facts
- Macros are **disabled by default** in modern Office versions (post-2016), requiring user interaction to execute — the "Enable Content" prompt is the critical social engineering moment
- Malicious macros commonly use `Shell()`, `WScript.Shell`, or PowerShell invocation to download and execute secondary payloads (a technique called a **dropper**)
- Microsoft blocked macros from **internet-sourced Office files by default** in 2022, marking files with the **Mark of the Web (MotW)** via NTFS Alternate Data Streams
- Attackers bypass MotW protections by delivering documents inside **ISO, ZIP, or IMG files**, which historically didn't propagate the MotW flag
- Detection signatures include monitoring for **Office spawning child processes** (e.g., `winword.exe` → `powershell.exe`), a reliable behavioral indicator of macro abuse

## Related concepts
[[Phishing]] [[Dropper Malware]] [[PowerShell Abuse]] [[Mark of the Web]] [[Macro Security Policy]]