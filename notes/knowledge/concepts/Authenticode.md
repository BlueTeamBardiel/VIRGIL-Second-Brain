# authenticode

## What it is
Like a wax seal on a medieval royal decree — if the seal is intact and bears the king's mark, you trust the document came from the king. Authenticode is Microsoft's code-signing technology that uses PKI digital signatures to verify the publisher identity and integrity of executable files (.exe, .dll, .cab, .ps1). When Windows encounters a signed binary, it checks the signature against a trusted Certificate Authority chain before execution.

## Why it matters
Attackers frequently abuse stolen or fraudulently obtained code-signing certificates to make malware appear legitimate — the 2010 Stuxnet worm famously used *stolen* Realtek and JMicron certificates to pass Authenticode validation and bypass driver signing requirements. Defenders use Authenticode validation in application whitelisting policies (via Windows Defender Application Control or AppLocker) to block unsigned or improperly signed executables from running in enterprise environments.

## Key facts
- Authenticode uses **X.509 certificates** and embeds the signature directly in the Portable Executable (PE) file's security directory
- A valid Authenticode signature proves **publisher identity** (who signed it) and **integrity** (file hasn't been modified), but does NOT guarantee the software is safe or malware-free
- **Timestamping** is critical — it proves the file was signed while the certificate was still valid, so the signature remains trusted even after certificate expiration or revocation
- Windows enforces **driver signing** (kernel-mode code requires EV certificates from Microsoft's WHQL program since Windows 10); unsigned drivers are blocked by default
- Attackers bypass Authenticode via **bring-your-own-vulnerable-driver (BYOVD)** attacks — loading legitimately signed but exploitable drivers to gain kernel access

## Related concepts
[[code signing]] [[PKI]] [[certificate authority]] [[application whitelisting]] [[Windows Defender Application Control]]