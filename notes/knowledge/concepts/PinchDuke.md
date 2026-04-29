# PinchDuke

## What it is
Like a pickpocket who steals your wallet, memorizes your credit cards, and photographs your ID before you even notice it's gone — PinchDuke is an early-stage credential harvesting malware tool. Specifically, it is a dropper/infostealer component in the Duke malware family (attributed to APT29/Cozy Bear) that collected credentials, cookies, and system information from compromised hosts, exfiltrating them to attacker-controlled infrastructure.

## Why it matters
PinchDuke was deployed in APT29's operations targeting NATO member governments and European think tanks around 2008–2010, serving as the reconnaissance and credential-theft stage before deeper implants were installed. Understanding its role illustrates the classic kill-chain pattern: harvest credentials early to enable lateral movement later, making initial detection critical before adversaries pivot.

## Key facts
- **Attribution**: Linked to APT29 (Cozy Bear), a Russian state-sponsored threat actor associated with the SVR (Foreign Intelligence Service)
- **Primary function**: Credential theft — targets saved passwords from browsers, email clients, and Windows credential stores; also captures system metadata
- **Dropper behavior**: Acts as both dropper and infostealer, meaning it can install additional malware payloads while simultaneously exfiltrating data
- **C2 communication**: Used HTTP-based command-and-control channels to blend with normal web traffic, a common APT evasion technique
- **Part of a family**: One of the earliest tools in the Duke toolset, which later evolved into MiniDuke, CozyDuke, OnionDuke, and ultimately tools used in the 2016 DNC breach

## Related concepts
[[APT29]] [[Credential Harvesting]] [[MiniDuke]] [[Dropper Malware]] [[Lateral Movement]]