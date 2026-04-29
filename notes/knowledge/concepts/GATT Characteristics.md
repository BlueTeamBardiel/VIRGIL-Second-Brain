# GATT Characteristics

## What it is
Think of a GATT Characteristic like a labeled slot on a vending machine — each slot has an address, a value inside it, and rules about whether you can read it, write to it, or get notified when it changes. Precisely: a GATT (Generic Attribute Profile) Characteristic is the fundamental data unit in Bluetooth Low Energy (BLE) communication, consisting of a UUID, a value, and a set of properties defining allowed operations (read, write, notify, indicate). Characteristics live inside Services, which group related data together on a BLE peripheral device.

## Why it matters
During BLE security assessments, attackers enumerate GATT Characteristics on medical devices, smart locks, or fitness trackers to find writable characteristics that accept unauthenticated commands — for example, writing to a "lock control" characteristic without any pairing requirement to unlock a door. Tools like `gatttool` or `BLE Scanner` allow an attacker to walk a device's attribute table, discover unprotected characteristics, and replay or forge write commands, demonstrating why proper authentication and authorization must be enforced at the characteristic level.

## Key facts
- Every Characteristic has a **UUID** (16-bit for standard Bluetooth SIG types, 128-bit for vendor-specific), a **value**, and **properties** (Read, Write, Write Without Response, Notify, Indicate)
- **Notify** sends updates to the client without acknowledgment; **Indicate** requires an acknowledgment — both require the client to enable them via the Client Characteristic Configuration Descriptor (CCCD)
- Characteristics with `Write Without Response` property are particularly dangerous — they accept data with no confirmation, making replay attacks straightforward
- BLE has **no native encryption enforcement** at the characteristic level; protection depends on pairing mode (e.g., LE Secure Connections) configured at the link layer
- Characteristic **handles** (numeric addresses) are used in actual ATT protocol packets — fuzzing handles can expose undocumented or hidden characteristics

## Related concepts
[[Bluetooth Low Energy Security]] [[GATT Services]] [[BLE Pairing and Bonding]]