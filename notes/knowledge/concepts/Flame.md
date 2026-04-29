# Flame

## What it is
Imagine a Swiss Army knife the size of a briefcase, hidden inside a diplomat's luggage — that's Flame. Flame (also called Flamer or sKyWIper) is a sophisticated modular cyberespionage malware discovered in 2012, primarily targeting Middle Eastern nations, capable of recording audio, screenshots, keystrokes, and network traffic while spreading via Bluetooth and USB.

## Why it matters
In 2012, Flame was discovered on Iranian government systems and oil ministry computers, believed to be a joint U.S.-Israeli intelligence operation linked to the same actors behind Stuxnet. Its most alarming capability was exploiting an MD5 collision vulnerability to forge a fraudulent Microsoft code-signing certificate, allowing it to masquerade as a legitimate Windows Update — meaning victims willingly installed it thinking it was a patch.

## Key facts
- Flame used a forged MD5 collision-based certificate to impersonate Microsoft's Windows Update infrastructure, making it one of the first malware to weaponize cryptographic hash collisions in the wild
- It was approximately 20MB in size — roughly 20x larger than Stuxnet — due to its modular architecture containing multiple plug-in components (attack modules could be loaded/unloaded remotely)
- Capable of turning infected machines into Bluetooth beacons to map and potentially infect nearby devices, extending espionage beyond network boundaries
- Command-and-control communication used encrypted channels, with operators able to issue a self-destruct "SUICIDE" command to wipe traces from infected systems
- Flame operated undetected for an estimated 2–5 years before discovery, highlighting failures in traditional signature-based AV detection

## Related concepts
[[Stuxnet]] [[Advanced Persistent Threat (APT)]] [[MD5 Collision Attack]] [[Code Signing]] [[Cyberespionage]]