# pogo pin

## What it is
Like a spring-loaded ballpoint pen tip that makes contact only when pressed down, a pogo pin is a spring-loaded electrical contact probe used to create temporary, pressure-based connections to circuit board test pads. These pins enable reliable electrical contact without soldering, commonly used in manufacturing test jigs and — critically — by hardware hackers to access debug interfaces on embedded devices.

## Why it matters
Attackers use pogo pin jigs to connect to JTAG or UART debug pads on routers, IoT devices, and embedded systems that have no physical connector headers populated. By pressing a custom jig against exposed test points on a PCB, an attacker can dump firmware, access a root shell, or bypass authentication entirely — all without leaving visible signs of tampering like solder joints or drilled holes.

## Key facts
- Pogo pins are the go-to tool for accessing **JTAG**, **UART**, and **SWD** (Serial Wire Debug) interfaces on production hardware where header pins were removed to reduce attack surface
- A custom pogo pin jig can be 3D-printed and costs under $20, making this attack highly accessible
- Test pads are often still present on production PCBs even when through-hole headers are omitted — manufacturers rarely grind them off
- This technique is used in **hardware CTF challenges** and real-world IoT penetration testing to extract encrypted firmware or private keys from flash memory
- Defense involves **disabling debug interfaces in firmware/fuses** (e.g., blowing JTAG fuse bits) rather than relying solely on physical removal of headers

## Related concepts
[[JTAG]] [[UART debug interface]] [[hardware hacking]] [[firmware extraction]] [[debug port security]]