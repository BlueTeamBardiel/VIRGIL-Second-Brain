# Remote Wipe

## What it is
Like a self-destructing briefcase that incinerates its contents when stolen, remote wipe is a command issued over a network to erase all data on a device — even when the device is no longer in your physical possession. It is a mobile device management (MDM) capability that allows administrators or users to trigger a factory reset or selective data deletion on smartphones, tablets, or laptops remotely.

## Why it matters
In 2020, a healthcare employee left an unencrypted company laptop in a rental car. Before the thief could access patient records, the IT team issued a remote wipe through their MDM platform, erasing all data within hours of the theft — preventing a reportable HIPAA breach. Without remote wipe, the organization faced potential fines exceeding $1.9 million.

## Key facts
- **Selective wipe** removes only corporate data and apps (leaving personal data intact), while a **full wipe** restores factory defaults — both are critical distinctions for BYOD policies
- Remote wipe requires the device to have **network connectivity** (Wi-Fi or cellular) to receive the command; an airplane-mode device cannot be wiped until it reconnects
- MDM platforms (Microsoft Intune, Jamf, VMware Workspace ONE) are the primary enforcement mechanisms for remote wipe in enterprise environments
- Remote wipe is a **compensating control** for lost/stolen devices and directly supports the security principle of **data confidentiality**
- On iOS and Android, **device encryption combined with remote wipe** is considered best practice — encryption protects data if the wipe command is delayed, wipe ensures permanent removal

## Related concepts
[[Mobile Device Management]] [[Data Loss Prevention]] [[Endpoint Security]] [[BYOD Policy]] [[Full Disk Encryption]]