# TKIP

## What it is
Imagine duct-taping a deadbolt onto a screen door — it's a real improvement, but you're still working around a fundamentally flawed frame. TKIP (Temporal Key Integrity Protocol) was a stopgap encryption upgrade for WEP, designed to fix WEP's catastrophic key reuse problem without requiring new hardware. It mixed per-packet keys, added a message integrity check (MIC called "Michael"), and used a sequence counter to prevent replay attacks — all running on the same RC4 cipher as WEP.

## Why it matters
In the early 2000s, enterprises couldn't throw out millions of dollars of WEP-only hardware overnight, so TKIP let them push firmware updates and gain meaningful security improvements. However, the "Beck-Tews attack" (2008) demonstrated that an attacker on a TKIP network could decrypt short packets and inject malicious traffic within minutes by exploiting weaknesses in the Michael MIC and QoS channels — proving the duct tape eventually peels off.

## Key facts
- TKIP was introduced as part of **WPA (Wi-Fi Protected Access)** in 2003 as a transitional standard before WPA2.
- Uses **128-bit temporal keys** that change per-packet via a key mixing function, eliminating WEP's static key problem.
- The **Michael MIC** provides integrity checking but is deliberately weak (only 20,000 possible keys) to remain compatible with old hardware.
- TKIP was **deprecated by IEEE in 2012** and is considered cryptographically broken — its use fails PCI-DSS compliance requirements.
- WPA2 with **CCMP/AES** replaced TKIP as the mandatory standard; any device still advertising TKIP-only is a red flag on a network audit.

## Related concepts
[[WEP]] [[WPA2]] [[RC4]] [[CCMP]] [[Replay Attack]]