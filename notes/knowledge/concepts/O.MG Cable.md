# O.MG Cable

## What it is
Like a Trojan Horse disguised as a USB charging cable, the O.MG Cable is a weaponized hardware implant that looks identical to a legitimate Lightning or USB-C cable but contains a hidden Wi-Fi-enabled microcontroller inside the connector housing. An attacker can remotely execute keystrokes, inject payloads, and exfiltrate data from a target machine while the victim believes they are simply charging their phone.

## Why it matters
In a physical penetration test scenario, a red teamer drops an O.MG Cable near a target's desk. The employee plugs it into their laptop to charge a device; the attacker connects over Wi-Fi from a nearby café and executes a reverse shell payload silently — full compromise with zero malware installed on disk. This demonstrates why physical security controls and "no unknown cable" policies are critical compensating controls.

## Key facts
- Created by security researcher MG (Mike Grover) and sold commercially through Hak5 as a legitimate pen testing tool
- Contains an embedded Wi-Fi access point operating in the 2.4 GHz range, allowing remote trigger of HID (Human Interface Device) attacks from up to 300 feet away
- Emulates a keyboard (HID spoofing) to inject pre-programmed keystrokes at machine speed — bypassing endpoint antivirus because no file is written
- Cables retail around $180–$200, making them accessible to well-resourced threat actors and red teams alike
- Defense: USB Restricted Mode (e.g., iOS, Windows), USB condoms (data-blocking adapters), and organizational policies prohibiting use of unverified cables

## Related concepts
[[HID Spoofing Attack]] [[BadUSB]] [[Physical Penetration Testing]] [[USB Drop Attack]] [[Hardware Implant]]