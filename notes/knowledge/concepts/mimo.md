# mimo

## What it is
Like a concert hall with multiple microphones and speakers working together to eliminate echo and boost signal clarity, MIMO (Multiple-Input Multiple-Output) is a wireless communication technology that uses multiple antennas at both the transmitter and receiver simultaneously to increase throughput and signal reliability without requiring additional bandwidth.

## Why it matters
MIMO is the backbone of modern Wi-Fi (802.11n/ac/ax) and 5G networks, which means attackers targeting enterprise wireless infrastructure must account for it. Because MIMO increases signal strength and range, rogue access points using MIMO antennas can extend their reach deeper into a building, making evil twin attacks harder to detect and localize through standard signal-strength triangulation methods.

## Key facts
- MIMO is standardized in **802.11n** (Wi-Fi 4) and later; 802.11ac (Wi-Fi 5) introduced MU-MIMO (Multi-User MIMO), allowing simultaneous transmission to multiple clients
- Expressed as **TxR** notation (e.g., 2x2, 4x4), where T = transmit antennas and R = receive antennas
- **Spatial multiplexing** is the core technique — independent data streams are sent over the same frequency channel using different antenna paths (spatial streams)
- MU-MIMO enables an access point to serve **multiple clients simultaneously**, increasing attack surface for jamming and deauthentication attacks against multiple sessions at once
- **Beamforming**, often paired with MIMO, directs signal toward specific clients — this can make passive wireless sniffing more difficult but doesn't replace encryption

## Related concepts
[[802.11 Wireless Standards]] [[Evil Twin Attack]] [[Wireless Site Survey]] [[Deauthentication Attack]] [[WPA3]]