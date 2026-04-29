# 1-Wire

## What it is  
Think of 1‑Wire like a single‑threaded telephone line that both hands (client and server) use to talk, and only one person speaks at a time. Precisely, 1‑Wire is a low‑speed serial communication protocol that uses a single data line plus ground to exchange signals between a master and one or more slave devices, commonly used for temperature sensors and unique ID chips.

## Why it matters  
In industrial control, attackers have leveraged 1‑Wire ID spoofing to trick a PLC into reading data from a malicious sensor, enabling false readings that can cause equipment damage. Defenders patch this by authenticating slave IDs and monitoring line noise anomalies to detect tampering.

## Key facts
- Uses a single bidirectional data line plus ground; no separate clock line.  
- Standard speeds: 16.7 kbit/s (Normal) or 142.8 kbit/s (Fast).  
- Devices are addressed by unique 64‑bit ROM codes, allowing hot‑plugging of up to 255 slaves on one bus.  
- Requires a pull‑up resistor (typically 4.7 kΩ) to keep the line high when idle.  
- Commonly used in Dallas/Maxim DS18B20 temperature sensors and iButton identification tags.

## Related concepts
[[UART]] [[SPI]] [[I²C]]