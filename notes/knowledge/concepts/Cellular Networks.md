# Cellular Networks

## What it is
Like a city divided into postal districts where each district has one sorting office handling all mail — cellular networks divide geographic areas into "cells," each served by a base station that hands off your connection as you move between zones. Precisely: cellular networks are wireless communication infrastructures that use radio frequency bands (licensed spectrum) to connect mobile devices to carrier networks and ultimately the public internet, operating across generations (2G/3G/4G LTE/5G) with distinct security architectures per generation.

## Why it matters
In 2021, researchers demonstrated that commercially available IMSI catchers ("Stingrays") — fake base stations — could silently intercept 4G LTE communications by forcing devices to downgrade to vulnerable 2G protocols, enabling real-time call interception and location tracking. Law enforcement and adversaries alike exploit this attack vector, making cellular network awareness critical for defenders protecting high-value targets like journalists or executives.

## Key facts
- **IMSI (International Mobile Subscriber Identity)** uniquely identifies a SIM card and is the primary target of rogue base station attacks
- **2G (GSM)** uses one-way authentication only (network doesn't prove identity to device), making it the weakest link exploited in downgrade attacks
- **SS7 (Signaling System 7)** — the protocol backbone routing calls/texts between carriers — has well-documented vulnerabilities allowing call interception and geolocation without physical proximity
- **5G** introduces mutual authentication and encrypts the IMSI (replacing it with a SUPI/SUCI scheme), directly addressing legacy weaknesses
- Cellular traffic can traverse corporate networks via mobile device hotspots, creating **shadow IT bypass paths** around enterprise firewalls and DLP controls

## Related concepts
[[IMSI Catcher]] [[SS7 Vulnerabilities]] [[Downgrade Attacks]] [[Rogue Access Points]] [[5G Security]]