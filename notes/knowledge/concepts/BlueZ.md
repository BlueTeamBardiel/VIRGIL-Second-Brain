# BlueZ

## What it is
Think of BlueZ as the translator at a diplomatic summit — it's the official software stack that lets Linux kernels speak fluent Bluetooth with any hardware device. Precisely, BlueZ is the official Linux Bluetooth protocol stack, implementing core Bluetooth protocols and profiles at the kernel and user-space levels, handling everything from device discovery to data exchange.

## Why it matters
In 2017, the **BlueBorne** vulnerability chain targeted BlueZ directly, allowing attackers to achieve remote code execution on Linux systems *without any user interaction or device pairing* — just proximity to a Bluetooth-enabled device was enough. Security teams had to rapidly patch millions of IoT devices, Android gadgets, and Linux servers because BlueZ shipped unpatched code that exposed the kernel's networking subsystem to unauthenticated attackers.

## Key facts
- BlueZ is the **default Bluetooth stack for Linux**, maintained by the Linux kernel community and shipped in virtually all major distributions (Ubuntu, Debian, RHEL, Android historically)
- The **BlueBorne attack (CVE-2017-1000251)** exploited a stack buffer overflow in BlueZ's L2CAP (Logical Link Control and Adaptation Protocol) handling, enabling full RCE with kernel privileges
- BlueZ operates across **multiple OSI layers**, handling L2CAP, RFCOMM (serial emulation), BNEP (network encapsulation), and HCI (Host Controller Interface)
- Bluetooth attacks enabled by BlueZ vulnerabilities require **no user interaction and no pairing**, making them especially dangerous in zero-click threat models
- Hardening guidance includes **disabling Bluetooth when unused**, using `rfkill block bluetooth`, and enforcing kernel patching cadence — relevant to CySA+ hardening objectives

## Related concepts
[[BlueBorne]] [[Bluetooth Security]] [[CVE Exploitation]] [[Kernel Vulnerabilities]] [[Zero-Click Attacks]]