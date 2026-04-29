# DarkVishnya

## What it is
Like a spy slipping a bug under a conference table before leaving the building, DarkVishnya is an attack campaign where threat actors physically mailed or hand-delivered rogue hardware devices into target bank branches, which then acted as silent footholds inside the network. Specifically, it was a series of cyberattacks against Eastern European financial institutions (2017–2018), attributed to an unknown group, using hidden hardware implants planted inside corporate offices to bypass perimeter defenses entirely.

## Why it matters
In the DarkVishnya incidents, attackers shipped small devices — Bash Bunnies, Raspberry Pis, or netbooks — disguised as ordinary office equipment to bank locations. Once a bank employee plugged the device into an internal network port, attackers remotely accessed it via cellular modem or Bluetooth and pivoted laterally toward SWIFT terminals and ATM systems, ultimately stealing hundreds of millions of rubles. This illustrates that no firewall protects you from an attacker who physically reaches your switch.

## Key facts
- Devices used included **Raspberry Pi**, **Bash Bunny**, and cheap netbooks — all under $100, demonstrating that APT-level breaches don't require exotic tools
- The hardware implants connected back to attackers via **GPRS/cellular data**, bypassing network egress monitoring entirely
- Attack chain followed: physical implant → remote shell → internal reconnaissance → lateral movement → ATM/SWIFT compromise
- **Kaspersky Lab** publicly documented and named this campaign in 2018
- Defense requires **802.1X port-based Network Access Control (NAC)**, physical port locks, and insider threat awareness training

## Related concepts
[[Physical Security]] [[Network Access Control (NAC)]] [[Supply Chain Attack]] [[Lateral Movement]] [[Insider Threat]]