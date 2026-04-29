# RF Jamming

## What it is
Like a crowd of people all screaming at once to drown out a single speaker, RF jamming floods a radio frequency band with noise or competing signals until legitimate communication becomes impossible. It is a denial-of-service attack targeting wireless communication by intentionally transmitting interference on the same frequency used by a target device or network. The result is that receivers cannot distinguish the real signal from the noise floor.

## Why it matters
In a physical security bypass scenario, an attacker can jam the 433 MHz or 868 MHz frequency used by a wireless alarm sensor so that the sensor's "door open" alert never reaches the base station — allowing physical intrusion while the alarm system appears silent. This is a documented real-world technique used against home security systems and is why security-critical RF systems should use frequency hopping or wired backups.

## Key facts
- RF jamming is **illegal in most jurisdictions** under laws like the U.S. Communications Act (47 U.S.C. § 333); the FCC actively prosecutes jammers
- Jamming is a **layer 1 (Physical layer)** attack — it operates below encryption, authentication, or protocol-level defenses, making those controls irrelevant
- **Spot jamming** targets a single frequency; **sweep jamming** moves across a band; **barrage jamming** hits a wide spectrum simultaneously
- **Frequency hopping spread spectrum (FHSS)** and **Direct Sequence Spread Spectrum (DSSS)** are primary countermeasures, used in Wi-Fi (802.11) and Bluetooth
- Wireless intrusion detection systems (WIDS) can detect jamming by identifying sudden increases in noise floor or CRC error rates across channels

## Related concepts
[[Denial of Service]] [[Wireless Security]] [[Frequency Hopping Spread Spectrum]] [[Evil Twin Attack]] [[Physical Security]]