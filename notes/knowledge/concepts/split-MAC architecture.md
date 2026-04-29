# split-MAC architecture

## What it is
Think of it like a restaurant where the waiter takes your order (lightweight access point) but all the cooking decisions happen back in the kitchen (wireless LAN controller). Split-MAC architecture divides 802.11 wireless functions between a lightweight access point (LAP) and a centralized Wireless LAN Controller (WLC), where time-sensitive functions like beaconing and acknowledgments stay at the AP, while management tasks like authentication, roaming, and security policy enforcement are handled by the WLC. The two communicate via the CAPWAP (Control and Provisioning of Wireless Access Points) tunneling protocol.

## Why it matters
When an attacker attempts an evil twin or rogue AP attack, split-MAC makes detection and response far more effective — the WLC has visibility across all APs simultaneously and can compare beacon characteristics, detect duplicate SSIDs, and push containment policies instantly. A standalone "fat" AP architecture would require manual auditing of each device individually, giving attackers far more dwell time.

## Key facts
- **CAPWAP** runs over UDP port **5246** (control) and **5247** (data) and encapsulates all traffic between the LAP and WLC
- The LAP handles **real-time MAC functions**: beaconing, probe responses, packet acknowledgment, and encryption/decryption
- The WLC handles **upper MAC functions**: association, roaming decisions, 802.1X/EAP authentication, and RF management
- LAPs are **zero-touch deployable** — they download their configuration from the WLC on boot, reducing local misconfiguration risk
- Centralized architecture enables **consistent policy enforcement** across all APs, critical for PCI-DSS wireless compliance requirements

## Related concepts
[[CAPWAP]] [[rogue access point detection]] [[802.1X authentication]] [[wireless LAN controller]] [[evil twin attack]]