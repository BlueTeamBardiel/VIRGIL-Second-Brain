# BYOD

## What it is
Like letting employees park personal cars in the company garage — convenient, but now you're responsible for what's in the trunk. BYOD (Bring Your Own Device) is a policy that permits employees to use personally owned smartphones, laptops, or tablets to access corporate resources and data. The organization gains productivity but loses direct control over the hardware and its security posture.

## Why it matters
In 2020, a financial services firm suffered a data breach when an employee's personal Android phone — enrolled in their BYOD program but missing critical patches — was compromised via a malicious app. The attacker pivoted from the personal device to the corporate email system through a shared VPN session, exfiltrating customer records. A proper MDM solution with enforced containerization would have isolated corporate data from the compromised personal partition.

## Key facts
- **MDM/MAM enforcement** is the primary control: Mobile Device Management can remotely wipe corporate data; Mobile Application Management containerizes only corporate apps without touching personal data
- **Legal and privacy tension**: Organizations can remotely wipe BYOD devices, potentially destroying personal photos and data — acceptable use policies must address this explicitly
- **Network segmentation** is critical: BYOD devices should be placed on a separate VLAN/guest network, never granted the same trust level as corporate-managed endpoints
- **Jailbroken/rooted devices** are a key exam risk — MDM solutions should detect and block enrollment or access from compromised devices
- **Data sovereignty risk**: Personal devices may sync corporate data to personal cloud storage (iCloud, Google Drive) outside organizational control

## Related concepts
[[Mobile Device Management]] [[Network Access Control]] [[Data Loss Prevention]] [[Zero Trust Architecture]] [[Acceptable Use Policy]]