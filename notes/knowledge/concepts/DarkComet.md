# DarkComet

## What it is
Think of it as a skeleton key that also installs a hidden camera in your house — the attacker gets in, looks around, and watches everything you do without you knowing. DarkComet is a Remote Access Trojan (RAT) developed around 2008 by French coder Jean-Pierre Lesueur, designed to give attackers full covert control over a victim's Windows machine. It combines keylogging, webcam capture, file system access, and remote shell capabilities into a single C2-driven toolkit.

## Why it matters
During the 2011–2012 Syrian Civil War, government forces used DarkComet to surveil Syrian opposition activists — capturing webcam footage, keystrokes, and communications to identify and target dissidents. This case became a landmark example of how commodity RATs can be weaponized for state-level surveillance and human rights violations, prompting the developer to abandon the project publicly in 2012.

## Key facts
- DarkComet operates over a **client-server model**: the attacker runs a GUI controller; the victim runs an injected stub payload
- It uses **port 1604 by default** for C2 communications, a known indicator of compromise in network traffic analysis
- Capabilities include: **keylogging, remote desktop viewing, webcam/microphone access, password harvesting, and process management**
- It achieves **persistence** via Windows Registry run keys (`HKCU\Software\Microsoft\Windows\CurrentVersion\Run`)
- DarkComet payloads are commonly **detected by behavioral analysis** rather than signature alone, as variants are frequently repacked to evade AV signature databases

## Related concepts
[[Remote Access Trojan]] [[Command and Control (C2)]] [[Keylogger]] [[Persistence Mechanisms]] [[Indicators of Compromise]]