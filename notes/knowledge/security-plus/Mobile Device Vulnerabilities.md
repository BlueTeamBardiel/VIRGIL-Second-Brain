# Mobile Device Vulnerabilities

## What it is

In Death Stranding, Sam Porter Bridges hauls increasingly precarious cargo across hostile terrain — every container exposed to BTs, MULEs, timefall, and the occasional cliff. The more he carries, the more attack surface he wears on his back. That's exactly what mobile devices do — they are powerful computers stuffed with sensitive cargo, carried into untrusted environments by humans who lean too far forward and tip over.

A **mobile device vulnerability** is any weakness in a smartphone, tablet, or wearable — hardware, firmware, OS, app, or user behavior — that allows unauthorized access, data leakage, or device compromise.

## Why it matters

Mobile devices are corporate endpoints with consumer-grade discipline. One compromised phone can leak contacts, email, MFA tokens, VPN credentials, and cached cloud data — all over an untrusted carrier and a coffee-shop Wi-Fi. SY0-701 Objective 2.3 specifically lists **sideloading**, **jailbreaking/rooting**, and **unsupported systems** as device-related vulnerabilities; Objective 4.1 covers **MDM** as the defense. CompTIA's favorite trap: confusing **jailbreaking** (iOS) with **rooting** (Android), or treating **sideloading** as automatically malicious when it's actually just installation outside the official store — risky, not inherently evil.

## Key facts

### Core attack vectors

| Vulnerability | What it is | Why it's dangerous |
|---|---|---|
| **[[Jailbreaking]]** | Removing iOS sandboxing/signing restrictions | Disables Apple's security model; allows unsigned code |
| **[[Rooting]]** | Gaining superuser on Android | Bypasses app permission boundaries and SELinux |
| **[[Sideloading]]** | Installing apps outside official store | Skips store malware screening |
| **[[Unsupported systems]]** | Devices past vendor patch lifecycle | No fixes for known CVEs |
| **[[Bluetooth]] attacks** | Bluejacking, bluesnarfing, BlueBorne | Proximity-based data theft or RCE |
| **[[Insecure Wi-Fi]]** | Rogue APs, evil twin, [[KRACK]] | Traffic interception, credential theft |
| **[[SMS phishing]]** ([[Smishing]]) | Malicious links via text | Credential harvest, malware delivery |
| **[[Malicious apps]]** | Trojanized utilities, fake banking apps | Token theft, overlay attacks, spyware |

### Connection-method risks

- **[[Cellular]]** — vulnerable to **[[SS7]]** exploits, [[IMSI catchers]] (Stingrays), SIM swapping
- **[[Wi-Fi]]** — eavesdropping, [[on-path attacks]], rogue APs
- **[[Bluetooth]]** — pairing exploits, low-energy beacon abuse
- **[[NFC]]** — relay attacks, skimming at close range
- **[[USB]]** — **juice jacking** at public charging ports

### Deployment-model exposure

| Model | Risk profile |
|---|---|
| **[[BYOD]]** (Bring Your Own Device) | Highest — personal/work data mixed, inconsistent patching |
| **[[CYOD]]** (Choose Your Own Device) | Moderate — corporate-owned from approved list |
| **[[COPE]]** (Corporate-Owned, Personally Enabled) | Lower — corporate control, limited personal use |
| **[[COBO]]** (Corporate-Owned, Business Only) | Lowest — full lockdown |

### Defenses (the exam wants these)

- **[[Mobile Device Management]] (MDM)** — central policy, remote wipe, encryption enforcement, app allow/deny lists
- **[[Mobile Application Management]] (MAM)** — granular control of corporate apps and their data, leaves personal apps alone
- **[[Containerization]]** — cryptographically separates work data from personal
- **[[Full-disk encryption]]** — required by default on modern iOS/Android
- **[[Screen lock]] + [[biometrics]]** — minimum hygiene
- **[[Remote wipe]]** — for lost/stolen/terminated
- **[[Geofencing]] / [[geolocation]]** — restrict device function by location
- **[[Patch management]]** — retire devices past EOL; carrier-delayed Android patches are an audit finding waiting to happen
- **[[Attestation]]** — verify device hasn't been jailbroken/rooted before granting access
- **Disable **[[sideloading]]** and unknown sources via MDM policy

### CompTIA's favorite traps

- **Jailbreaking** = iOS, **rooting** = Android. Don't swap them.
- **MDM** manages the device; **MAM** manages the app. If the question is about wiping only corporate data on a BYOD phone, the answer is MAM/containerization, not MDM full wipe.
- **Sideloading** is the act; **third-party app store** is one source; the risk is unverified code, not the location itself.
- **Tethering** and **hotspot** can bridge an untrusted network into a trusted device — covered under connection methods.

## Related concepts

[[Mobile Device Management]] · [[BYOD]] · [[Jailbreaking]] · [[Rooting]] · [[Sideloading]] · [[Containerization]] · [[Smishing]] · [[Juice jacking]] · [[SIM swapping]] · [[Geofencing]] · [[Remote wipe]] · [[Attestation]]

---
*Source: VIRGIL knowledge base — 2026-05-08*