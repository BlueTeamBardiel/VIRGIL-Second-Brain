# Discovery

## What it is
Like a burglar casing a house before breaking in — checking which windows are unlocked, whether a dog barks, and what's worth stealing — Discovery is the phase where an attacker maps the target environment after gaining initial access. Precisely, it refers to the tactics used to gather information about the internal network, systems, users, and data stores to inform further exploitation or lateral movement.

## Why it matters
After compromising a single workstation via phishing, an attacker runs `net user /domain` and `ipconfig /all` to enumerate Active Directory accounts and network topology. This reconnaissance lets them identify a domain controller to target next — turning a low-privilege foothold into full domain compromise. Defenders monitoring for these native Windows commands in unusual contexts (LOLBAS abuse) can detect the intrusion at this stage before significant damage occurs.

## Key facts
- Discovery maps to **MITRE ATT&CK Tactic TA0007**, encompassing techniques like System Information Discovery (T1082), Network Share Discovery (T1135), and Account Discovery (T1087)
- Attackers heavily abuse **Living Off the Land Binaries (LOLBins)** — legitimate tools like `net`, `whoami`, `nltest`, and `arp` — to blend in with normal activity and evade detection
- **Active Directory enumeration** (e.g., BloodHound/SharpHound) is one of the most impactful discovery techniques, visually mapping attack paths to privileged accounts
- Detection relies on **behavioral baselines** — the same commands run by an IT admin are benign, but run by a marketing laptop at 2 AM signal compromise
- Discovery typically follows **Initial Access and Execution** in the ATT&CK kill chain, and precedes **Lateral Movement**

## Related concepts
[[Lateral Movement]] [[Enumeration]] [[MITRE ATT&CK Framework]] [[Living Off the Land]] [[Reconnaissance]]