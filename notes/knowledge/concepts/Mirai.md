# Mirai

## What it is
Imagine an army of forgotten security cameras and DVRs — devices nobody updates, sitting on public IPs with factory passwords still set — suddenly all pointing at the same target on command. Mirai is a botnet malware strain that compromises IoT devices by scanning for Telnet-accessible systems using a hardcoded list of default credentials, then enlists them into a distributed attack force. Once infected, devices remain functional to avoid detection while awaiting commands from a C2 server.

## Why it matters
In October 2016, Mirai-controlled botnets (primarily hijacked CCTV cameras and home routers) launched a massive DDoS attack against Dyn, a major DNS provider, taking down Twitter, Netflix, Reddit, and Spotify for hours across the U.S. East Coast. This attack demonstrated that insecure consumer IoT devices could be weaponized to cripple critical internet infrastructure at scale.

## Key facts
- Mirai's source code was publicly released in 2016, spawning dozens of variants (Hajime, Satori, Reaper) that expanded targeting beyond default credentials
- It used a hardcoded list of **61 default username/password pairs** to brute-force Telnet (port 23) on IoT devices
- The Dyn attack peaked at approximately **1.2 Tbps**, making it one of the largest DDoS attacks recorded at the time
- Mirai kills competing malware processes on infected devices and blocks remote administration ports to maintain exclusive control
- Mitigation focuses on **network segmentation of IoT devices**, disabling Telnet, changing default credentials, and ISP-level BCP38 filtering to prevent IP spoofing in amplification attacks

## Related concepts
[[Botnet]] [[DDoS]] [[Default Credentials]] [[IoT Security]] [[Command and Control (C2)]]