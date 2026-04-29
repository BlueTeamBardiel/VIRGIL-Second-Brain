# WLC

## What it is
Think of a WLC like an air traffic control tower — individual access points (the planes) don't make their own routing decisions; they all report to and receive instructions from the central tower. A Wireless LAN Controller (WLC) is a centralized network device that manages, configures, and monitors multiple wireless access points (APs) from a single administrative interface, replacing the need to configure each AP individually.

## Why it matters
In 2022, attackers exploited misconfigured WLCs by targeting the Cisco WLC authentication bypass vulnerability (CVE-2022-20695), allowing unauthenticated remote access to the management interface. This gave attackers the ability to reconfigure every AP on the network simultaneously — one compromised controller meant compromising the entire wireless infrastructure, illustrating why WLC security hardening is critical.

## Key facts
- WLCs use the **CAPWAP protocol (UDP 5246/5247)** to communicate with and tunnel traffic from lightweight APs — APs cannot function independently without the controller
- A rogue AP attack becomes significantly harder to sustain when a WLC performs **automatic rogue detection**, comparing neighboring APs against an authorized list
- WLCs enforce **centralized WLAN security policies** including 802.1X authentication, WPA3 standards, and client isolation across all managed APs simultaneously
- Split MAC architecture: the WLC handles **real-time MAC functions** (authentication, association) while APs handle only the physical RF transmission
- Compromise of a WLC provides lateral movement opportunity across the entire wireless segment — it is a **high-value target** requiring strong RBAC, MFA on the management plane, and network segmentation

## Related concepts
[[CAPWAP]] [[Rogue Access Point]] [[802.1X Authentication]] [[Wireless Security Protocols]] [[Network Segmentation]]