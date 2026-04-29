# PlugX

## What it is
Think of PlugX like a master key disguised as a hotel staff uniform — it gets inside legitimately, then quietly copies itself into every door lock in the building. PlugX is a modular Remote Access Trojan (RAT) historically associated with Chinese state-sponsored threat actors, designed to provide persistent, covert access to compromised systems while hiding behind legitimate processes through DLL side-loading.

## Why it matters
During the 2020 attacks on government agencies across Southeast Asia and Europe, PlugX was delivered via spear-phishing emails with malicious documents that exploited DLL side-loading — dropping a legitimate signed executable alongside a malicious DLL to evade detection. Defenders who understood this technique knew to look for signed binaries loading unexpected DLLs from writable directories, rather than chasing the malware file itself.

## Key facts
- **DLL side-loading** is PlugX's signature delivery mechanism: a trusted, signed application (often antivirus software) loads a malicious DLL placed in the same directory by the attacker
- PlugX achieves **persistence** via registry run keys, Windows services, and scheduled tasks — often using multiple redundant methods simultaneously
- It is **modular**, meaning operators can load plugins for keylogging, screen capture, remote shell, file exfiltration, and USB propagation on demand
- Associated threat groups include **APT41, Mustang Panda, and Stone Panda** — all attributed to Chinese state-sponsored operations
- PlugX can spread via **USB drives**, automatically infecting removable media to jump air-gapped or isolated networks — a technique observed in attacks against military targets

## Related concepts
[[DLL Side-Loading]] [[Remote Access Trojan]] [[APT (Advanced Persistent Threat)]] [[Persistence Mechanisms]] [[Spear Phishing]]