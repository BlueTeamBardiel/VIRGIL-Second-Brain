# channel selection

## What it is
Like a DJ choosing which radio frequency to broadcast on to avoid interference from competing stations, channel selection is the process by which wireless access points and clients negotiate or are assigned a specific frequency sub-band (channel) within a spectrum like 2.4 GHz or 5 GHz. Poor channel selection causes congestion and overlap; deliberate channel manipulation by an attacker can cause denial of service or force clients onto rogue networks.

## Why it matters
An attacker performing an evil twin attack will typically clone a legitimate AP's SSID and deliberately broadcast on the same channel with higher power, forcing clients to associate with the rogue AP instead. Security teams conducting wireless site surveys use channel selection analysis to identify overlapping channels, detect rogue APs, and ensure legitimate APs use non-overlapping channels (1, 6, 11 in 2.4 GHz) to minimize interference and attack surface.

## Key facts
- The 2.4 GHz band has only **3 non-overlapping channels** (1, 6, and 11) in North America, making it highly congested and easier to attack.
- The 5 GHz band offers **up to 24 non-overlapping channels**, providing greater flexibility and reduced interference.
- **Automatic channel selection (ACS)** allows APs to self-select the least congested channel, but attackers can use beacon flooding to manipulate ACS decisions.
- **Channel bonding** (combining adjacent channels for higher throughput, e.g., 40 MHz or 80 MHz wide) reduces the number of available non-overlapping channels, increasing collision risk.
- Wi-Fi analyzers (e.g., Kismet, inSSIDer) are used in wireless site surveys to visualize channel utilization and detect rogue devices operating on unusual or conflicting channels.

## Related concepts
[[evil twin attack]] [[wireless site survey]] [[rogue access point]] [[jamming]] [[802.11 standards]]