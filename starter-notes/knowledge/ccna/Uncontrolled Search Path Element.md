# Uncontrolled Search Path Element

## What it is
Like a waiter who fills your glass from the first unlabeled bottle he finds on any table rather than the bar, an application that blindly trusts its search path will load whichever library or executable appears first — legitimate or not. Uncontrolled Search Path Element (CWE-427) occurs when a program resolves file locations using directories that an attacker can write to, allowing malicious files to be loaded in place of trusted ones.

## Why it matters
In a classic **DLL Search Order Hijacking** attack on Windows, an attacker drops a malicious `version.dll` into an application's working directory. When the app launches, Windows searches the current directory *before* `System32`, finds the attacker's DLL first, and executes it — granting persistence or privilege escalation without exploiting a single line of the app's code.

## Key facts
- **CWE-427** is the formal identifier; it maps to **MITRE ATT&CK T1574.001** (DLL Search Order Hijacking) and **T1574.007** (Path Interception by PATH Environment Variable).
- On Windows, the default DLL search order checks: application directory → `System32` → `System` → `Windows` → `PATH` directories.
- **Relative paths** in `PATH` (e.g., an empty string or `.`) are a red flag — they cause the OS to search the current working directory.
- Defenses include using **absolute paths** in code, enabling **Safe DLL Search Mode** (moving CWD lower in the search order), and applying **least-privilege write permissions** on directories in PATH.
- This vulnerability is commonly exploited for **privilege escalation** when a high-privilege service loads DLLs from a user-writable directory.

## Related concepts
[[DLL Hijacking]] [[Privilege Escalation]] [[Path Traversal]] [[Living Off the Land]] [[Least Privilege]]
