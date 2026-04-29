# Binary Planting

## What it is
Imagine a waiter who brings whatever dish is *first* found in the kitchen, not necessarily the one the chef intended — an attacker exploits this by slipping a counterfeit dish into a location checked before the real one. Binary planting is an attack where a malicious executable is placed in a location that the OS or application searches *before* the legitimate binary's actual path. When the program launches, it unknowingly executes the attacker's file instead of the intended one.

## Why it matters
In 2010, a widespread DLL planting vulnerability affected hundreds of Windows applications — when a user opened a file from a network share or USB drive, the app would load a malicious DLL placed alongside the document rather than the trusted system DLL. Attackers could achieve code execution simply by tricking a user into opening a `.doc` or `.avi` file from an attacker-controlled directory.

## Key facts
- **DLL Search Order Hijacking** is the most common form: Windows searches the application's current directory *before* `System32`, making local directories a prime planting spot
- The attack requires write access to a directory that appears early in the search path — often `%TEMP%`, network shares, or the application's own folder
- **Phantom DLL Hijacking** targets DLLs that an application tries to load but that don't exist on the system at all
- Mitigation includes using **absolute paths** in application code, enabling **Safe DLL Search Mode** (moving CWD lower in Windows search order), and applying the principle of least privilege to directory permissions
- CVE classification often falls under **Privilege Escalation** or **Persistence** — commonly tested in CySA+ scenarios involving post-exploitation techniques

## Related concepts
[[DLL Hijacking]] [[PATH Hijacking]] [[Privilege Escalation]] [[Living off the Land]] [[Code Execution]]