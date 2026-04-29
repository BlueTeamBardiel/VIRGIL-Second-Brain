# rogue device

## What it is
Like a stranger plugging a personal space heater into your office's power strip — it's using your infrastructure without permission and potentially overloading it. A rogue device is any unauthorized hardware connected to a network that bypasses security controls, including rogue access points, unauthorized switches, personal laptops, or malicious implants planted by an attacker.

## Why it matters
In 2008, attackers installed rogue hardware keyloggers inside Walmart self-checkout kiosks to harvest payment card data — the devices blended physically into the environment while silently exfiltrating data. Defenders counter this through 802.1X port-based authentication, which forces every device to cryptographically prove identity before network access is granted, effectively making plugging in unauthorized hardware useless.

## Key facts
- A **rogue access point** mimics a legitimate Wi-Fi SSID to lure users into connecting — often called an **evil twin** when deliberately spoofing a known network
- **802.1X with EAP** is the primary control to prevent unauthorized wired/wireless devices from gaining network access
- Rogue devices are detected through **wireless site surveys**, **NAC (Network Access Control)** solutions, and **DHCP log analysis** for unknown MAC addresses
- A **Pineapple** (Wi-Fi Pineapple) is a commercial pen-testing tool commonly weaponized as a rogue AP — frequently tested on Security+ exams
- Physical security gaps (unlocked server rooms, exposed Ethernet jacks in lobbies) are the most common enablers of rogue device placement

## Related concepts
[[evil twin attack]] [[802.1X authentication]] [[Network Access Control]] [[wireless site survey]] [[MAC address filtering]]