# NBT-NS Poisoning

## What it is
Imagine shouting your friend's name in a crowded room when you can't find them — and a stranger answers, pretending to be that friend. NetBIOS Name Service (NBT-NS) poisoning works exactly this way: when a Windows host broadcasts a name resolution request that DNS can't answer, an attacker responds with a forged reply claiming to be the requested host, redirecting the victim's traffic to the attacker's machine.

## Why it matters
In a corporate Windows environment, a penetration tester running **Responder** can silently capture NTLMv2 credential hashes within minutes of connecting to the network — no exploit required, just listening and lying. These hashes can then be cracked offline with Hashcat or relayed directly to authenticate against other internal systems, often achieving lateral movement without ever cracking a single password.

## Key facts
- NBT-NS operates on **UDP port 137** and is a legacy fallback when DNS resolution fails
- **Responder** is the primary tool used to automate NBT-NS (and LLMNR) poisoning attacks
- The attack yields **NTLMv2 challenge-response hashes**, not plaintext passwords — but these are crackable or relayable
- The primary defense is **disabling NBT-NS** via Group Policy (Network Adapter settings → disable NetBIOS over TCP/IP) and disabling LLMNR via GPO
- **SMB Signing** enforcement prevents hash relay attacks even if poisoning succeeds, making it a critical compensating control
- This attack is **passive and low-noise** — no packets are sent until the victim broadcasts, making it hard to detect without dedicated network monitoring

## Related concepts
[[LLMNR Poisoning]] [[NTLM Relay Attack]] [[Responder Tool]] [[SMB Signing]] [[Credential Harvesting]]