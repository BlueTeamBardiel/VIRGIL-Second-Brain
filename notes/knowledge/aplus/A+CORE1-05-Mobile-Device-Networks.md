# Mobile Device Networks

## What it is

Your phone is a body that talks. Wi-Fi, cellular, Bluetooth, NFC, GPS — these are the voices and ears of the device, the way it reaches the world beyond its glass. When the voice goes hoarse or the ears stop hearing, the rest of the body still works, but it feels broken. A phone that can't connect is a brick with a clock.

In plain English: mobile devices have multiple radios, each with its own job. When one fails — software config, hardware fault, environmental interference, carrier problem — the symptoms look similar from the user's side ("internet doesn't work") but the fix depends entirely on which radio, which layer, and which side of the connection broke.

Technically: mobile network troubleshooting covers the four primary wireless interfaces — cellular (4G LTE, 5G NR sub-6 and mmWave), Wi-Fi (2.4/5/6 GHz, Wi-Fi 6E and 7), Bluetooth (2.4 GHz, paired piconet), and NFC (13.56 MHz, near-field). Plus GPS as a passive receiver. Each has distinct failure modes, distinct configuration surfaces, and distinct symptoms that CompTIA expects you to map back to a probable cause.

## Why it matters

Helpdesk tickets for mobile connectivity are constant. Field reps whose iPad won't join the corporate Wi-Fi. Executives whose phone "stopped getting email" the moment they crossed the parking lot. Warehouse scanners that drop Bluetooth pairing every shift change. CompTIA Objective 220-1201 5.4 lists "poor/no connectivity" as a top symptom, and the trap is always the same: the user says "no internet" and the new tech immediately blames the Wi-Fi router. Half the time it's airplane mode. The other half it's something else entirely.

This topic also shows up in 220-1202 because mobile device management (MDM), VPN profiles, and certificate-based Wi-Fi auth all live at the intersection of "the phone won't connect" and "security policy says it shouldn't."

## In your build, in the enterprise

**Beat 1 — Technical depth.** A modern phone runs four radios concurrently. **Cellular** uses SIM or eSIM credentials to authenticate to a carrier tower, negotiates a band (low-band 600–900 MHz for range, mid-band 1–6 GHz for balance, mmWave 24+ GHz for stadium-grade speed at line-of-sight only). **Wi-Fi** associates to an SSID using PSK (home) or 802.1X with EAP (enterprise — usually PEAP-MSCHAPv2 or EAP-TLS with a device cert). **Bluetooth** pairs once, stores a link key, and reconnects automatically; BLE for accessories, Classic for audio. **NFC** is passive, ranges in centimeters, used for tap-to-pay and pairing handoffs. Each radio has an off switch, a software stack, an antenna, and a baseband or controller chip. Any layer can fail.

**Beat 2 — Feynman example via gaming/personal build.** You're hosting a LAN party, except half your friends bring phones for Discord voice chat and Spotify. Connectivity chaos starts immediately.

**Phone 1:** "Wi-Fi won't connect." Airplane mode off, Wi-Fi on, SSID visible, password rejected. Their phone auto-filled the old password from the last LAN party. *Forget network, re-enter creds, done.*

**Phone 2:** "Discord keeps cutting out." Their phone is hopping between your 2.4 GHz and 5 GHz bands because you named them the same SSID and their roaming threshold is aggressive. *Same SSID across bands is convenient until it isn't — band steering can thrash on weak edges.*

**Phone 3:** "Bluetooth headphones won't pair." They were paired to their laptop at home, which is also nearby and grabbed the connection first. *Bluetooth audio is monogamous — unpair from the other device or turn its Bluetooth off.*

**Phone 4:** "No signal at all." They walked into your basement. Cellular low-band can punch through a wall or two; mid-band and mmWave cannot. *Wi-Fi calling is the fix — the phone routes voice over your Wi-Fi back to the carrier core.*

**Beat 3 — Bridge to enterprise.** Same four phones, Monday morning, corporate office. Phone 1's password problem becomes a new hire whose iPhone won't join CorpWiFi — 802.1X with a device certificate pushed by Intune, MDM enrollment didn't complete, no cert, no auth. Fix is at the MDM console, not the phone. Phone 2's Discord drop becomes a Teams call dropping every time they walk between conference rooms — enterprise APs handle roaming via 802.11r/k/v fast transition, and if the phone's Wi-Fi driver doesn't support it cleanly you get a 2-second voice gap at every handoff. Phone 4's basement dead zone becomes a building interior with no cellular penetration; enterprise answer is a **distributed antenna system (DAS)** or **femtocell**, plus Wi-Fi calling enabled at the MDM policy level.

**Beat 4 — The point.** Same fundamental question every time: *which radio, which layer, which side of the connection.* Get this question into your bones — you will ask it at every helpdesk ticket, every site survey, every angry executive call for the rest of your career.

## Key facts

### The 14 symptoms — what they actually mean

| Symptom | Most likely cause | First check |
|---|---|---|
| Poor/no connectivity | Airplane mode, weak signal, wrong network, MDM profile missing | Toggle airplane mode, check signal, forget/rejoin network |
| Liquid damage | Water in port, corrosion, LCI triggered | Check liquid contact indicator — pink/red means submersion. Do not charge wet device |
| Unable to install apps | Storage full, OS out of date, app store region/account, MDM blocking | Storage first, OS version second, MDM policy third |
| Poor battery health | Age (>500 cycles), heat exposure, background apps | iOS: Settings → Battery → Battery Health. Android varies by OEM |
| Overheating | Charging while gaming, direct sun, runaway process, failing battery | Close apps, remove case, check for swollen battery |
| Stylus doesn't work | Battery dead, pairing lost, screen protector too thick, digitizer fault | Charge stylus, re-pair, remove screen protector |
| Swollen battery | Lithium decomposition — replace immediately | Stop using device. Do not puncture. Recycle properly |
| Digitizer issues | Cracked glass, water, failed touch controller, ghost touches | Reboot, test in safe mode, replace digitizer assembly |
| Degraded performance | Storage near full, thermal throttling, malware, OS bloat | Free storage, check temps, scan for malware, factory reset last |
| Broken screen | Drop damage — LCD, digitizer, or both | Visible cracks vs touch failure tells you LCD vs digitizer |
| Physically damaged ports | Lint in port, bent pins, corrosion | Flashlight + plastic pick. Never metal in a charging port |
| Improper charging | Bad cable, bad brick, dirty port, failing battery | Swap cable, swap brick, clean port — in that order |
| Malware | Sideloaded APK, malicious profile, jailbroken device | Uninstall unknown apps, remove unknown MDM profiles, factory reset if persistent |
| Cursor drift / ghost touches | Failing digitizer, screen protector interference | Reboot, remove protector, safe mode, replace digitizer |

### Connectivity-specific failure modes

**Cellular:**
- No SIM detected → reseat SIM, check tray, verify eSIM profile is active
- "Searching..." forever → reset network settings, toggle airplane mode, verify carrier outage
- Slow data despite full bars → tower congestion or deprioritized data plan; bars measure signal, not throughput
- VoLTE/Wi-Fi calling won't enable → carrier provisioning, sometimes resolved by carrier settings update

**Wi-Fi:**
- Connected but no internet → DHCP succeeded, DNS or upstream broken; forget and rejoin, or try static DNS (1.1.1.1 / 8.8.8.8)
- Won't auto-rejoin → "Auto-Join" off, or saved password rotated server-side
- 802.1X auth fails → expired user cert, expired RADIUS cert, MDM profile missing
- Captive portal won't load → cached DNS; toggle Wi-Fi or open `http://neverssl.com`

**Bluetooth:**
- Won't pair → paired to another nearby device, pairing timed out, BT cache corrupted
- Audio stutters → 2.4 GHz interference from Wi-Fi, microwave, USB 3.0 cables
- Connects then drops → low battery on accessory, or link key mismatch after firmware update

**NFC:**
- Tap-to-pay fails → screen off, NFC disabled, default payment app not set, terminal doesn't support tokenization

### CompTIA exam traps

> **CompTIA exam trap:** Swollen battery vs poor battery health. Swollen = physical bulge, immediate replacement, do not charge, fire risk. Poor health = capacity degraded below ~80%, replacement recommended but not urgent. CompTIA tests these as separate symptoms.

> **CompTIA exam trap:** Liquid damage indicator (LCI). Phones have a small sticker inside the SIM tray or charging port that turns from white to pink/red when wet. Manufacturers use it to deny warranty claims. Know what it is, where it lives, and that it's not reversible.

> **CompTIA exam trap:** "Unable to install applications" — first answer is storage, not malware. Storage full → OS update → app store account/region → MDM policy. Work the cheap checks first.

> **CompTIA exam trap:** Digitizer vs LCD. Cracked glass with working touch = LCD intact, digitizer cracked cosmetically. Black screen with working touch = LCD failed, digitizer fine. No touch but image works = digitizer failed.

## At home, at work — consumer vs enterprise

**At home:** One Wi-Fi network, one router, one carrier. Troubleshooting is linear — toggle airplane mode, restart the router, call the carrier. The user owns every layer.

**In an enterprise environment, this changes:** Wi-Fi is 802.1X with cert-based auth managed by MDM (Intune, Jamf, Workspace ONE). Cellular may include corporate eSIM profiles, Wi-Fi calling provisioning, and per-app VPN. Bluetooth may be policy-restricted. NFC payment may be disabled entirely. Every layer is a policy push from a central console.

What this means for you: a "Wi-Fi won't connect" ticket on a corporate phone is rarely a Wi-Fi problem. It's an MDM enrollment, a missing cert, an expired RADIUS chain, a conditional access policy. The fix happens in the admin console, not on the device. *Get comfortable saying "the phone is fine, the policy is wrong" — you'll say it weekly.*

## Helpdesk reality

- **"My phone won't connect to anything."** First question: is airplane mode on. You'd be amazed. Second: did they just get off a plane.
- **"Battery dies in two hours."** Check Settings → Battery for top consumers. Usually one runaway app or an email account stuck in a sync loop. Battery health screen tells you if it's hardware.
- **"Phone is hot and slow."** Close apps, remove case, check for a swollen battery — does the back bulge, does the screen lift at the edges. Swollen battery is "stop using this device today" territory.
- **"I can't install the app IT told me to install."** Storage, OS version, MDM company portal. In that order. Never promise it'll work — sometimes the app isn't approved for their device tier.
- **"My Bluetooth headset won't connect to my work phone."** Probably paired to their laptop, which won the race. Or the MDM blocks personal accessories. Check policy before troubleshooting hardware that's working fine.

## Related concepts

[[Mobile Device Hardware]] · [[Wi-Fi Standards and Frequencies]] · [[Cellular Technologies]] · [[Mobile Device Management (MDM)]] · [[Bluetooth Pairing]] · [[802.1X Authentication]] · [[Mobile Device Security]] · [[Troubleshooting Methodology]]

*Source: VIRGIL knowledge base — 2026-05-10*