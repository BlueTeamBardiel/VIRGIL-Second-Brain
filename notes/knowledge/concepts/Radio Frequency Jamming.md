# Radio Frequency Jamming

## What it is
Like a heckler shouting nonsense at a concert until no one can hear the band, RF jamming floods a wireless frequency with noise or competing signals to prevent legitimate communication. Precisely defined: it is the deliberate transmission of radio signals on the same frequency as a target system, causing a Denial of Service at the physical (Layer 1) layer. The attack requires no knowledge of encryption or protocol — raw signal interference is sufficient.

## Why it matters
In a real-world scenario, an attacker can use a cheap software-defined radio (SDR) and GNU Radio to jam 433 MHz or 915 MHz frequencies used by home security sensors, preventing door/window alerts from reaching the base station while a physical break-in occurs. This bypasses all software-level security entirely because the signal never arrives — there is nothing to decrypt or authenticate. Defenders counter this with frequency-hopping spread spectrum (FHSS), which rapidly changes channels faster than a static jammer can follow.

## Key facts
- RF jamming targets the **Physical Layer (OSI Layer 1)** — no protocol knowledge is needed to execute it
- It is illegal in the U.S. under **47 U.S.C. § 333** (FCC regulations); jammers cannot be legally sold or operated by civilians
- **Frequency-Hopping Spread Spectrum (FHSS)** and **Direct-Sequence Spread Spectrum (DSSS)** are the primary technical countermeasures
- GPS jamming is a notable variant, affecting timing signals (1575.42 MHz for GPS L1) and disrupting critical infrastructure dependent on GPS synchronization
- Wi-Fi deauthentication attacks are a **logical** cousin of jamming — both produce DoS, but deauth exploits the 802.11 protocol rather than raw RF interference

## Related concepts
[[Denial of Service]] [[Frequency Hopping Spread Spectrum]] [[Software-Defined Radio]] [[Evil Twin Attack]] [[GPS Spoofing]]