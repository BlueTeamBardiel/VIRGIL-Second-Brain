# Device Compliance

## What it is
Think of device compliance like a bouncer checking IDs at a club door — not just "are you on the list?" but "are your shoes clean, is your shirt tucked in, and do you have your vaccination card?" Device compliance is the continuous verification that endpoints meet a defined security baseline (patch level, AV status, encryption, configuration) before and during network access. It is enforced through a compliance policy engine, often integrated with NAC or MDM platforms.

## Why it matters
In 2021, attackers compromised a Florida water treatment facility partly because the workstation lacked modern endpoint controls and ran outdated software — a textbook compliance failure. A properly enforced compliance policy would have flagged that machine as non-compliant and quarantined it to a remediation VLAN before it could reach operational technology systems.

## Key facts
- **Compliance policies** typically check: OS patch level, antivirus signatures, disk encryption status, firewall state, and presence of required software agents
- **Non-compliant devices** are commonly shunted to a **remediation VLAN** with internet-only or limited access until issues are resolved
- **MDM platforms** (Intune, Jamf) enforce compliance on mobile/corporate devices; **NAC solutions** (Cisco ISE, Aruba ClearPass) enforce it at the network layer
- **Conditional Access** in Azure AD/Entra ID can deny cloud resource access to devices that fail compliance checks — even with valid credentials
- Device compliance is a core control in **Zero Trust Architecture**, where network location alone is never sufficient for trust decisions

## Related concepts
[[Network Access Control]] [[Mobile Device Management]] [[Zero Trust Architecture]] [[Endpoint Detection and Response]] [[Conditional Access]]