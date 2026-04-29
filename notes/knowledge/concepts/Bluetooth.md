# Bluetooth

## What it is
Like two strangers agreeing to whisper secrets by bumping shoulders in a crowd, Bluetooth is a short-range radio protocol that lets devices negotiate a private channel and exchange data without wires. Technically, it operates in the 2.4 GHz ISM band using frequency-hopping spread spectrum (FHSS) to reduce interference, with a typical range of 10–100 meters depending on device class.

## Why it matters
In 2017, the **BlueBorne** vulnerability allowed attackers to silently compromise Bluetooth-enabled devices — phones, laptops, IoT — without any pairing required, simply by being within radio range. An attacker could execute code remotely, pivot into adjacent networks, or exfiltrate data, all while the victim sat in a coffee shop unaware. This demonstrated that "short range" does not mean "safe," especially on devices that leave Bluetooth perpetually enabled.

## Key facts
- **BlueJacking** sends unsolicited messages to a device; **Bluesnarfing** steals data (contacts, calendars) without permission; **Bluebugging** grants full device control — know the distinctions for exam questions
- Bluetooth uses a **master/slave pairing model**; the pairing PIN can be brute-forced if it's short (e.g., 4 digits = only 10,000 combinations)
- **Bluetooth Classic** vs. **BLE (Bluetooth Low Energy)**: BLE uses different attack surfaces and is common in medical and IoT devices
- Devices in **discoverable mode** advertise their presence; setting to non-discoverable reduces passive reconnaissance but doesn't eliminate all attacks
- Best practice mitigation: **disable Bluetooth when not in use**, avoid pairing in public, apply firmware patches — BlueBorne required OS-level patches

## Related concepts
[[Wireless Security]] [[RFID and NFC]] [[IoT Security]] [[Frequency Hopping Spread Spectrum]] [[Man-in-the-Middle Attack]]