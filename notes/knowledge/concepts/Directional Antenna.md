# Directional Antenna

## What it is
Like a flashlight versus a bare bulb — a bare bulb sprays light everywhere, but a flashlight focuses it into a concentrated beam in one direction. A directional antenna focuses radio frequency (RF) transmission and reception into a narrow, targeted beam rather than broadcasting omnidirectionally. This dramatically extends effective range in one specific direction while reducing signal bleed in all others.

## Why it matters
In a war-driving or rogue access point attack, an attacker parked blocks away can use a high-gain directional antenna (such as a Yagi or cantenna) to reach a corporate Wi-Fi network that appears safely distant. This defeats the naive "our signal doesn't reach the parking lot" security assumption, allowing credential capture or evil twin attacks from a legally safe distance. Defenders use the same principle to create point-to-point building-to-building wireless links that minimize interception surface.

## Key facts
- **Yagi antenna** is a classic directional type with gains of 10–20 dBi, commonly associated with long-range Wi-Fi attacks and wardriving tool kits
- **Cantenna** (a DIY waveguide antenna made from a tin can) can achieve ~12 dBi gain for under $5, making directional attacks accessible to low-budget attackers
- Directional antennas are measured in **dBi** (decibels relative to isotropic); higher dBi = narrower beam, longer range
- **Half-power beamwidth** describes the angular cone where the signal remains useful — a 15° beamwidth means precision aiming is required but eavesdropping range multiplies significantly
- Security+ exam context: directional antennas are associated with **site surveys**, **RF interference**, and **rogue AP detection** scenarios

## Related concepts
[[Wardriving]] [[Evil Twin Attack]] [[Site Survey]] [[Wireless Antenna Types]] [[RF Signal Propagation]]