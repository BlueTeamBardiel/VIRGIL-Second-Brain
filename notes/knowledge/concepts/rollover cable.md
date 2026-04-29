# rollover cable

## What it is
Like a surgeon's direct line into a patient's nervous system — bypassing all the normal communication layers — a rollover cable gives you raw, direct access to a network device's brain. It's a flat, often blue cable (also called a Cisco console cable) where each pin on one end is "rolled over" (reversed) to the opposite pin on the other end, used exclusively to connect a workstation's serial port to a network device's console port for out-of-band management.

## Why it matters
When a misconfigured router drops off the network entirely and remote SSH access is impossible, a rollover cable is the only lifeline — a technician plugs directly into the console port to recover the device without network connectivity. From an attacker's perspective, physical access to a console port via rollover cable bypasses all network-based authentication controls, meaning an attacker with five minutes alone in a server room can own a core router entirely.

## Key facts
- Pin 1 connects to Pin 8, Pin 2 to Pin 7, etc. — the full reversal is what defines it as a "rollover" (vs. straight-through or crossover)
- Uses RS-232 serial communication, typically configured at **9600 baud, 8 data bits, no parity, 1 stop bit, no flow control** (9600 8N1)
- Provides **out-of-band management** — access works even when the device has no IP address or is completely misconfigured
- Physical security of console ports is a critical control; unprotected console ports are a common finding in physical penetration tests
- Modern devices often use a **USB-to-RJ45 console cable** (functionally equivalent), since laptops lack DB-9 serial ports

## Related concepts
[[out-of-band management]] [[physical security]] [[serial communication]]