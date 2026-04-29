# RF Monitoring

## What it is
Like a birdwatcher scanning the sky for wing patterns, RF monitoring means passively listening to the electromagnetic spectrum to detect, identify, and analyze wireless transmissions. It is the practice of capturing and inspecting radio frequency signals across defined frequency ranges to discover unauthorized devices, rogue access points, or anomalous wireless activity without transmitting anything yourself.

## Why it matters
In 2015, researchers demonstrated that attackers could exfiltrate data from air-gapped networks by modulating RF signals from a computer's components — a technique called AirHopper. Continuous RF monitoring would detect these unexpected emissions and alert defenders to covert side-channel communication attempts that never touch a traditional network cable or Wi-Fi access point.

## Key facts
- RF monitoring operates passively — unlike active scanning, it generates no traffic and is invisible to the target environment
- Tools like a Software Defined Radio (SDR) paired with GNU Radio can monitor frequencies from ~1 MHz to 6 GHz for under $30 in hardware
- Rogue access point detection relies on RF monitoring to catch APs broadcasting on unauthorized channels or with suspicious signal strength patterns
- Wireless Intrusion Detection Systems (WIDS) perform continuous RF monitoring and alert on deauthentication floods, evil twin attacks, and unauthorized SSIDs
- RF spectrum analyzers can fingerprint devices by their unique transmission characteristics (RF fingerprinting), even when MAC addresses are spoofed

## Related concepts
[[Wireless Intrusion Detection System (WIDS)]] [[Rogue Access Point Detection]] [[Software Defined Radio (SDR)]] [[Side-Channel Attacks]]