# Using universal remotes

## What it is
Like a master key that opens many locks because it "speaks" every lock's language, a universal remote is a device (or software tool) that can transmit control signals across multiple protocols — IR, RF, Bluetooth, or Z-Wave — to interact with systems it was never originally paired with. In security contexts, this concept extends to tools like Flipper Zero that can capture, replay, and emulate wireless signals to interact with access control systems, garage doors, and IoT devices.

## Why it matters
An attacker using a Flipper Zero outside a corporate building can capture the RF signal from an employee's key fob, then replay that signal to unlock a door — a classic **replay attack** against a physical access control system. This illustrates why static, unencrypted RF credentials (common in older HID proximity cards) are critically vulnerable to signal capture-and-replay without any network penetration required.

## Key facts
- **Replay attacks** are the primary threat: capturing a valid transmitted signal and retransmitting it to gain unauthorized access
- Older **125 kHz proximity cards** transmit credentials unencrypted and are trivially cloned; **13.56 MHz smart cards** (HID iCLASS, MIFARE) offer encryption but have known vulnerabilities
- **Rolling codes** (used in modern car key fobs) mitigate replay attacks by generating a new code each use — a one-time-password model for RF
- Flipper Zero operates legally as a research tool but is frequently cited in **physical penetration testing** engagements
- Countermeasures include **signal shielding** (Faraday pouches for key fobs), upgrading to **challenge-response authentication** systems, and deploying **RF detection sensors**

## Related concepts
[[Replay Attacks]] [[Physical Security Controls]] [[Signal Jamming]] [[RFID Cloning]] [[Side-Channel Attacks]]