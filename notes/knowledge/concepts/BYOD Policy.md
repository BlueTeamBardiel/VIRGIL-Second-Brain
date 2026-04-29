# BYOD Policy

## What it is
Like allowing employees to drive their personal cars for company deliveries — convenient, but you lose control over maintenance, insurance, and what else is in the trunk. A Bring Your Own Device (BYOD) policy is a formal organizational framework that defines the rules, security requirements, and acceptable use conditions under which employees may use personally-owned devices (phones, laptops, tablets) to access corporate networks and data. It balances employee convenience against the organization's obligation to protect sensitive assets.

## Why it matters
In 2020, a healthcare employee's personal Android phone — enrolled under a lax BYOD policy with no MDM enforcement — was infected with spyware that silently exfiltrated patient records over three months before detection. A properly enforced BYOD policy with mandatory Mobile Device Management (MDM) enrollment, containerization of corporate data, and remote wipe capability would have contained the breach to the personal partition, protecting PHI under HIPAA obligations.

## Key facts
- **MDM/MAM enforcement** is the technical backbone of BYOD — Mobile Device Management controls the device; Mobile Application Management controls only corporate apps (less invasive)
- **Containerization** isolates corporate data into an encrypted partition, preventing personal apps from accessing work email, files, or credentials
- **Remote wipe** must be defined in policy: selective wipe (corporate data only) vs. full wipe (entire device) — employees must consent before enrollment
- **Onboarding/offboarding procedures** are critical; departing employees' devices must have corporate data wiped immediately upon termination
- BYOD policies must address **acceptable use, supported OS versions, minimum patch levels, jailbreak/root detection**, and liability boundaries for lost devices

## Related concepts
[[Mobile Device Management]] [[Data Loss Prevention]] [[Network Access Control]] [[Acceptable Use Policy]] [[Endpoint Security]]