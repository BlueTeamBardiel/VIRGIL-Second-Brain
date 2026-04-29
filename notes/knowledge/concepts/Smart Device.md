# Smart Device

## What it is
Like a Swiss Army knife that also sends your location home to the factory — a smart device is any internet-connected physical object (IoT device) embedded with sensors, software, and network connectivity that can collect and exchange data without direct human interaction. Examples include thermostats, cameras, medical monitors, and industrial sensors.

## Why it matters
In 2016, the Mirai botnet compromised hundreds of thousands of smart devices (mostly IP cameras and routers) by scanning for devices still using **default factory credentials**, then weaponized them into a massive DDoS attack that took down DNS provider Dyn and disrupted Twitter, Netflix, and Reddit. This demonstrated that insecure smart devices aren't just personal risks — they become ammunition against critical infrastructure.

## Key facts
- Smart devices frequently run **embedded Linux or proprietary firmware** with no user-accessible patch mechanism, leaving vulnerabilities unaddressed for the device's entire lifespan
- The **OWASP IoT Top 10** highlights weak passwords, insecure network services, and lack of secure update mechanisms as the most critical smart device risks
- Smart devices should be **network-segmented** onto a dedicated VLAN to limit lateral movement if compromised — a core defense-in-depth principle
- Many smart devices transmit data **unencrypted over HTTP or plaintext MQTT**, making them vulnerable to man-in-the-middle interception on local networks
- Under **NIST SP 800-213**, federal agencies must assess IoT device cybersecurity capabilities before deployment, including device identity and data protection features

## Related concepts
[[IoT Security]] [[Default Credentials]] [[Network Segmentation]] [[Botnet]] [[Firmware Analysis]]