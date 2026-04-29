# SAM

## What it is
Think of it as a locked filing cabinet containing every employee's key to the building — except it never leaves the premises, even when Windows shuts down. The Security Account Manager (SAM) is a Windows database file (`C:\Windows\System32\config\SAM`) that stores hashed credentials for local user accounts. It is encrypted with a key derived from the SYSKEY and remains locked by the OS during normal operation to prevent direct access.

## Why it matters
During a penetration test or real attack, an adversary with physical or SYSTEM-level access can dump the SAM database using tools like `mimikatz` or `impacket secretsdump` to extract NTLM password hashes. Those hashes can then be cracked offline or used directly in a **Pass-the-Hash** attack to authenticate to other systems without ever knowing the plaintext password — turning one compromised local account into lateral movement across a network.

## Key facts
- The SAM file is locked by the Windows kernel at runtime; attackers typically steal it by reading `HKLM\SAM` via registry or by copying from `C:\Windows\Repair` or Volume Shadow Copies (VSS)
- Credentials are stored as **NTLM hashes** (MD4 of the Unicode password); LM hashes are disabled by default on modern Windows but may still exist on legacy systems
- The SAM database is encrypted using the **Boot Key (SYSKEY)**, stored across four registry keys in `HKLM\SYSTEM`
- Domain controllers do **not** use SAM for domain accounts — those are stored in **NTDS.dit** instead; SAM only covers local accounts
- Enabling **Windows Credential Guard** (virtualization-based security) significantly limits the ability to extract hashes from memory and the SAM

## Related concepts
[[NTLM Authentication]] [[Pass-the-Hash]] [[NTDS.dit]] [[Credential Dumping]] [[Mimikatz]]