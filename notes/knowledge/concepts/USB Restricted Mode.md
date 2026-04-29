# USB Restricted Mode

## What it is
Think of it like a hotel room's deadbolt that automatically engages after you've been asleep for an hour — the door stays locked even if someone has a keycard. USB Restricted Mode is an iOS security feature that disables the USB data connection on a Lightning or USB-C port if the device hasn't been unlocked within the past hour, while still allowing charging.

## Why it matters
In 2018, Grayshift's GrayKey and Cellebrite's UFED tools exploited the always-on USB data channel to brute-force or extract data from locked iPhones — a technique used in law enforcement forensics and, inevitably, by adversaries. Apple introduced USB Restricted Mode specifically to neutralize these "juice jacking" escalation paths and forensic extraction tools by cutting off the data channel before attackers can establish a communication session.

## Key facts
- Introduced in **iOS 11.4.1** (2018) as a direct countermeasure to forensic extraction tools
- The one-hour timer resets every time the device is **unlocked with a passcode or biometric**
- Power/charging is **not affected** — only the data interface is restricted
- Can be disabled in Settings → Face ID & Passcode → "USB Accessories" toggle (enabled by default in newer iOS)
- Attackers with **physical access** must race the one-hour clock, making time-sensitive physical attacks significantly harder
- Bypasses have been researched using accessories that "ping" the port to reset the timer, though Apple has patched known implementations

## Related concepts
[[Juice Jacking]] [[Physical Security Controls]] [[Mobile Device Management]] [[Full Disk Encryption]] [[Forensic Acquisition]]