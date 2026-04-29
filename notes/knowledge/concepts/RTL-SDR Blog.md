# RTL-SDR Blog

## What it is
Think of it as the Popular Mechanics magazine for people who want to eavesdrop on the electromagnetic spectrum using a $25 USB TV dongle. RTL-SDR Blog is a community resource and hardware vendor that documents how repurposed DVB-T television receiver chips (RTL2832U) can be used as wideband software-defined radio receivers. It serves as the primary reference hub for tutorials, hardware reviews, and practical RF hacking projects using low-cost SDR equipment.

## Why it matters
A penetration tester or threat actor can use RTL-SDR hardware — guided by tutorials from this site — to passively capture unencrypted wireless transmissions from pagers, aircraft ADS-B transponders, vehicle key fobs, weather stations, and SCADA telemetry systems. This passive, receive-only attack leaves zero network footprint, making it invisible to traditional IDS/SIEM tools. Defenders use the same SDRs for RF spectrum monitoring to detect rogue transmitters and unauthorized wireless devices on or near sensitive facilities.

## Key facts
- RTL-SDR dongles typically cover 500 kHz to 1.75 GHz, capturing frequencies used by emergency services, aviation (ADS-B at 1090 MHz), and IoT devices
- The RTL2832U chipset was never intended for security research — its repurposing demonstrates the principle of dual-use technology
- Software like GNU Radio, SDR#, and GQRX transforms raw IQ samples from the dongle into decodable signals
- Passive RF interception is NOT covered by the Wiretap Act if signals are not encrypted and are publicly broadcast (varies by jurisdiction and signal type)
- RTL-SDR Blog sells V3/V4 hardware variants with direct-sampling mods that extend reception down to HF frequencies (below 30 MHz), enabling shortwave and amateur band monitoring

## Related concepts
[[Software-Defined Radio]] [[RF Signal Interception]] [[ADS-B Spoofing]] [[Wireless Reconnaissance]] [[OSINT]]