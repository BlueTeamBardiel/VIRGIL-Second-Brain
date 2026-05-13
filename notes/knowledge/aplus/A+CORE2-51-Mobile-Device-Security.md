# Mobile Device Security

## What it is

Your phone is a body in your pocket. The cameras and mic are its eyes and ears. The fingerprint sensor and Face ID are its immune system — deciding what gets in. The battery is its heart, and when the heart swells, the whole body fails. Mobile device security is the practice of keeping all of that intact when the device is being dropped, charged in airports, opened by repair shops, and pressed against the faces of users who reuse "Spring2024!" as their lock screen PIN's recovery password.

Plain English: the hardware that protects who you are (biometrics, NFC secure elements) and the hardware that *exposes* who you are when it's compromised (camera, mic, antenna placement). Both halves of the same problem.

Technical definition: the physical privacy and security subsystems of a mobile device — biometric authenticators, near-field communication secure elements, antenna/wireless cards, and the sensors and storage that contain the authentication material protecting everything else.

## Why it matters

A+ objective 220-1202 1.1 frames this as "monitor hardware and use appropriate replacement techniques," but the security angle is the part that gets techs fired. Swap a Face ID module on an iPhone with a non-genuine part and biometrics break — permanently, by design. Crack a fingerprint sensor flex cable during a battery replacement and you've just locked the user out of their banking app, their password manager, and their work MDM enrollment.

Mobile is also the most-stolen, most-lost, most-handed-to-strangers-at-repair-counters class of device in the field. Every secret the user has — saved passwords, MFA tokens, work email, photos of their driver's license they took for a DMV upload — lives behind a 6-digit PIN and a thumbprint. Your job at the helpdesk is to understand which components hold which secrets, and what breaks when each one is replaced.

## At home, at work

**Beat 1 — Technical depth.** Modern phones don't store your fingerprint or face. They store a mathematical template derived from it, encrypted inside a dedicated security chip — Apple's **Secure Enclave**, Android's **Trusted Execution Environment (TEE)** or **Titan M2** on Pixel. The biometric sensor talks directly to that chip over a dedicated bus. The main OS never sees the raw biometric data. NFC follows the same pattern: a **secure element** chip holds payment credentials, isolated from the application processor. The NFC antenna itself is usually a thin coil bonded to the back cover or wireless charging pad — touch the wrong adhesive strip during a back-glass swap and tap-to-pay dies.

**Beat 2 — Feynman: your own phone.**

**The fingerprint that "stopped working" after the screen repair:** Third-party shop swapped the display on an iPhone with a Touch ID home button. Touch ID flex cable is paired cryptographically to the logic board. Use a different button → sensor is dead, permanently, until a genuine paired part is installed. *Apple does this on purpose. The exam expects you to know it.*

**The NFC that died after a battery swap:** Pixel 7 battery replacement. Tech peeled the battery pull tabs aggressively and tore the NFC antenna flex underneath. Phone still calls, still texts, still charges. Google Pay just silently doesn't work anymore. User notices six weeks later at a vending machine. *NFC failures are invisible until someone tries to tap.*

**The "private" front camera:** Laptop webcam shutter slid open in a backpack, joined a Zoom call showing the inside of the bag for 11 minutes. Physical privacy shutters exist because software indicators (the green dot) aren't enough — malware can blind them. *Hardware kill switches beat software promises every time.*

**Beat 3 — Bridge from your phone to the enterprise.** Same hardware, different stakes. Your personal iPhone losing Face ID is annoying. A field salesperson's corporate iPhone losing Face ID means they can't authenticate into the MDM-managed VPN, can't open the Outlook container, can't approve the Authenticator push — and they're at a customer site in 40 minutes. The enterprise answer isn't "tell them to use the PIN." It's a tiered policy: MDM enforces biometric *or* a 14-character passcode, remote-wipes after 10 failed attempts, and the asset team ships a pre-enrolled replacement overnight. On corporate laptops, the security analyst's workstation has a hardware camera shutter, a mic mute key wired to a physical disconnect, and an FIDO2 hardware key in the USB-C port because biometrics alone don't meet the control framework. Same body parts. Different immune system.

**Beat 4 — The point.** Every mobile component is either a sensor, a radio, a power source, or a secret-keeper. Learn which is which. When a user hands you a device and says "fix it," your first question isn't "what's broken" — it's "what secrets does this part touch, and what breaks downstream if I replace it wrong?"

## Key facts

### Biometrics

| Type | How it works | Failure mode | Replacement note |
|---|---|---|---|
| **Fingerprint (capacitive)** | Reads ridges via electrical contact | Wet/greasy fingers, screen protectors, scarred fingertips | Often paired to logic board — non-genuine swap kills it |
| **Fingerprint (ultrasonic, under-display)** | Sound waves map ridges through OLED | Tempered glass protectors block it unless biometric-rated | Calibration required after screen swap |
| **Facial recognition (2D)** | Front camera + ML | Defeated by photos, low light fails | Camera replacement may need recalibration |
| **Facial recognition (3D/IR dot projector)** | Apple Face ID, dot projector + IR camera | Sunglasses, masks (pre-2022 models) | Dot projector damage = no Face ID, ever, until genuine part installed |
| **Iris scan** | IR camera reads iris pattern | Rare on current devices, mostly Samsung legacy | — |

Biometrics are **something you are** — one factor. Enterprise policy almost always pairs them with **something you have** (the device itself, or a hardware token) to satisfy MFA requirements.

### Near-field scanner features

NFC operates around 13.56 MHz at a range of ~4 cm. Three modes the exam cares about:

- **Card emulation** — phone *acts as* a contactless card (Apple Pay, Google Pay, transit, badge readers)
- **Reader/writer** — phone *reads* a tag (NFC stickers, posters, asset tags)
- **Peer-to-peer** — two devices exchange data (largely deprecated in favor of Bluetooth handoff)

Payment credentials live in the **secure element**, never on the application processor. When the phone is locked, the secure element refuses to broadcast payment tokens — biometric or PIN unlock is what authorizes the transaction. This is why a stolen, locked phone can't be tapped at a register.

### Wireless cards and antennas

Mobile devices have stacks of radios: cellular (4G LTE / 5G), Wi-Fi (2.4 / 5 / 6 GHz), Bluetooth, NFC, GPS, sometimes UWB (ultra-wideband, used for AirTag-style precision location). On phones, the **antennas are integrated into the frame** — the metal band on an iPhone is the antenna, segmented by plastic gaps. On laptops, antennas run up the display bezel; the wireless card sits on the motherboard or in an M.2 slot connected by **two coax pigtails (Main and Aux)**. Pinch a pigtail in the hinge during a display reassembly and Wi-Fi range craters to "only works in the same room as the router."

### Physical privacy components

- **Camera shutters** — physical sliding cover, common on business laptops (ThinkPad ThinkShutter, HP Privacy Camera)
- **Mic mute switch** — hardware-disconnects the mic, often paired with a status LED on enterprise laptops
- **Privacy screens** — polarized filter, viewing angle restricted to ~60°. Standard issue for analysts, finance, anyone working in airports
- **Hardware kill switches** — Framework laptops, Librem, some Dell Latitudes. Cuts power to camera/mic at the bus level
- **Faraday sleeves** — for executive travel and digital forensics chain of custody

### CompTIA exam traps

> **CompTIA exam trap:** Biometric data is stored on the device, not in the cloud. The Secure Enclave / TEE never transmits the template off the chip. If a question implies "Apple has a database of your fingerprints," it's wrong.

> **CompTIA exam trap:** NFC range is ~4 cm, not 4 meters. Don't confuse it with Bluetooth (~10 m) or RFID (varies, but passive HF RFID is similar to NFC — active UHF RFID reaches meters).

> **CompTIA exam trap:** Replacing a battery doesn't require pairing on most devices, but on recent iPhones the battery health reporting requires genuine-part authentication. The phone still *works* with a third-party battery; the **Battery Health** menu just shows a warning. Know the difference between "won't function" and "throws a warning."

> **CompTIA exam trap:** SSD/storage on a phone is **soldered to the logic board** on nearly every modern flagship. You don't "replace the SSD" on an iPhone or Pixel — you replace the logic board, which is a different repair entirely and loses all data unless properly migrated.

## Helpdesk reality

- **"My fingerprint stopped working after I got my screen fixed."** → Third-party repair, non-genuine paired part. On iPhone, sometimes recoverable by reinstalling the original Touch ID flex; on Face ID models, the dot projector damage is usually permanent. Set expectation early: they'll be using their passcode for the life of the device.
- **"Tap-to-pay just won't work anymore."** → NFC antenna damage from a recent repair, or the user disabled NFC in settings, or their card issuer pushed a token re-provision they ignored. Check settings first, then suspect physical damage.
- **"I think my camera turned on by itself."** → Check the OS-level indicator history (iOS Privacy Report, Android dashboard). Usually a legitimate app with permissions the user forgot about. If the green/orange indicator is appearing with no app open, escalate — that's potentially malware territory.
- **"Can you just unlock my old phone? I forgot the PIN."** → No. That's not a thing you can do, and you wouldn't want to be able to. If you *could*, every stolen phone in the world would be unlockable at a strip-mall repair shop. Direct them to the OEM account recovery flow and accept the data may be gone.
- **"The repair shop wants my Apple ID password to fix the screen."** → Never. No legitimate repair requires the account password. That's a credential-harvest attempt or a shop trying to bypass Activation Lock on a stolen device. Walk away.

## Related concepts

[[Mobile Device Hardware]] · [[Biometric Authentication]] · [[Multi-Factor Authentication]] · [[Mobile Device Management (MDM)]] · [[NFC and Contactless Payments]] · [[Wireless Standards]] · [[Physical Security]] · [[BYOD and Corporate Mobile Policy]]

*Source: VIRGIL knowledge base — 2026-05-11*