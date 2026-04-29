# LLMNR Poisoning

## What it is
Imagine shouting your friend's name in a crowded room — and a stranger answers pretending to be them. Link-Local Multicast Name Resolution (LLMNR) is a Windows fallback protocol that broadcasts name queries to the entire local subnet when DNS fails; an attacker on the same network can respond to those broadcasts, impersonating the target host and capturing the victim's Net-NTLMv2 credential hash.

## Why it matters
During a penetration test on a corporate Windows network, an attacker runs Responder on a rogue laptop plugged into a conference room Ethernet jack. When any workstation mistype a file share path and DNS fails to resolve it, Responder answers the LLMNR broadcast, captures Net-NTLMv2 hashes within minutes, and cracks weak passwords offline — achieving lateral movement without touching a single domain controller.

## Key facts
- LLMNR operates on **UDP port 5355** and is enabled by default on Windows Vista and later; its older sibling, **NBT-NS**, uses UDP port 137.
- The tool most associated with this attack is **Responder** (by Laurent Gaffie), which poisons LLMNR, NBT-NS, and mDNS simultaneously.
- Captured hashes are **Net-NTLMv2** (challenge-response format) — they cannot be passed directly but can be cracked offline with Hashcat or relayed via **NTLM Relay attacks**.
- Primary defense: **disable LLMNR and NBT-NS** via Group Policy (`Computer Configuration > Administrative Templates > Network > DNS Client`).
- Secondary defenses include network segmentation, enabling **SMB signing** to block relay attacks, and deploying 802.1X port authentication to prevent rogue devices.

## Related concepts
[[NTLM Relay Attack]] [[Responder Tool]] [[NetNTLMv2 Hash Cracking]] [[NBT-NS Poisoning]] [[SMB Signing]]