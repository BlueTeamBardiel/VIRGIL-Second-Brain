# USB Security

## What it is
Like a stranger handing you a wrapped gift outside a bank — it looks harmless, but you have no idea what's inside. USB security refers to the policies, controls, and defenses organizations use to prevent malicious or unauthorized use of USB devices, which can introduce malware, exfiltrate data, or emulate trusted hardware without the user's knowledge.

## Why it matters
In 2010, Stuxnet spread partly via infected USB drives into air-gapped Iranian nuclear facilities — proving that even networks physically isolated from the internet can be compromised by a single plugged-in device. A modern equivalent is the **BadUSB** attack, where a reprogrammed USB firmware causes the device to masquerade as a keyboard, silently injecting keystrokes that download malware within seconds of insertion.

## Key facts
- **BadUSB** exploits the fact that USB firmware is reprogrammable and most OSes automatically trust USB device classes (HID, storage, network adapters)
- **USB Drop Attacks** rely on human curiosity — studies show ~50% of people plug in found USB drives; marking them "Payroll Q4" increases that rate significantly
- Windows Group Policy and endpoint tools like **Microsoft Intune** can enforce USB device whitelisting by hardware ID
- **Data Loss Prevention (DLP)** solutions can block or log file transfers to removable media, addressing insider threat scenarios
- Air-gapped systems are **not immune** — USB remains one of the primary attack vectors for physically isolated environments (as proven by Stuxnet and Agent.BTZ)

## Related concepts
[[Physical Security Controls]] [[Endpoint Security]] [[Data Loss Prevention]] [[BadUSB]] [[Air-Gap Attacks]]