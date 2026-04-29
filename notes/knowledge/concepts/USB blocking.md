# USB blocking

## What it is
Like a bouncer who won't let anyone through the door without a VIP wristband, USB blocking prevents unauthorized removable media from connecting to endpoints — regardless of what's plugged in. Technically, it is a data loss prevention (DLP) and endpoint security control that restricts or audits USB port usage through group policy, endpoint agents, or hardware disabling.

## Why it matters
In 2008, a USB drive infected with the Agent.btz worm was deliberately left in a Pentagon parking lot; once plugged in by a curious employee, it propagated across classified military networks and triggered a 14-month remediation effort called Operation Buckshot Yankee. USB blocking enforced at the OS and hardware level would have severed the initial infection vector entirely before any payload executed.

## Key facts
- USB blocking can be implemented via **Windows Group Policy** (`Computer Configuration > Administrative Templates > System > Removable Storage Access`), endpoint DLP agents (e.g., CrowdStrike, Symantec DLP), or physical port blockers.
- Three control tiers exist: **administrative** (policy), **technical** (software/driver-level enforcement), and **physical** (epoxy, port locks, or disabled BIOS headers).
- Whitelisting by **hardware ID or serial number** allows approved devices (e.g., encrypted corporate drives) while blocking all others — more precise than full prohibition.
- USB blocking directly counters **BadUSB attacks**, where a device's firmware is reprogrammed to masquerade as a keyboard or network adapter, bypassing file-based scanning.
- Covered under **NIST SP 800-53 control MP-7** (Media Use) and relevant to **PCI DSS Requirement 12.3**, which mandates policies for removable media usage.

## Related concepts
[[Data Loss Prevention (DLP)]] [[Endpoint Detection and Response (EDR)]] [[BadUSB]] [[Media Sanitization]] [[Group Policy]]