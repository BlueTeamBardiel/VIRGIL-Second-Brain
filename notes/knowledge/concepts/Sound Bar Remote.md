# Sound Bar Remote

## What it is
Like a universal TV remote that speaks IR or RF to control your entertainment system, a sound bar remote is a dedicated or universal controller that sends commands — often via infrared, Bluetooth, or RF — to manage audio output devices. In a smart home or enterprise AV environment, these remotes can be paired devices that authenticate (or fail to authenticate) with a receiver, creating a small but real attack surface within the IoT ecosystem.

## Why it matters
In a red team assessment of a smart office environment, an attacker within physical proximity could use a software-defined radio (SDR) or IR blaster to replay captured remote signals, hijacking AV equipment to disrupt meetings, exfiltrate audio, or pivot to other Bluetooth-paired devices on the same network segment. This is a concrete example of how physical-layer attacks bypass traditional network defenses entirely.

## Key facts
- Most IR-based remotes have **zero authentication** — any device transmitting the correct frequency and code can issue commands (replay attack trivially possible)
- Bluetooth-paired remotes use pairing codes, but older devices may use **predictable PINs (e.g., 0000)**, making them vulnerable to Bluetooth brute-force attacks
- RF remotes operating on 433 MHz are susceptible to **signal capture and replay** using cheap SDR hardware (e.g., RTL-SDR)
- Smart sound bars connected to Wi-Fi expand the attack surface to **network-based exploitation**, including default credential abuse and unpatched firmware vulnerabilities
- Under **CIS Controls** and IoT security frameworks, AV devices are often overlooked during asset inventory, making them common blind spots in vulnerability management programs

## Related concepts
[[Replay Attack]] [[Bluetooth Security]] [[IoT Security]] [[Software-Defined Radio]] [[Physical Security]]