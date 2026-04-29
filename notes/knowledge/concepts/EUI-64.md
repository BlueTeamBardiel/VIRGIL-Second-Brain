# EUI-64

## What it is
Like a contractor who automatically stamps their business address onto every document they file, EUI-64 is a method where a device constructs its own IPv6 interface identifier by embedding its 48-bit MAC address into a 64-bit value — inserting `FFFE` in the middle and flipping the 7th bit. This creates a globally unique, self-assigned host portion of an IPv6 address without requiring a DHCP server.

## Why it matters
EUI-64 addresses create a persistent tracking identifier tied directly to a device's hardware. An attacker performing passive network reconnaissance can correlate IPv6 addresses across different networks to the same physical device — a serious privacy vulnerability that led to RFC 7217 (stable but opaque addresses) and RFC 4941 (privacy extensions with randomized temporary addresses). In enterprise forensics, however, this same persistence is a *feature* — defenders can tie network traffic directly to a physical NIC.

## Key facts
- Constructed by splitting the 48-bit MAC at the midpoint, inserting `FF:FE`, then inverting bit 6 (the Universal/Local bit) of the first octet
- Example: MAC `00:1A:2B:3C:4D:5E` → EUI-64 interface ID `02:1A:2B:FF:FE:3C:4D:5E`
- Used in SLAAC (Stateless Address Autoconfiguration) to generate the host portion of a full 128-bit IPv6 address
- The bit-flip on the U/L bit converts from IEEE convention (0 = universal) to IETF convention (1 = globally unique)
- Modern OS defaults (Windows Vista+, Linux 3.x+) use privacy extensions by default *instead* of EUI-64 to prevent tracking

## Related concepts
[[IPv6 SLAAC]] [[MAC Address]] [[IPv6 Privacy Extensions]]