# LLMNR

## What it is
Imagine shouting a name across a crowded office when the receptionist isn't answering — anyone nearby can claim to be that person. Link-Local Multicast Name Resolution (LLMNR) is a Windows protocol that resolves hostnames to IP addresses by broadcasting a query to all devices on the local network segment when DNS fails to answer.

## Why it matters
When a user mistypes a network path (e.g., `\\Fileservre\share`), Windows falls back to LLMNR and broadcasts "who is Fileservre?" An attacker running Responder on the same network can reply first, capturing the victim's NTLMv2 credential hash — which can then be cracked offline or relayed to authenticate against other systems. This attack requires zero exploitation, just listening.

## Key facts
- LLMNR operates on **UDP port 5355** and uses multicast address `224.0.0.252` (IPv4)
- It is enabled by **default** on Windows Vista and later, making it a pervasive risk in enterprise environments
- The companion protocol **NetBIOS Name Service (NBT-NS)** operates on UDP port 137 and is similarly exploitable via the same Responder toolchain
- **Mitigation:** Disable LLMNR via Group Policy (*Computer Configuration → Administrative Templates → Network → DNS Client → Turn off multicast name resolution*)
- Captured hashes are **NTLMv2** format — not cleartext passwords, but crackable with Hashcat and wordlists, or usable in **NTLM relay attacks** without cracking

## Related concepts
[[NTLM Authentication]] [[Responder Tool]] [[NetBIOS Name Service]] [[NTLM Relay Attack]] [[DNS Poisoning]]