# UART

## What it is
Think of UART like two people passing notes back and forth in class — one writes and passes, the other reads and responds, using a shared timing agreement so neither talks over the other. Universal Asynchronous Receiver-Transmitter (UART) is a hardware communication protocol that transmits data serially, one bit at a time, between two devices without requiring a shared clock signal. It uses TX (transmit) and RX (receive) lines, synchronizing via a pre-agreed baud rate.

## Why it matters
Hardware hackers routinely target exposed UART headers on embedded devices — routers, IoT sensors, industrial controllers — to drop into a root shell during boot. By attaching a cheap logic analyzer or USB-to-UART adapter to unpopulated PCB pads, an attacker can intercept boot logs, inject commands, and bypass authentication entirely without ever touching the network stack.

## Key facts
- UART communicates via three wires: TX, RX, and GND (ground); no clock line needed — synchronization relies on both sides agreeing on baud rate (common: 9600, 115200 bps)
- A UART packet structure includes a start bit, 5–9 data bits, an optional parity bit, and 1–2 stop bits
- Exposed UART ports on production hardware are a physical security control failure — CIS and NIST guidelines recommend disabling or epoxy-sealing debug interfaces before deployment
- UART is commonly used to access bootloaders (U-Boot) and serial consoles on embedded Linux devices, often exposing a root shell with no authentication
- Unlike SPI or I²C, UART is point-to-point only — it cannot natively support multiple devices on a single bus

## Related concepts
[[Hardware Hacking]] [[JTAG]] [[Firmware Analysis]] [[IoT Security]] [[Physical Security Controls]]