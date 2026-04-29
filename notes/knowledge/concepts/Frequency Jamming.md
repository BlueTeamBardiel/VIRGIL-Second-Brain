# Frequency Jamming

## What it is
Like a heckler screaming gibberish into a megaphone during a speech so the audience can't hear the speaker, frequency jamming floods a radio frequency with noise or competing signals to drown out legitimate communications. Precisely defined, it is a radio frequency (RF) denial-of-service attack that renders a wireless channel unusable by overwhelming it with interference, preventing receivers from decoding valid transmissions.

## Why it matters
Jamming is a practical threat to physical security systems: an attacker outside a home can broadcast noise on 433 MHz or 315 MHz — the frequencies used by many wireless alarm sensors and garage door openers — causing the sensors to fail silently while the attacker breaks in. Because the alarm system never "hears" the door-open signal, no alert fires. This technique has been documented in real vehicle theft campaigns targeting keyless-entry fobs.

## Key facts
- Jamming is illegal in the US under 47 U.S.C. § 333; the FCC prohibits operating, marketing, or importing jammers regardless of intent.
- Types include **spot jamming** (one frequency), **sweep jamming** (scanning across a range), and **barrage jamming** (wide-band simultaneous noise across many frequencies).
- Wi-Fi deauthentication floods are a *protocol-layer* analog to jamming but jamming is strictly a *physical-layer* (Layer 1) attack.
- Detection uses a **spectrum analyzer** to identify abnormal signal energy on a channel; sudden RSSI elevation with no legitimate source is a telltale indicator.
- Countermeasures include **frequency hopping spread spectrum (FHSS)** and **direct-sequence spread spectrum (DSSS)**, which make signals harder to jam by distributing them across many frequencies.

## Related concepts
[[Wireless Denial of Service]] [[Deauthentication Attack]] [[Spread Spectrum]] [[RF Spoofing]] [[Evil Twin Attack]]