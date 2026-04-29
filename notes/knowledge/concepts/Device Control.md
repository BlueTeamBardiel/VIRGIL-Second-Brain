# Device Control

## What it is
Think of it as a bouncer at a club who checks not just your ID, but also what you're carrying in your pockets — no unauthorized USB drives, cameras, or Bluetooth dongles allowed past the door. Device Control is a security policy enforcement mechanism that governs which peripheral devices (USB drives, smartphones, printers, external hard drives) can connect to and interact with endpoints on a network.

## Why it matters
In 2008, a USB drive infected with Agent.btz malware was plugged into a U.S. military laptop in the Middle East, triggering one of the most significant breaches of classified military networks in history. A properly enforced device control policy — blocking unauthorized USB storage — would have stopped that attack at the physical insertion point before any code executed.

## Key facts
- Device control is commonly enforced through **DLP (Data Loss Prevention)** solutions and **endpoint protection platforms (EPP)** like CrowdStrike or Symantec Endpoint
- Policies can be granular: allow read-only access to USB devices, block mass storage while permitting USB keyboards/mice (using device class filtering)
- **Whitelisting by hardware ID** is stronger than class-based blocking — it permits only specifically approved devices rather than entire categories
- Disabling AutoRun/AutoPlay on Windows is a foundational device control measure that prevents automatic malware execution from removable media
- Device control logs serve as forensic artifacts in insider threat investigations, recording timestamps, device serial numbers, and user accounts

## Related concepts
[[Data Loss Prevention]] [[Endpoint Detection and Response]] [[USB Drop Attack]] [[Least Privilege]] [[Insider Threat]]