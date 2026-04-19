# Ryuk Ransomware

Ryuk is a [[ransomware]] designed to target enterprise environments, active since at least 2018. It shares code similarities with [[Hermes ransomware]] and uses symmetric (AES) and asymmetric (RSA) encryption to encrypt files with .RYK extension, leaving RyukReadMe.txt ransom notes.

## Overview
- **MITRE ID:** S0446
- **Type:** Malware
- **Platform:** Windows
- **Last Updated:** 22 April 2025

## Techniques Used

### Persistence
- [[Boot or Logon Autostart Execution]] (T1547.001): Creates Registry entries under HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run via cmd.exe

### Privilege Escalation
- [[Access Token Manipulation]] (T1134): Adjusts token privileges to obtain SeDebugPrivilege

### Discovery
- [[File and Directory Discovery]] (T1083): Enumerates files and folders on all mounted drives
- [[Local Storage Discovery]] (T1680): Uses GetLogicalDrives and GetDriveTypeW to enumerate mounted drives

### Defense Evasion
- [[Impair Defenses]] (T1562.001): Stops antivirus-related services
- [[Masquerading]] (T1036.005): Creates .dll files containing Rich Text File format documents; constructs legitimate-appearing paths using GetWindowsDirectoryW with null byte injection

### Impact
- [[Data Encrypted for Impact]] (T1486): Encrypts files with AES per-file keys and RSA asymmetric encryption
- [[Inhibit System Recovery]] (T1490): Deletes volume shadow copies using vssadmin commands
- [[File and Directory Permissions Modification]] (T1222.001): Uses icacls /grant Everyone:F /T /C /Q to remove access restrictions

### Execution
- [[Command and Scripting Interpreter]] (T1059.003): Uses cmd.exe
- [[Native API]]: Leverages ShellExecuteW, GetWindowsDirectoryW, VirtualAlloc, WriteProcessMemory

## Tags
#ransomware #enterprise #windows #encryption #malware #mitre-att&ck

---
_Ingested: [[2026-04-15]] 22:04 | Source: https://attack.mitre.org/software/S0446/_
