# udev

## What it is
Think of udev as a bouncer who watches the venue entrance and automatically hands out wristbands (device files and permissions) the moment someone walks through the door. Precisely: udev is the Linux kernel's dynamic device management system that monitors the `/dev` virtual filesystem, listening for kernel events (uevents) and automatically creating/removing device nodes and applying permission rules when hardware is connected or disconnected.

## Why it matters
Attackers have abused udev rules as a persistence mechanism — by writing a malicious rule to `/etc/udev/rules.d/`, an adversary can trigger arbitrary command execution every time a USB device is plugged in, surviving reboots without touching cron or systemd. Defenders hunting for this technique inspect udev rule files for `RUN+=` directives pointing to unexpected scripts or binaries, which is exactly the kind of persistence hunt covered in CySA+ threat-hunting scenarios.

## Key facts
- udev rules live in `/etc/udev/rules.d/` (admin-defined), `/lib/udev/rules.d/` (distro defaults), and `/run/udev/rules.d/` (runtime); later rules override earlier ones
- The `RUN+=` key in a udev rule executes a program as **root** in a minimal environment — no TTY, restricted PATH — making it a stealthy execution context
- udev replaced the older static `/dev` approach and the intermediate `devfs`; it is managed by `systemd-udevd` on modern systems
- Device attributes matched in rules include `SUBSYSTEM`, `ACTION` (add/remove/change), `ATTR{}`, and `ENV{}` — attackers use `ACTION=="add"` with USB subsystem matches for triggered payloads
- Forensic artifact: malicious udev rules often use `SUBSYSTEM=="usb"` combined with `RUN+="/path/to/backdoor"` — a simple `grep -r "RUN+=" /etc/udev/rules.d/` can reveal unauthorized entries

## Related concepts
[[Linux Persistence Mechanisms]] [[Privilege Escalation]] [[USB Attack Vectors]] [[File Permission Hardening]]