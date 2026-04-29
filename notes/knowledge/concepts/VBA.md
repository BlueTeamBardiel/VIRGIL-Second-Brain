# VBA

## What it is
Think of VBA like a skeleton key hidden inside a filing cabinet — it looks like an ordinary document, but it carries a fully functional scripting engine. Visual Basic for Applications (VBA) is a macro programming language embedded in Microsoft Office products (Word, Excel, Outlook) that allows automation of tasks by executing code directly within documents.

## Why it matters
Attackers weaponize VBA macros by embedding malicious code inside seemingly legitimate Office documents — a technique that powered the Emotet banking trojan and countless phishing campaigns. A victim opens an Excel spreadsheet, enables macros when prompted, and the VBA code silently downloads and executes a remote payload, establishing a foothold without any exploit required. This makes macro-based malware one of the most common initial access vectors documented in real-world breaches.

## Key facts
- VBA macros are **disabled by default** in modern Office installations; attackers use social engineering ("Enable content to view this document") to bypass this protection
- Malicious VBA commonly uses `Shell()`, `WScript.Shell`, or `PowerShell` calls to execute system commands or download second-stage payloads
- **Auto-execution triggers** like `AutoOpen`, `Document_Open`, and `Workbook_Open` run code immediately when a file is opened without additional user interaction beyond enabling macros
- Macro-enabled file extensions include `.xlsm`, `.docm`, and `.xlsb` — a flat `.xlsx` or `.docx` cannot contain executable macros
- Detection strategies include monitoring for Office processes spawning `cmd.exe`, `powershell.exe`, or `wscript.exe` (a key CySA+ indicator of compromise)

## Related concepts
[[Phishing]] [[Malicious Macros]] [[PowerShell]] [[Living off the Land (LotL)]] [[Initial Access Techniques]]