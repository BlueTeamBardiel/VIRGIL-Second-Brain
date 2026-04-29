# Zigbee

## What it is
Think of Zigbee like a neighborhood walkie-talkie network where devices whisper short messages to each other across short distances, passing information hop-by-hop until it reaches its destination. Precisely, Zigbee is a low-power, low-data-rate wireless mesh networking protocol built on IEEE 802.15.4, operating primarily in the 2.4 GHz band and designed for IoT devices like smart bulbs, sensors, and home automation controllers. It sacrifices bandwidth for battery efficiency, making it ideal for devices that need to run for years on a single cell.

## Why it matters
In 2015, researchers demonstrated the "Zigbee worm" attack against Philips Hue smart bulbs, where a single compromised bulb could spread malicious firmware to neighboring bulbs within radio range — no internet connection required. This exploit leveraged weak over-the-air (OTA) update authentication, turning a physical proximity into a propagating network attack. It's a concrete example of how mesh topology amplifies a single point of compromise into a neighborhood-wide breach.

## Key facts
- Operates on **IEEE 802.15.4** standard; uses 2.4 GHz globally (also 868/915 MHz regionally)
- Default encryption uses **AES-128**, but many devices ship with a hardcoded "ZigBee Alliance 09" trust center link key — a known vulnerability
- Network range is typically **10–100 meters** per hop; mesh topology extends coverage significantly
- Supports up to **65,000 nodes** per network using 16-bit addressing
- Common attack vectors include **key sniffing during device pairing**, replay attacks, and insecure OTA firmware updates

## Related concepts
[[IEEE 802.15.4]] [[Z-Wave]] [[IoT Security]] [[Wireless Mesh Networks]] [[AES Encryption]]