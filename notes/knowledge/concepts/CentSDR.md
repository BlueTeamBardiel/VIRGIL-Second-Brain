# CentSDR

## What it is
Like a Swiss Army knife built into a single circuit board, CentSDR is a compact, open-source Software Defined Radio (SDR) platform designed for RF signal analysis and experimentation. It replaces banks of dedicated hardware (filters, mixers, demodulators) with programmable software, allowing a single device to tune across a wide frequency spectrum and decode multiple signal types.

## Why it matters
In a red team engagement, an attacker can use CentSDR to passively intercept unencrypted wireless communications — such as legacy SCADA telemetry, pager traffic, or keyless entry signals — without ever touching the target network. Defenders can use the same hardware for RF spectrum monitoring, detecting rogue transmitters or unauthorized wireless devices operating near sensitive facilities.

## Key facts
- CentSDR operates across a broad frequency range (typically covering HF through UHF bands), making it useful for analyzing signals from AM/FM radio up through cellular and GPS frequencies
- It is a hardware implementation in the SDR family, similar in purpose to HackRF and RTL-SDR dongles, but optimized for portability and integration
- SDR platforms like CentSDR can be used to conduct replay attacks against RF-based access control systems (e.g., garage doors, car fobs) by recording and retransmitting captured signals
- Passive RF interception with SDR requires no network connection to the target and leaves no detectable log trail, making it attractive for covert reconnaissance
- Regulatory note: transmitting on certain frequencies without a license violates FCC Part 97/Part 15 rules — defenders should understand both the offensive capability and its legal boundaries

## Related concepts
[[Software Defined Radio]] [[HackRF]] [[RF Replay Attack]] [[Wireless Spectrum Analysis]] [[SCADA Security]]