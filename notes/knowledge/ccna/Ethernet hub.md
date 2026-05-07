# Ethernet hub

## What it is

A group chat where every single message gets sent to everyone, even when you're trying to DM one person — that's an Ethernet hub. You ping Beatrice, but Dante, Virgil, and Francesca all get the message too. They're just polite enough (in theory) to ignore the ones not addressed to them.

Technically, a hub is a Layer 1 (Physical) device. It takes whatever electrical signal comes in on one port and blindly repeats it out every other port. It doesn't read the frame. It doesn't know what a MAC address is. It doesn't know what a frame *is*. It's a dumb signal repeater with extra RJ45 jacks — closer to a power strip than to a router.

## Why it matters

Hubs are the reason switches exist, and understanding what's wrong with them is how you understand what a switch actually does for you.

Every device on a hub shares one **collision domain**. Think of an old Counter-Strike voice channel with no push-to-talk — if two people talk at the same time, it's garbled and both have to repeat themselves. Ethernet handles this with CSMA/CD: devices listen first, transmit if quiet, and if two transmit simultaneously they detect the collision, back off for a random interval, and retry. Throughput tanks the more devices you add.

For an attacker, a hub is a gift. Since every frame is rebroadcast to every port, plugging in a laptop with Wireshark in promiscuous mode gives you the entire segment's traffic — credentials, unencrypted protocols, internal API calls, all of it. No ARP spoofing. No MAC flooding. No CAM table overflow. Just **passive listening**, which is why this is genuinely scary in the few places hubs still live: legacy OT/SCADA floors running ancient PLCs and HMIs that nobody wants to touch because the last engineer who understood the wiring retired in 2014.

It also dodges most IDS detection. ARP spoofing on a switched network throws off gratuitous ARPs, duplicate MAC bindings, and timing anomalies that anomaly-based IDS picks up. Sniffing on a hub generates zero anomalous packets — the attacker transmits nothing. They just receive what the hub was already going to send them anyway.

## Key facts

- **OSI Layer 1 (Physical).** It moves voltages, not frames. No MAC awareness, no IP awareness, no logic.
- **Rebroadcasts to all ports.** Like Among Us proximity chat with infinite range — every connected NIC hears every transmission.
- **Single collision domain.** Only one device can successfully transmit at a time. Add more devices and effective bandwidth per device drops hard.
- **CSMA/CD applies.** Listen before talk, detect collisions mid-transmission, back off randomly, retry. The Dark Souls of media access — patient, polite, painful.
- **Single broadcast domain.** Every frame, broadcast or unicast, hits every port.
- **Passive sniffing is trivial.** Plug in, set NIC to promiscuous mode, capture. No injection required.
- **Obsolete in modern networks.** Replaced by switches, which forward frames only out the port matching the destination MAC (after learning it via the CAM table).
- **Still found in legacy OT/SCADA.** Industrial control environments where uptime trumps upgrades and "if it ain't broke" is doctrine.
- **Hub-based sniffing evades IDS better than switch-based MITM.** ARP spoofing leaves footprints (duplicate MAC-to-IP bindings, gratuitous ARP storms); hub sniffing leaves none because the attacker never transmits to capture.
- **Half-duplex by nature.** A hub can't logically support full-duplex — if everyone could send and receive simultaneously on a shared medium, collisions would be guaranteed, not occasional.

## Related concepts

[[Ethernet switch]]
[[Collision domain]]
[[Broadcast domain]]
[[CSMA/CD]]
[[Promiscuous mode]]
[[ARP spoofing]]
[[CAM table overflow]]
[[OT and SCADA security]]
[[OSI model - Layer 1 Physical]]
[[Network sniffing]]