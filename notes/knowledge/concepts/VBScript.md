# VBScript

## What it is
Like a dusty master key that still opens half the doors in an old building, VBScript is a legacy Microsoft scripting language that persists in environments long after it should have been retired. Precisely: VBScript (Visual Basic Scripting Edition) is a client-side and server-side scripting language built into Windows and Internet Explorer, derived from Visual Basic, that can directly interact with the Windows Script Host (WSH) and COM objects.

## Why it matters
VBScript is a classic malware delivery mechanism — attackers embed malicious `.vbs` files in phishing emails that, when double-clicked, silently execute payloads like ransomware droppers or RATs using WSH with no compilation required. The 2000 ILOVEYOU worm was a VBScript file that overwrote files and emailed itself to every Outlook contact, infecting over 50 million machines — demonstrating how a 10KB script can cause billions in damage.

## Key facts
- VBScript runs natively on Windows via **wscript.exe** (GUI) or **cscript.exe** (command-line), both built into Windows Script Host — no additional software needed
- Microsoft **disabled VBScript by default in Internet Explorer** starting with IE 11 security zones and fully deprecated it in Windows after 2019, but it remains present on many enterprise systems
- Attackers use VBScript in **macro-enabled Office documents** (`.doc`, `.xls`) to download and execute secondary payloads — a technique classified as T1059.005 in MITRE ATT&CK
- `.vbs` files can be **obfuscated** using `Chr()` character encoding or `Execute()` calls to evade signature-based AV detection
- Defenders should enforce **Software Restriction Policies (SRP)** or AppLocker rules to block wscript.exe and cscript.exe from running user-downloaded scripts

## Related concepts
[[Windows Script Host]] [[Living Off the Land Binaries (LOLBins)]] [[Macro Malware]] [[MITRE ATT&CK T1059]] [[AppLocker]]