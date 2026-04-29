# Ekahau

## What it is
Think of it like a GPS system for radio waves — instead of mapping roads, it maps where Wi-Fi signals go, how strong they are, and where they bleed outside intended boundaries. Ekahau is a professional Wi-Fi planning and site survey tool used to design, analyze, and troubleshoot wireless networks by producing visual heatmaps of signal coverage, interference, and channel utilization.

## Why it matters
During a wireless security assessment, a penetration tester uses Ekahau's site survey capabilities to identify rogue access points and locate where enterprise Wi-Fi signals spill into parking lots or neighboring buildings — physical areas an attacker could exploit to capture traffic without stepping inside. Conversely, defenders use it during network design to enforce signal containment, ensuring that WPA3-protected networks don't broadcast beyond the physical perimeter they're meant to serve.

## Key facts
- Ekahau Site Survey (ESS) produces RF heatmaps showing signal strength (RSSI), signal-to-noise ratio (SNR), and channel overlap across a physical floor plan
- Supports active and passive survey modes — passive captures beacons without association; active measures real throughput by connecting to the network
- The Ekahau Sidekick is a dedicated hardware adapter that provides dual-band spectrum analysis, eliminating laptop driver inconsistencies during surveys
- Rogue AP detection is a core use case — Ekahau can flag SSIDs not matching the approved network baseline, a critical control aligned with CySA+ network monitoring objectives
- Signal containment findings from Ekahau directly inform physical security controls and are relevant to compliance frameworks requiring defined network boundaries (e.g., PCI-DSS Requirement 1)

## Related concepts
[[Rogue Access Points]] [[War Driving]] [[Wireless Site Survey]] [[RF Spectrum Analysis]] [[Evil Twin Attack]]