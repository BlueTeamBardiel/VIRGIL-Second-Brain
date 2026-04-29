# macro

## What it is
Like a programmable shortcut on a factory floor that triggers an entire assembly sequence with one button press, a macro is a stored sequence of commands or code that executes automatically when triggered — most commonly embedded inside documents like Word or Excel files. Macros use scripting languages (historically VBA — Visual Basic for Applications) to automate repetitive tasks within host applications.

## Why it matters
Macro-based malware became one of the most effective initial access techniques in history. In campaigns like Emotet and Dridex, attackers sent phishing emails with Office documents containing malicious macros; when victims clicked "Enable Content," the macro executed PowerShell commands that downloaded and ran malware, bypassing many traditional defenses. Microsoft's 2022 decision to block macros from internet-downloaded Office files by default was a direct response to this persistent threat vector.

## Key facts
- Malicious macros typically abuse the **AutoOpen** or **Document_Open** event handlers to execute immediately upon file opening without additional user interaction beyond enabling macros
- The **Mark of the Web (MotW)** metadata tag is what Office uses to identify internet-sourced files and trigger macro blocking; attackers countered this by distributing files inside password-protected ZIPs or ISO images
- VBA macros can spawn child processes (cmd.exe, PowerShell) — defenders monitor for Office applications creating unusual child processes as a key detection rule
- Microsoft Defender Attack Surface Reduction (ASR) rules can block Office applications from creating child processes, a direct macro-abuse countermeasure relevant to CySA+
- Macro security settings are configurable via Group Policy, making organizational policy enforcement a primary administrative control

## Related concepts
[[phishing]] [[VBA stomping]] [[living off the land]] [[PowerShell abuse]] [[attack surface reduction]]