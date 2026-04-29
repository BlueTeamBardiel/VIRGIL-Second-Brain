# Macros

## What it is
Think of a macro like a vending machine button that triggers a whole sequence of actions with a single press — instead of manually inserting coins, selecting a drink, and collecting it, one button does everything. In cybersecurity, a macro is a stored sequence of commands or code embedded in documents (like Word or Excel files) that automatically executes when triggered. Macros use languages like VBA (Visual Basic for Applications) to automate repetitive tasks, but this same automation power makes them a prime attack vector.

## Why it matters
Macro-based malware was the delivery mechanism behind the Emotet banking trojan campaigns, where attackers sent phishing emails with weaponized Word documents. When victims enabled macros after seeing a fake "content blocked" prompt, the VBA code silently downloaded and executed the trojan, compromising thousands of enterprise networks. Defenders counter this by enforcing Group Policy to disable macros organization-wide or restricting execution to digitally signed macros only.

## Key facts
- Microsoft Office macros use **VBA (Visual Basic for Applications)** as their scripting language; attackers abuse this to run shell commands, download payloads, or establish persistence
- The classic social engineering trick is a fake "Enable Content" prompt — users are tricked into manually enabling macros that are disabled by default
- **Macro viruses** were among the first widespread malware types in the 1990s (e.g., Melissa virus, 1999)
- Microsoft's 2022 decision to **block macros by default** for files downloaded from the internet (Mark of the Web) significantly reduced this attack surface
- Attackers pivoted to **XLM (Excel 4.0) macros** as an evasion technique because legacy macro formats bypass some modern detection tools

## Related concepts
[[Phishing]] [[VBA Scripting]] [[Social Engineering]] [[Malicious Documents]] [[Execution (MITRE ATT&CK)]]