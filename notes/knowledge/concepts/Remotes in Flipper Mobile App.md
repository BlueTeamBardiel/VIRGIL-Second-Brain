# Remotes in Flipper Mobile App

## What it is
Think of it like a universal TV remote stored in the cloud — except instead of changing channels, it controls infrared devices, Sub-GHz transmitters, and NFC emulators from your phone. The Remotes feature in the Flipper Zero mobile app allows users to create, store, and share saved signal configurations (remotes) that can be synced to a physical Flipper Zero device and triggered remotely via Bluetooth from a smartphone.

## Why it matters
An attacker who gains access to a shared or publicly posted Flipper Remote configuration could replay captured signals — such as gate access codes or hotel TV infrared commands — without ever having physically captured the signal themselves. Defenders need to understand that signal-sharing platforms lower the technical barrier for replay attacks, making previously "hardware-required" exploits accessible to script-level threat actors.

## Key facts
- Remotes are stored signal files (e.g., `.ir`, `.sub`) that map physical button presses to specific frequency transmissions or infrared codes
- The mobile app communicates with the Flipper Zero over Bluetooth Low Energy (BLE), meaning BLE interception or MitM attacks could theoretically intercept or spoof remote commands
- Shared remotes can be distributed via the Flipper Mobile App community library, creating a signal-sharing ecosystem analogous to exploit databases like Exploit-DB
- Replay attack risk is inherent: static, non-rolling-code signals captured and saved as remotes can be retransmitted indefinitely
- Rolling-code systems (e.g., modern garage openers using KeeLoq) are **not** defeated by simple remote replay — distinguishing static vs. rolling codes is a critical defensive concept

## Related concepts
[[Replay Attack]] [[Sub-GHz Radio Exploitation]] [[Bluetooth Low Energy Security]] [[Signal Capture and Retransmission]] [[Rolling Code Authentication]]