# Stuxnet

## What it is
Imagine a surgeon's scalpel that could sneak past hospital security, ride an elevator to a specific operating room, and sabotage one particular model of surgical robot — while displaying normal readings on every monitor. Stuxnet was a precision cyberweapon: a sophisticated worm discovered in 2010, jointly attributed to the US and Israel, designed specifically to destroy uranium-enriching centrifuges at Iran's Natanz nuclear facility by manipulating Siemens S7-315 PLCs while spoofing normal sensor readings to operators.

## Why it matters
Stuxnet physically destroyed roughly 1,000 centrifuges by commanding them to spin at destructive speeds while hiding the anomaly from SCADA dashboards — the first confirmed instance of malware causing real-world physical destruction. This event permanently redefined the threat model for Industrial Control Systems (ICS) and critical infrastructure, proving that air-gapped networks are not immune to targeted nation-state attacks when removable media (USB drives) are part of the attack chain.

## Key facts
- Exploited **four simultaneous zero-day vulnerabilities** in Windows — an unprecedented level of sophistication at the time
- Spread initially via **infected USB drives**, bypassing the air-gap at Natanz; used a **LNK file vulnerability (CVE-2010-2568)** for execution
- Used **stolen, legitimate digital certificates** from Realtek and JMicron to sign its drivers, evading signature-based detection
- Targeted **Siemens Step 7 software** and only activated its payload on systems running specific PLC configurations — highly targeted, not indiscriminate
- Classified as an **Advanced Persistent Threat (APT)** and widely regarded as the first known instance of a **cyber-physical weapon**

## Related concepts
[[Industrial Control Systems (ICS)]] [[Zero-Day Exploit]] [[Advanced Persistent Threat (APT)]] [[Air Gap Attack]] [[SCADA Security]]