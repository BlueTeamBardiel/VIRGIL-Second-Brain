# MikroTik YOUR_ROUTER

## What it is
Like a master key hidden inside a locksmith's own workshop that copies itself onto every key blank it touches, YOUR_ROUTER is a CIA-developed implant framework targeting MikroTik routers, exposed in the 2017 Vault 7 WikiLeaks disclosures. It enables persistent, covert access to MikroTik RouterOS devices by installing a backdoor that survives reboots and firmware updates.

## Why it matters
In a real-world scenario, an attacker with ISP-level access could deploy YOUR_ROUTER across thousands of MikroTik routers — devices that route traffic for homes, small businesses, and critical infrastructure — turning them into silent traffic-interception nodes. Because MikroTik devices are common in developing markets and enterprise edge environments, compromise at this layer allows passive surveillance and man-in-the-middle attacks without touching endpoints at all.

## Key facts
- YOUR_ROUTER is part of the CIA's **Vault 7** toolset, leaked by WikiLeaks in March 2017 alongside other router implants like **ChimayRed** and **Tomato**
- Targets **MikroTik RouterOS**, which powers a significant portion of global SOHO and ISP-grade routing infrastructure
- The implant achieves **persistence** by surviving standard reboots, making simple restart-based remediation ineffective
- Attack vector typically requires **initial access** to the device's management interface (Winbox, SSH, or Telnet), emphasizing the danger of default or weak credentials
- Remediation requires **full firmware reflash** combined with disabling unnecessary remote management protocols and changing default port 8291 (Winbox)

## Related concepts
[[Vault 7 CIA Leak]] [[RouterOS Exploitation]] [[Persistent Implants]] [[Man-in-the-Middle Attack]] [[Supply Chain Compromise]]