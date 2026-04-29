# USB Drop Attack

## What it is
Like leaving a poisoned apple in a parking lot and waiting for someone to pick it up, a USB drop attack involves deliberately placing malicious USB drives in public locations to trick victims into plugging them in. Once inserted, the drive auto-executes malware, acts as a HID (Human Interface Device) spoofing a keyboard, or exfiltrates data — all without the user suspecting anything beyond finding a "free flash drive."

## Why it matters
In 2008, the U.S. military suffered one of its worst breaches when an infected USB drive found in a parking lot near a Middle East base was plugged into a classified laptop, unleashing the **Agent.btz** worm across military networks. This single event directly led to the creation of U.S. Cyber Command and a multi-year ban on USB devices across DoD systems.

## Key facts
- Studies show **48% of people** who find dropped USB drives plug them in — curiosity and the desire to find the owner are primary motivators
- Malicious USBs can masquerade as **HID devices** (keyboards/mice), bypassing endpoint antivirus since they appear as input hardware, not storage
- The **BadUSB** attack reprograms a USB controller's firmware, making detection nearly impossible through standard file scanning
- Mitigation controls include **disabling USB ports via Group Policy**, endpoint DLP tools, and physical port blockers
- Classified as a **social engineering + physical security** hybrid attack; relevant to both human and technical control categories on Security+ exam

## Related concepts
[[Social Engineering]] [[HID Spoofing]] [[BadUSB]] [[Physical Security Controls]] [[Endpoint Security]]