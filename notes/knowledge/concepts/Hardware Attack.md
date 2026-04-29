# Hardware Attack

## What it is
Like a pickpocket who bypasses your home's alarm system by simply stealing your entire safe, hardware attacks bypass software security entirely by targeting the physical device itself. Precisely defined, a hardware attack exploits physical components — circuit boards, chips, firmware, or peripheral interfaces — to extract data, implant malicious functionality, or disrupt operations. Unlike software exploits, these attacks often leave no log trails and survive OS reinstalls.

## Why it matters
In 2018, Bloomberg reported allegations that Chinese supply chain operatives implanted rice-grain-sized spy chips on Supermicro server motherboards destined for Amazon and Apple data centers — a hardware implant that would have given persistent, undetectable access to network traffic. Whether or not that specific case was confirmed, it drove the entire industry to demand hardware Bill of Materials (HBOM) transparency and stricter supply chain verification protocols.

## Key facts
- **Evil Maid Attack**: An attacker with brief physical access installs a hardware keylogger or bootkit — full disk encryption means nothing if the keyboard is compromised before the password is typed.
- **Cold Boot Attack**: RAM retains data for seconds to minutes after power loss; an attacker can freeze memory chips, transfer them to another machine, and dump encryption keys.
- **JTAG/Debug Interfaces**: Manufacturing debug ports left enabled on shipped devices allow direct memory read/write — a common finding in IoT penetration testing.
- **Hardware Trojans**: Malicious circuits inserted during fabrication or supply chain transit that activate under specific conditions (e.g., a certain date or input pattern).
- **Countermeasure**: Tamper-evident seals, Trusted Platform Module (TPM) attestation, and Measured Boot detect unauthorized hardware or firmware changes before OS load.

## Related concepts
[[Supply Chain Attack]] [[Cold Boot Attack]] [[Trusted Platform Module (TPM)]] [[Firmware Attack]] [[Physical Security]]