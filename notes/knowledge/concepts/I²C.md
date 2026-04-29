# I²C

## What it is
Think of I²C like a school intercom system where the principal (master) calls specific classrooms (slaves) by room number to request or deliver information — all over just two shared wires. Precisely: Inter-Integrated Circuit (I²C) is a synchronous, multi-master serial communication protocol using two lines — SDA (data) and SCL (clock) — that allows a single master to address up to 127 devices on the same bus using 7-bit addresses.

## Why it matters
In hardware hacking and IoT security, I²C buses are a goldmine for physical attackers. An adversary with physical access to a device (e.g., a smart meter or industrial controller) can clip onto the two exposed I²C lines, sniff unencrypted traffic with a logic analyzer, and extract firmware, credentials, or cryptographic keys stored in an EEPROM chip — all without ever triggering a software-level alert.

## Key facts
- **No authentication by default**: Any device on the bus can respond to an address; there is no built-in mechanism to verify a device's identity.
- **Speed modes**: Standard (100 kHz), Fast (400 kHz), Fast-Plus (1 MHz), and High-Speed (3.4 MHz) — faster modes reduce the window for passive eavesdropping but don't eliminate it.
- **Address collisions**: The 7-bit address space (128 addresses, 16 reserved) creates predictable addressing that attackers can enumerate by scanning 0x00–0x7F.
- **Common targets**: EEPROM (credential storage), sensors, display controllers, and Trusted Platform Module (TPM) chips frequently communicate over I²C in embedded systems.
- **Physical attack vector**: Classified under hardware/physical attack techniques in security frameworks; mitigated through epoxy potting, metal shielding, and bus encryption layers like firmware-enforced AES wrapping.

## Related concepts
[[Hardware Hacking]] [[JTAG]] [[Side-Channel Attacks]] [[IoT Security]] [[Physical Security Controls]]