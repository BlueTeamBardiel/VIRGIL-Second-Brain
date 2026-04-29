# Reading infrared signals

## What it is
Like intercepting a conversation between a TV remote and its receiver by standing in the path of the beam with a camera, reading infrared (IR) signals means capturing and decoding the modulated light pulses that IR devices use to communicate. IR communication transmits data as bursts of near-invisible light (typically 850–950nm wavelength) that carry encoded commands using protocols like NEC, RC-5, or Philips RC-6. Because IR is light, not radio, it travels line-of-sight and can be captured by any photodiode or camera sensor sensitive to that spectrum.

## Why it matters
An attacker with physical proximity to a secure facility can capture IR signals from a building automation or HVAC control system using a modified smartphone camera (which often detects IR) and then replay those signals to manipulate environmental controls or unlock IR-controlled door systems. This exact vector was demonstrated against industrial control systems where IR serial interfaces were used for configuration — capture once, replay indefinitely.

## Key facts
- IR signals are **not encrypted by default** in most consumer and industrial protocols; raw capture equals full command access
- Standard smartphone cameras with IR filters removed can visualize and record IR signals, requiring zero specialized hardware
- The **NEC protocol** encodes data as pulse-distance modulation at 38kHz carrier frequency — the most common consumer IR standard
- IR replay attacks are a subset of **replay attacks** and bypass challenge-response authentication unless rolling codes are implemented
- IR is used in **serial console ports** on some network devices (IrDA standard, 115.2kbps max), making physical IR sniffing a lateral movement vector

## Related concepts
[[Replay Attacks]] [[Side-Channel Attacks]] [[Physical Security Controls]] [[IrDA Protocol]] [[Signal Interception]]