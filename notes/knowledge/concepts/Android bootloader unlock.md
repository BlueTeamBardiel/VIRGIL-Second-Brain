# Android bootloader unlock

## What it is
Think of the bootloader as a bouncer at a club who checks IDs before anyone gets on stage — unlocking it fires the bouncer and lets anyone perform. Precisely, the Android bootloader is firmware that initializes hardware and verifies the cryptographic signature of the OS before loading it; unlocking it disables this Verified Boot chain, allowing unsigned or custom operating system images to be flashed onto the device.

## Why it matters
In the 2016 Cellebrite/GrayKey forensic tooling era, law enforcement leveraged bootloader unlocks (or exploits bypassing them) to extract full-disk encryption keys from seized Android devices. Conversely, a threat actor with brief physical access to an unlocked-bootloader device can flash a backdoored OS image, establishing persistent malware that survives factory resets — a classic "evil maid" attack scenario.

## Key facts
- Unlocking the bootloader **triggers a factory reset** on most devices, wiping user data — this is a deliberate security control to prevent silent exploitation.
- Android's **Verified Boot (dm-verity)** uses a hardware-backed root of trust; unlocking breaks this chain, allowing detection of tampering to be bypassed entirely.
- Many enterprise MDM policies (e.g., Android Enterprise) can **detect unlocked bootloader status** via the `ro.boot.verifiedbootstate` property and block enrollment or wipe the device.
- OEM unlock must typically be **enabled in Developer Options first**, providing a software gate that MDMs can disable remotely.
- On Google Pixel devices, unlocking is performed via `fastboot flashing unlock` — the command sequence is standardized and well-documented, lowering attacker skill requirements.

## Related concepts
[[Verified Boot]] [[Android Rooting]] [[Full Disk Encryption]] [[Evil Maid Attack]] [[Mobile Device Management]]