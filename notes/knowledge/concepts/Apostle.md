# Apostle

## What it is
Like a master key that opens the front door while silently cloning itself for future use, Apostle is a wiper malware that disguises itself as ransomware during initial deployment before revealing its true destructive payload. It is a sophisticated wiper/ransomware hybrid first attributed to the Iranian threat actor group Agrius, designed to permanently destroy data on target systems while presenting the appearance of a financially motivated ransomware attack.

## Why it matters
In 2021, Agrius deployed Apostle against Israeli and UAE targets in what initially appeared to be ransomware campaigns — defenders wasted critical response time attempting decryption and negotiation rather than focusing on containment and recovery. This deception tactic buys adversaries additional dwell time and misdirects incident response efforts, illustrating why attribution of motive matters as much as technical indicators during an active incident.

## Key facts
- Apostle evolved from an earlier Agrius wiper called **IPsec Helper**; early versions had broken encryption making ransomware functionality non-operational — the wiper was always the real goal
- Classified under **MITRE ATT&CK T1485 (Data Destruction)** and **T1486 (Data Encrypted for Impact)** simultaneously
- Written in **.NET**, making it relatively portable and easier to modify across campaigns
- Agrius used **VPN infrastructure and compromised servers** as operational relay boxes to obscure origin during deployment
- Demonstrates the **ransomware-as-cover** tactic: financial framing creates plausible deniability for nation-state destructive operations

## Related concepts
[[Wiper Malware]] [[Ransomware]] [[Agrius APT]] [[MITRE ATT&CK]] [[Attribution]]