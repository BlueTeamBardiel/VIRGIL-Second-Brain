# IoT

## What it is
Imagine giving every light switch, thermostat, and door lock in your house a phone number — now imagine none of them have locks on *their* doors. IoT (Internet of Things) refers to the billions of network-connected physical devices — from industrial sensors to smart fridges — that collect and transmit data but are typically designed for function first and security last. Unlike traditional endpoints, these devices often run stripped-down firmware with no user interface, making patching and monitoring extremely difficult.

## Why it matters
In the 2016 Mirai botnet attack, attackers scanned the internet for IoT devices still using factory-default credentials (like `admin/admin`), compromised over 600,000 devices, and weaponized them into a massive DDoS that took down major DNS provider Dyn — knocking Twitter, Netflix, and Reddit offline. The defense lesson: default credential elimination and network segmentation of IoT devices are non-negotiable controls.

## Key facts
- IoT devices frequently run outdated Linux kernels or proprietary RTOS firmware that vendors never patch — creating permanent vulnerabilities
- Default credentials are the #1 IoT attack vector; Mirai's entire dictionary was just 61 username/password pairs
- IoT devices should be isolated on a separate VLAN/network segment to prevent lateral movement into corporate systems
- OWASP IoT Top 10 highlights weak passwords, insecure update mechanisms, and lack of secure boot as critical risks
- For Security+: IoT falls under "embedded systems" — also includes SCADA, ICS, HVAC controllers, and medical devices (implantable cardiac monitors)

## Related concepts
[[Botnet]] [[Default Credentials]] [[Network Segmentation]] [[Embedded Systems]] [[SCADA/ICS]]