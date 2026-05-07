# IEEE 802.11ax

## What it is
Think of a busy highway where every car (device) takes turns using one lane — that's older Wi-Fi. 802.11ax (Wi-Fi 6) is like converting that highway to a smart multi-lane system where a traffic controller simultaneously directs dozens of cars through different lanes at once. Formally, it is the sixth generation IEEE wireless LAN standard operating on 2.4 GHz and 5 GHz bands, introducing OFDMA (Orthogonal Frequency Division Multiple Access) and MU-MIMO to dramatically increase throughput and efficiency in dense environments.

## Why it matters
In a stadium or corporate office deploying Wi-Fi 6, the increased device density and BSS Coloring (a mechanism to reduce interference between overlapping networks) changes the attack surface — an attacker performing a deauthentication attack must now target specific BSS Color IDs, making blanket jamming slightly harder but targeted rogue AP impersonation still trivially possible. WPA3 is strongly recommended alongside Wi-Fi 6 deployments, but many organizations enable backward compatibility with WPA2, re-introducing KRACK-vulnerable handshake exposure.

## Key facts
- **OFDMA** splits a channel into smaller sub-channels (Resource Units), allowing simultaneous transmission to multiple clients — increases efficiency in high-density environments
- **Target Wake Time (TWT)** allows devices to schedule sleep/wake cycles, reducing battery consumption — relevant in IoT security contexts
- **BSS Coloring** tags frames with a color ID to differentiate overlapping networks, reducing co-channel interference but not providing cryptographic separation
- **MU-MIMO** supports up to 8 spatial streams simultaneously (up from 4 in 802.11ac)
- **WPA3 is not mandatory** with Wi-Fi 6 — mixed WPA2/WPA3 deployments remain a common misconfiguration risk on Security+ exam scenarios

## Related concepts
[[WPA3]] [[Deauthentication Attack]] [[Rogue Access Point]] [[KRACK Attack]] [[MU-MIMO]]