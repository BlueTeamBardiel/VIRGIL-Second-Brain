# Physical access attacks

## What it is
Like a master locksmith who bypasses your alarm system entirely by simply walking through an unlocked back door, physical access attacks exploit direct, hands-on proximity to hardware rather than attacking through software or the network. They involve an adversary gaining physical control of a device, port, or facility to extract data, implant malware, or bypass logical security controls. No firewall or antivirus stands between an attacker and a machine they can physically touch.

## Why it matters
In 2008, operatives planted USB-infected drives in parking lots near a U.S. Department of Defense facility — employees picked them up and plugged them in, ultimately compromising classified military networks (Operation Buckshot Yankee). This incident shows that even air-gapped or hardened networks can be penetrated the moment physical boundaries are violated. Defense relies on a combination of USB port disabling, security awareness training, and facility access controls.

## Key facts
- **Evil maid attack**: An attacker with brief physical access installs a bootkit or keylogger on an unattended device (common hotel/travel threat scenario)
- **Cold boot attack**: RAM retains data for seconds to minutes after power-off; an attacker can dump encryption keys (including BitLocker) by quickly removing and reading the memory modules
- **USB drop attack**: Malicious drives exploit AutoRun or curiosity-driven insertion; classified as a social engineering + physical vector hybrid
- **Tailgating/piggybacking**: Bypasses electronic access controls by following an authorized person through a secured door — countered by mantraps and security awareness
- **Disk imaging via live boot**: Booting a machine from external media circumvents OS-level authentication entirely, enabling full disk access in minutes

## Related concepts
[[Cold Boot Attack]] [[Evil Maid Attack]] [[Tailgating]] [[USB Drop Attack]] [[Mantrap]] [[Disk Encryption]]