# f_mass_storage

## What it is
Like a postal worker who can hand-deliver a USB drive to any computer just by plugging in a phone, `f_mass_storage` is a Linux kernel USB gadget module that makes a device (like a Raspberry Pi or Android phone) *appear* as a USB mass storage device to any host it connects to. It exposes a block device (a disk image or partition) as a standard USB drive when the gadget connects to a host machine.

## Why it matters
In BadUSB-style attacks, an attacker configures a small Linux SBC (like a Pi Zero) with `f_mass_storage` pointing to a disk image containing malicious autorun payloads or fake software installers. When plugged into a corporate workstation, Windows may auto-mount the device and execute content via AutoPlay, or a user may manually run what appears to be a legitimate update package — bypassing endpoint controls that wouldn't flag a "USB drive."

## Key facts
- `f_mass_storage` is part of the Linux **USB Gadget API** (`libcomposite` framework), loaded as a kernel module on OTG-capable devices
- It can expose **read-only or read-write** disk images (`.img` files), making it possible to present tamper-evident or write-locked "evidence" drives
- Commonly combined with `g_multi` or `libcomposite` to simultaneously present as **multiple device classes** (HID + mass storage), enabling compound BadUSB attacks
- Defenders mitigate risks by enforcing **USB device whitelisting** via Group Policy (Windows) or `udev` rules (Linux), restricting mass storage class (`0x08`) devices
- Relevant to **physical penetration testing** methodology — dropping a pre-configured Pi Zero in a target facility is a documented red team technique

## Related concepts
[[BadUSB]] [[USB_Rubber_Ducky]] [[HID_Attack]] [[USB_Device_Whitelisting]] [[Physical_Penetration_Testing]]