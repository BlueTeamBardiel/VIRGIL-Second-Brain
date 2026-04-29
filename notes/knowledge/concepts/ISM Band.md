# ISM Band

## What it is
Think of ISM bands like public parks — anyone can use them without a permit, but that also means strangers can set up camp right next to you. ISM (Industrial, Scientific, and Medical) bands are unlicensed radio frequency ranges designated by the ITU for non-telecommunications use, most notably 2.4 GHz and 5 GHz, which Wi-Fi and Bluetooth operate on.

## Why it matters
Because ISM bands are unlicensed and unregulated, an attacker can legally transmit on these frequencies to create interference or jam wireless communications — a denial-of-service attack requiring no network access. In penetration testing and real attacks, tools like deauth floods and RF jammers exploit the open nature of these bands to disrupt 802.11 networks in hospitals, warehouses, or industrial control environments where wireless availability is critical.

## Key facts
- **2.4 GHz ISM band**: used by Wi-Fi (802.11b/g/n), Bluetooth, Zigbee, baby monitors, and microwave ovens — heavy congestion and interference risk
- **5 GHz ISM band**: used by Wi-Fi (802.11a/n/ac/ax) — less congested but shorter range due to higher frequency attenuation
- **900 MHz ISM band**: used by older cordless phones and some IoT/SCADA sensors — relevant in OT/ICS security contexts
- **No license required** to operate in ISM bands within power limits — attackers face no regulatory barrier to transmitting
- Rogue access points, evil twin attacks, and RF-based DoS attacks all exploit ISM band openness; detecting them requires wireless intrusion detection systems (WIDS)

## Related concepts
[[Wireless Jamming]] [[Evil Twin Attack]] [[802.11 Protocol]] [[Bluetooth Security]] [[Rogue Access Point]]